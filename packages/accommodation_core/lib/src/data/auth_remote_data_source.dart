import 'package:dio/dio.dart';

import '../models/auth_session.dart';

class AuthRemoteDataSource {
  const AuthRemoteDataSource(this._dio);

  final Dio _dio;

  Future<AuthSession> register({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String language,
  }) async {
    final response = await _dio.post<Map<String, dynamic>>(
      '/auth/register',
      queryParameters: {'language': language},
      data: {
        'email': email,
        'password': password,
        'firstName': firstName,
        'lastName': lastName,
      },
    );

    return AuthSession.fromJson(_requireObject(response.data));
  }

  Future<AuthSession> login({
    required String email,
    required String password,
    required String language,
  }) async {
    final response = await _dio.post<Map<String, dynamic>>(
      '/auth/login',
      queryParameters: {'language': language},
      data: {'email': email, 'password': password},
    );

    return AuthSession.fromJson(_requireObject(response.data));
  }

  Future<AuthUser> getCurrentUser({required String accessToken}) async {
    final response = await _dio.get<Map<String, dynamic>>(
      '/auth/me',
      options: Options(headers: {'Authorization': 'Bearer $accessToken'}),
    );

    return AuthUser.fromJson(_requireObject(response.data));
  }

  Future<void> logout({required String accessToken}) async {
    await _dio.post<void>(
      '/auth/logout',
      options: Options(headers: {'Authorization': 'Bearer $accessToken'}),
    );
  }
}

Map<String, dynamic> _requireObject(Map<String, dynamic>? data) {
  if (data == null) {
    throw const FormatException('Expected a JSON object in the API response.');
  }

  return data;
}
