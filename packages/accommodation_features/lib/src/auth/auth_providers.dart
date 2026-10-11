import 'package:accommodation_core/accommodation_core.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../common/dependencies.dart';
part 'auth_providers.g.dart';

@Riverpod(keepAlive: true)
AuthRemoteDataSource authRemoteDataSource(Ref ref) {
  return AuthRemoteDataSource(ref.watch(apiClientProvider));
}

@Riverpod(keepAlive: true)
AuthRepository authRepository(Ref ref) {
  return AuthRepository(ref.watch(authRemoteDataSourceProvider));
}

@Riverpod(keepAlive: true)
class AuthController extends _$AuthController {
  @override
  Future<AuthUser?> build() async {
    final storage = ref.watch(tokenStorageProvider);
    final repository = ref.watch(authRepositoryProvider);
    final tenant = ref.watch(tenantSlugProvider);

    final token = await storage.readToken();

    if (token == null || token.isEmpty) {
      return null;
    }

    final result = await repository.getCurrentUser(accessToken: token);

    return result.fold(
      (failure) async {
        if (failure.statusCode == 401) {
          await storage.deleteToken();
          return null;
        }

        throw AuthSessionRestoreException(failure);
      },
      (user) async {
        if (user.tenantId != tenant.name) {
          await storage.deleteToken();
          return null;
        }

        return user;
      },
    );
  }

  Future<Either<ApiFailure, AuthUser>> login({
    required String email,
    required String password,
    required String language,
  }) {
    return _authenticate(
      ref
          .read(authRepositoryProvider)
          .login(email: email, password: password, language: language),
    );
  }

  Future<Either<ApiFailure, AuthUser>> register({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String language,
  }) {
    return _authenticate(
      ref
          .read(authRepositoryProvider)
          .register(
            email: email,
            password: password,
            firstName: firstName,
            lastName: lastName,
            language: language,
          ),
    );
  }

  Future<Either<ApiFailure, AuthUser>> _authenticate(
    Future<Either<ApiFailure, AuthSession>> operation,
  ) async {
    final result = await operation;

    return result.fold<Future<Either<ApiFailure, AuthUser>>>(
      (failure) async => Left(failure),
      (session) async {
        final tenant = ref.read(tenantSlugProvider);

        if (session.user.tenantId != tenant.name) {
          return Left(
            const ApiFailure(
              type: ApiFailureType.invalidResponse,
              message: 'The authenticated user belongs to another tenant.',
            ),
          );
        }

        await ref.read(tokenStorageProvider).saveToken(session.accessToken);

        state = AsyncData(session.user);

        return Right(session.user);
      },
    );
  }

  Future<Either<ApiFailure, bool>> logout() async {
    final storage = ref.read(tokenStorageProvider);
    final repository = ref.read(authRepositoryProvider);
    final token = await storage.readToken();

    final result = token == null || token.isEmpty
        ? const Right<ApiFailure, bool>(true)
        : await repository.logout(accessToken: token);

    await storage.deleteToken();
    state = const AsyncData(null);

    return result;
  }
}

class AuthSessionRestoreException implements Exception {
  const AuthSessionRestoreException(this.failure);

  final ApiFailure failure;

  @override
  String toString() {
    return failure.message ?? 'Unable to restore the authentication session.';
  }
}
