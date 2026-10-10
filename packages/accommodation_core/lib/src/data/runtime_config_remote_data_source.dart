import 'package:accommodation_core/src/models/tenant_runtime_config.dart';
import 'package:dio/dio.dart';

class RuntimeConfigRemoteDataSource {
  const RuntimeConfigRemoteDataSource(this._dio);

  final Dio _dio;

  Future<TenantRuntimeConfig> fetchRuntimeConfig(TenantSlug tenant) async {
    final response = await _dio.get<Map<String, dynamic>>(
      '/tenants/${tenant.name}/runtime-config',
    );

    final data = response.data;

    if (data == null) {
      throw const FormatException('Runtime config response body was empty.');
    }

    return TenantRuntimeConfig.fromJson(data);
  }
}
