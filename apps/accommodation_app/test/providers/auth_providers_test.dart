import 'dart:async';

import 'package:accommodation_app/providers/auth_providers.dart';
import 'package:accommodation_app/providers/runtime_config_providers.dart';
import 'package:accommodation_core/accommodation_core.dart';
import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

const testUser = AuthUser(
  id: 'client-1',
  tenantId: 'alpine',
  role: UserRole.client,
  email: 'client@example.com',
  firstName: 'Alex',
  lastName: 'Smith',
);

const testSession = AuthSession(accessToken: 'test-token', user: testUser);

class FakeTokenStorage implements TokenStorage {
  String? token;
  bool deleted = false;

  @override
  Future<String?> readToken() async => token;

  @override
  Future<void> saveToken(String value) async {
    token = value;
    deleted = false;
  }

  @override
  Future<void> deleteToken() async {
    token = null;
    deleted = true;
  }
}

class FakeAuthRepository extends AuthRepository {
  FakeAuthRepository() : super(AuthRemoteDataSource(Dio()));

  Either<ApiFailure, AuthUser> currentUserResult = const Right(testUser);

  Either<ApiFailure, AuthSession> loginResult = const Right(testSession);

  String? requestedToken;

  @override
  Future<Either<ApiFailure, AuthUser>> getCurrentUser({
    required String accessToken,
  }) async {
    requestedToken = accessToken;
    return currentUserResult;
  }

  @override
  Future<Either<ApiFailure, AuthSession>> login({
    required String email,
    required String password,
    required String language,
  }) async {
    return loginResult;
  }
}

void main() {
  late FakeTokenStorage storage;
  late FakeAuthRepository repository;
  late ProviderContainer container;

  setUp(() {
    storage = FakeTokenStorage();
    repository = FakeAuthRepository();

    container = ProviderContainer(
      overrides: [
        tokenStorageProvider.overrideWith((ref) => storage),
        authRepositoryProvider.overrideWith((ref) => repository),
        tenantSlugProvider.overrideWith((ref) => TenantSlug.alpine),
      ],
    );
  });

  tearDown(() {
    container.dispose();
  });

  test('starts signed out when no token is saved', () async {
    final user = await container.read(authControllerProvider.future);

    expect(user, isNull);
    expect(storage.deleted, isFalse);
    expect(repository.requestedToken, isNull);
  });

  test('restores the user from a valid saved token', () async {
    storage.token = 'saved-token';

    final user = await container.read(authControllerProvider.future);

    expect(repository.requestedToken, 'saved-token');
    expect(user, testUser);
    expect(storage.token, 'saved-token');
  });

  test('deletes a revoked token and signs out', () async {
    storage.token = 'revoked-token';
    repository.currentUserResult = const Left(
      ApiFailure(type: ApiFailureType.http, statusCode: 401),
    );

    final user = await container.read(authControllerProvider.future);

    expect(user, isNull);
    expect(storage.token, isNull);
    expect(storage.deleted, isTrue);
  });

  test(
    'preserves the token when restoration fails due to network error',
    () async {
      storage.token = 'saved-token';
      repository.currentUserResult = const Left(
        ApiFailure(type: ApiFailureType.network),
      );

      final completer = Completer<AsyncValue<AuthUser?>>();

      final subscription = container.listen(authControllerProvider, (
        previous,
        next,
      ) {
        if (next.hasError && !completer.isCompleted) {
          completer.complete(next);
        }
      }, fireImmediately: true);

      // Reading the provider starts restoration.
      container.read(authControllerProvider);

      final state = await completer.future;
      subscription.close();

      expect(state.hasError, isTrue);
      expect(storage.token, 'saved-token');
      expect(storage.deleted, isFalse);
    },
  );

  test('saves the token and updates state after successful login', () async {
    final result = await container
        .read(authControllerProvider.notifier)
        .login(
          email: 'client@example.com',
          password: 'password123',
          language: 'en',
        );

    expect(result.isRight(), isTrue);
    expect(storage.token, 'test-token');

    final state = container.read(authControllerProvider);

    expect(state.requireValue, testUser);
  });
}
