import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';

import 'api_failure.dart';

Future<Either<ApiFailure, T>> runApiCall<T>(
  Future<T> Function() operation,
) async {
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
      ApiFailure(type: ApiFailureType.invalidResponse, message: error.message),
    );
  } catch (error) {
    return Left(
      ApiFailure(type: ApiFailureType.unexpected, message: error.toString()),
    );
  }
}
