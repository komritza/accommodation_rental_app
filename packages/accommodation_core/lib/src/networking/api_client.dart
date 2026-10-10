import 'package:accommodation_core/src/models/tenant_runtime_config.dart';
import 'package:dio/dio.dart';

Dio createApiClient({required String baseUrl, required TenantSlug tenant}) {
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
      onRequest: (options, handler) {
        options.headers['tenant'] = tenant.name;
        handler.next(options);
      },
    ),
  );

  return dio;
}
