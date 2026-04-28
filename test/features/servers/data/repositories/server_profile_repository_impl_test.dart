import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';

import 'package:mcp_visualizer/core/errors/mcp_failure.dart';
import 'package:mcp_visualizer/core/utils/platform_utils.dart';
import 'package:mcp_visualizer/features/servers/data/datasources/server_profile_local_datasource.dart';
import 'package:mcp_visualizer/features/servers/data/repositories/server_profile_repository_impl.dart';
import 'package:mcp_visualizer/features/servers/domain/models/server_profile.dart';

// ---------------------------------------------------------------------------
// Fake datasource — implements the concrete class interface without inheritance
// ---------------------------------------------------------------------------

class _FakeDatasource implements ServerProfileLocalDatasource {
  List<ServerProfile> _profiles = [];
  Object? _readError;
  Object? _writeError;

  void seedProfiles(List<ServerProfile> profiles) =>
      _profiles = List.of(profiles);
  void throwOnRead(Object error) => _readError = error;
  void throwOnWrite(Object error) => _writeError = error;

  @override
  List<ServerProfile> readAll() {
    if (_readError != null) throw _readError!;
    return List.of(_profiles);
  }

  @override
  Future<void> writeAll(List<ServerProfile> profiles) async {
    if (_writeError != null) throw _writeError!;
    _profiles = List.of(profiles);
  }
}

// ---------------------------------------------------------------------------
// Helpers
// ---------------------------------------------------------------------------

ServerProfile _makeProfile({String id = 'id-1', String name = 'Test'}) =>
    ServerProfile(
      id: id,
      name: name,
      transportType: TransportType.sse,
      url: 'http://localhost:3000',
    );

// ---------------------------------------------------------------------------
// Secure storage channel mock
// ---------------------------------------------------------------------------

const _kSecureStorageChannel = MethodChannel(
  'plugins.it_nomads.com/flutter_secure_storage',
);

final Map<String, String?> _secureStore = {};

void _setupSecureStorageMock() {
  TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
      .setMockMethodCallHandler(_kSecureStorageChannel, (call) async {
        switch (call.method) {
          case 'write':
            _secureStore[call.arguments['key'] as String] =
                call.arguments['value'] as String?;
            return null;
          case 'read':
            return _secureStore[call.arguments['key'] as String];
          case 'delete':
            _secureStore.remove(call.arguments['key'] as String);
            return null;
          default:
            return null;
        }
      });
}

