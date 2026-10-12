import 'package:accommodation_core/src/models/tenant_runtime_config.dart';
import 'package:dio/dio.dart';

typedef AccessTokenReader = Future<String?> Function();

const _authorizationHeader = 'Authorization';

Dio createApiClient({
  required String baseUrl,
  required TenantSlug tenant,
  required AccessTokenReader readAccessToken,
}) {
  final dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 15),
      sendTimeout: const Duration(seconds: 15),
      contentType: Headers.jsonContentType,
      responseType: ResponseType.json,
    ),
  );

  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) async {
        options.headers['tenant'] = tenant.name;
        if (!options.headers.containsKey(_authorizationHeader)) {
          final token = await readAccessToken();
          if (token != null && token.isNotEmpty) {
            options.headers[_authorizationHeader] = 'Bearer $token';
          }
        }
        handler.next(options);
      },
    ),
  );

  return dio;
}
