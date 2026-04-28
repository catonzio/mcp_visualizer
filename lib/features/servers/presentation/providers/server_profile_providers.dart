import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:mcp_visualizer/core/errors/mcp_failure.dart';
import 'package:mcp_visualizer/features/servers/data/datasources/server_profile_local_datasource.dart';
import 'package:mcp_visualizer/features/servers/data/repositories/server_profile_repository_impl.dart';
import 'package:mcp_visualizer/features/servers/domain/models/server_profile.dart';
import 'package:mcp_visualizer/features/servers/domain/repositories/server_profile_repository.dart';

// ---------------------------------------------------------------------------
// Infrastructure providers
// ---------------------------------------------------------------------------

final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError(
    'Override sharedPreferencesProvider in ProviderScope',
  );
});

final secureStorageProvider = Provider<FlutterSecureStorage>((ref) {
  return const FlutterSecureStorage();
});

final serverProfileDatasourceProvider = Provider<ServerProfileLocalDatasource>((
  ref,
) {
  return ServerProfileLocalDatasource(ref.watch(sharedPreferencesProvider));
});

final serverProfileRepositoryProvider = Provider<ServerProfileRepository>((
  ref,
) {
  return ServerProfileRepositoryImpl(
    ref.watch(serverProfileDatasourceProvider),
    ref.watch(secureStorageProvider),
  );
});

// ---------------------------------------------------------------------------
// Read provider
// ---------------------------------------------------------------------------

final serverProfileListProvider = FutureProvider<List<ServerProfile>>((
  ref,
) async {
  final repo = ref.watch(serverProfileRepositoryProvider);
  final result = await repo.getAll().run();
  return result.fold(
    (failure) => throw _failureToException(failure),
    (profiles) => profiles,
  );
});

// ---------------------------------------------------------------------------
// Mutation notifier
// ---------------------------------------------------------------------------

class ServerProfileNotifier extends AsyncNotifier<List<ServerProfile>> {
  @override
  Future<List<ServerProfile>> build() async {
    final repo = ref.watch(serverProfileRepositoryProvider);
    final result = await repo.getAll().run();
    return result.fold(
      (failure) => throw _failureToException(failure),
      (profiles) => profiles,
    );
  }

  Future<void> save(ServerProfile profile) async {
    final repo = ref.read(serverProfileRepositoryProvider);
    state = const AsyncLoading();
    final result = await repo.save(profile).run();
    result.fold(
      (failure) =>
          state = AsyncError(_failureToException(failure), StackTrace.current),
      (_) => ref.invalidateSelf(),
    );
  }

  Future<void> delete(String id) async {
    final repo = ref.read(serverProfileRepositoryProvider);
    state = const AsyncLoading();
    final result = await repo.delete(id).run();
    result.fold(
      (failure) =>
          state = AsyncError(_failureToException(failure), StackTrace.current),
      (_) => ref.invalidateSelf(),
    );
  }
}

final serverProfileNotifierProvider =
    AsyncNotifierProvider<ServerProfileNotifier, List<ServerProfile>>(
      ServerProfileNotifier.new,
    );

// ---------------------------------------------------------------------------
// Helpers
// ---------------------------------------------------------------------------

Exception _failureToException(McpFailure failure) =>
    Exception(failure.userMessage);
