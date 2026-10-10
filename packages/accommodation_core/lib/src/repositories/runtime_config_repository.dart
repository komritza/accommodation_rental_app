import 'package:accommodation_core/src/data/runtime_config_remote_data_source.dart';
import 'package:accommodation_core/src/models/tenant_runtime_config.dart';
import 'package:accommodation_core/src/networking/api_failure.dart';
import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';

class RuntimeConfigRepository {
  const RuntimeConfigRepository(this._remoteDataSource);

  final RuntimeConfigRemoteDataSource _remoteDataSource;

  Future<Either<ApiFailure, TenantRuntimeConfig>> fetchRuntimeConfig(
    TenantSlug tenant,
  ) async {
    try {
      final config = await _remoteDataSource.fetchRuntimeConfig(tenant);
      return Right(config);
    } on DioException catch (error) {
      final isNetworkError =
          error.type == DioExceptionType.connectionTimeout ||
          error.type == DioExceptionType.sendTimeout ||
          error.type == DioExceptionType.receiveTimeout ||
          error.type == DioExceptionType.connectionError;

      return Left(
        ApiFailure(
          type: isNetworkError ? ApiFailureType.network : ApiFailureType.http,
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
