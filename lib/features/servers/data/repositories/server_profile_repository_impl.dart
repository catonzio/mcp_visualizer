import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fpdart/fpdart.dart';

import 'package:mcp_visualizer/core/errors/mcp_failure.dart';
import 'package:mcp_visualizer/features/servers/data/datasources/server_profile_local_datasource.dart';
import 'package:mcp_visualizer/features/servers/domain/models/server_profile.dart';
import 'package:mcp_visualizer/features/servers/domain/repositories/server_profile_repository.dart';

class ServerProfileRepositoryImpl implements ServerProfileRepository {
  ServerProfileRepositoryImpl(this._datasource, this._secureStorage);

  final ServerProfileLocalDatasource _datasource;
  final FlutterSecureStorage _secureStorage;

  @override
  TaskEither<McpFailure, List<ServerProfile>> getAll() {
    return TaskEither.tryCatch(
      () async => _datasource.readAll(),
      (e, _) => McpFailure.serialization(message: e.toString(), cause: e),
    );
  }

  @override
  TaskEither<McpFailure, ServerProfile> getById(String id) {
    return TaskEither.tryCatch(() async {
      final all = _datasource.readAll();
      final profile = all.where((p) => p.id == id).firstOrNull;
      if (profile == null) {
        throw StateError('Profile $id not found');
      }
      return profile;
    }, (e, _) => McpFailure.unknown(message: e.toString(), cause: e));
  }

  @override
  TaskEither<McpFailure, Unit> save(ServerProfile profile) {
    return TaskEither.tryCatch(() async {
      final all = _datasource.readAll();
      final idx = all.indexWhere((p) => p.id == profile.id);
      if (idx >= 0) {
        all[idx] = profile;
      } else {
        all.add(profile);
      }
      await _datasource.writeAll(all);
      return unit;
    }, (e, _) => McpFailure.serialization(message: e.toString(), cause: e));
  }

  @override
  TaskEither<McpFailure, Unit> delete(String id) {
    return TaskEither.tryCatch(() async {
      final all = _datasource.readAll();
      all.removeWhere((p) => p.id == id);
      await _datasource.writeAll(all);
      // Remove stored auth token if any
      await _secureStorage.delete(key: id);
      return unit;
    }, (e, _) => McpFailure.unknown(message: e.toString(), cause: e));
  }

  /// Store a plaintext auth token securely, keyed by profile ID.
  Future<void> saveAuthToken(String profileId, String token) async {
    await _secureStorage.write(key: profileId, value: token);
  }

  /// Retrieve the auth token for a profile.
  Future<String?> readAuthToken(String profileId) async {
    return _secureStorage.read(key: profileId);
  }
}
