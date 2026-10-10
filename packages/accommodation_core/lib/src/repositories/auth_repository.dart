import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';

import '../data/auth_remote_data_source.dart';
import '../models/auth_session.dart';
import '../networking/api_failure.dart';

class AuthRepository {
  const AuthRepository(this._remoteDataSource);

  final AuthRemoteDataSource _remoteDataSource;

  Future<Either<ApiFailure, AuthSession>> register({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String language,
  }) {
    return _run(
      () => _remoteDataSource.register(
        email: email,
        password: password,
        firstName: firstName,
        lastName: lastName,
        language: language,
      ),
    );
  }

  Future<Either<ApiFailure, AuthSession>> login({
    required String email,
    required String password,
    required String language,
  }) {
    return _run(
      () => _remoteDataSource.login(
        email: email,
        password: password,
        language: language,
      ),
    );
  }

  Future<Either<ApiFailure, AuthUser>> getCurrentUser({
    required String accessToken,
  }) {
    return _run(
      () => _remoteDataSource.getCurrentUser(accessToken: accessToken),
    );
  }

  Future<Either<ApiFailure, bool>> logout({required String accessToken}) async {
    final result = await _run(
      () => _remoteDataSource.logout(accessToken: accessToken),
    );

    return result.map((_) => true);
  }

  Future<Either<ApiFailure, T>> _run<T>(Future<T> Function() operation) async {
    try {
      return Right(await operation());
    } on DioException catch (error) {
      return Left(
        ApiFailure(
          type: error.response == null
              ? ApiFailureType.network
              : ApiFailureType.http,
          statusCode: error.response?.statusCode,
          message: error.message,
        ),
      );
    } on FormatException catch (error) {
      return Left(
        ApiFailure(
          type: ApiFailureType.invalidResponse,
          message: error.message,
        ),
      );
    } catch (error) {
      return Left(
        ApiFailure(type: ApiFailureType.unexpected, message: error.toString()),
      );
    }
  }
}