// ---------------------------------------------------------------------------
// Tests
// ---------------------------------------------------------------------------

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late _FakeDatasource fakeDatasource;
  late FlutterSecureStorage secureStorage;
  late ServerProfileRepositoryImpl repository;

  setUp(() {
    _secureStore.clear();
    _setupSecureStorageMock();
    fakeDatasource = _FakeDatasource();
    secureStorage = const FlutterSecureStorage();
    repository = ServerProfileRepositoryImpl(fakeDatasource, secureStorage);
  });

  // -------------------------------------------------------------------------
  // getAll
  // -------------------------------------------------------------------------

  group('getAll', () {
    test('returns empty list when datasource has no profiles', () async {
      final result = await repository.getAll().run();
      expect(result, isA<Right<McpFailure, List<ServerProfile>>>());
      expect(result.getOrElse((_) => []), isEmpty);
    });

    test('returns all profiles from datasource', () async {
      final profiles = [_makeProfile(id: 'a'), _makeProfile(id: 'b')];
      fakeDatasource.seedProfiles(profiles);

      final result = await repository.getAll().run();

      expect(result.isRight(), isTrue);
      final returned = result.getOrElse((_) => []);
      expect(returned.map((p) => p.id), containsAll(['a', 'b']));
    });

    test('returns SerializationFailure when datasource throws', () async {
      fakeDatasource.throwOnRead(FormatException('bad json'));

      final result = await repository.getAll().run();

      expect(result.isLeft(), isTrue);
      result.fold(
        (failure) => expect(failure, isA<SerializationFailure>()),
        (_) => fail('expected Left'),
      );
    });
  });

  // -------------------------------------------------------------------------
  // getById
  // -------------------------------------------------------------------------

  group('getById', () {
    test('returns profile when it exists', () async {
      final profile = _makeProfile(id: 'abc');
      fakeDatasource.seedProfiles([profile]);

      final result = await repository.getById('abc').run();

      expect(result.isRight(), isTrue);
      result.fold((_) => fail('expected Right'), (p) => expect(p.id, 'abc'));
    });

    test('returns UnknownFailure when profile is not found', () async {
      fakeDatasource.seedProfiles([]);

      final result = await repository.getById('missing').run();

      expect(result.isLeft(), isTrue);
      result.fold(
        (failure) => expect(failure, isA<UnknownFailure>()),
        (_) => fail('expected Left'),
      );
    });

    test('returns UnknownFailure when datasource throws', () async {
      fakeDatasource.throwOnRead(Exception('storage error'));

      final result = await repository.getById('any').run();

      expect(result.isLeft(), isTrue);
      result.fold(
        (failure) => expect(failure, isA<UnknownFailure>()),
        (_) => fail('expected Left'),
      );
    });
  });

  // -------------------------------------------------------------------------
  // save
  // -------------------------------------------------------------------------

  group('save', () {
    test('adds a new profile when it does not already exist', () async {
      final profile = _makeProfile(id: 'new-id');

      final result = await repository.save(profile).run();

      expect(result.isRight(), isTrue);
      expect(fakeDatasource.readAll().any((p) => p.id == 'new-id'), isTrue);
    });

    test('updates an existing profile in place', () async {
      final original = _makeProfile(id: 'x', name: 'Original');
      fakeDatasource.seedProfiles([original]);
      final updated = original.copyWith(name: 'Updated');

      final result = await repository.save(updated).run();

      expect(result.isRight(), isTrue);
      final stored = fakeDatasource.readAll();
      expect(stored.length, 1);
      expect(stored.first.name, 'Updated');
    });

    test('returns SerializationFailure when writeAll throws', () async {
      fakeDatasource.throwOnWrite(Exception('disk full'));

      final result = await repository.save(_makeProfile()).run();

      expect(result.isLeft(), isTrue);
      result.fold(
        (failure) => expect(failure, isA<SerializationFailure>()),
        (_) => fail('expected Left'),
      );
    });
  });

  // -------------------------------------------------------------------------
  // delete
  // -------------------------------------------------------------------------

  group('delete', () {
    test('removes the profile from storage', () async {
      fakeDatasource.seedProfiles([_makeProfile(id: 'del-1')]);

      final result = await repository.delete('del-1').run();

      expect(result.isRight(), isTrue);
      expect(fakeDatasource.readAll().any((p) => p.id == 'del-1'), isFalse);
    });

    test('also deletes the auth token from secure storage', () async {
      _secureStore['del-2'] = 'secret-token';
      fakeDatasource.seedProfiles([_makeProfile(id: 'del-2')]);

      await repository.delete('del-2').run();

      expect(_secureStore.containsKey('del-2'), isFalse);
    });

    test('returns UnknownFailure when datasource throws on read', () async {
      fakeDatasource.throwOnRead(Exception('read error'));

      final result = await repository.delete('any').run();

      expect(result.isLeft(), isTrue);
      result.fold(
        (failure) => expect(failure, isA<UnknownFailure>()),
        (_) => fail('expected Left'),
      );
    });
  });

  // -------------------------------------------------------------------------
  // saveAuthToken / readAuthToken
  // -------------------------------------------------------------------------

  group('saveAuthToken / readAuthToken', () {
    test('stores and retrieves an auth token', () async {
      await repository.saveAuthToken('profile-1', 'tok-abc');
      final token = await repository.readAuthToken('profile-1');
      expect(token, 'tok-abc');
    });

    test('returns null for a token that was never saved', () async {
      final token = await repository.readAuthToken('nonexistent');
      expect(token, isNull);
    });

    test('overwriting a token replaces the old value', () async {
      await repository.saveAuthToken('p', 'old');
      await repository.saveAuthToken('p', 'new');
      expect(await repository.readAuthToken('p'), 'new');
    });
  });
}
