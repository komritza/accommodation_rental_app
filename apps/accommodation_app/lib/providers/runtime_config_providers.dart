import 'package:accommodation_core/accommodation_core.dart';
import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'runtime_config_providers.g.dart';

const _tenantSlugValue = String.fromEnvironment('TENANT_SLUG');
const _apiBaseUrl = String.fromEnvironment(
  'API_BASE_URL',
  defaultValue: 'http://localhost:8080',
);

@Riverpod(keepAlive: true)
TenantSlug tenantSlug(Ref ref) {
  return switch (_tenantSlugValue) {
    'alpine' => TenantSlug.alpine,
    'riviera' => TenantSlug.riviera,
    _ => throw StateError(
      'Invalid TENANT_SLUG. Set it to "alpine" or "riviera".',
    ),
  };
}

@Riverpod(keepAlive: true)
Dio apiClient(Ref ref) {
  return createApiClient(
    baseUrl: _apiBaseUrl,
    tenant: ref.watch(tenantSlugProvider),
  );
}

@Riverpod(keepAlive: true)
RuntimeConfigRemoteDataSource runtimeConfigRemoteDataSource(Ref ref) {
  return RuntimeConfigRemoteDataSource(ref.watch(apiClientProvider));
}

@Riverpod(keepAlive: true)
RuntimeConfigRepository runtimeConfigRepository(Ref ref) {
  return RuntimeConfigRepository(
    ref.watch(runtimeConfigRemoteDataSourceProvider),
  );
}

@Riverpod(keepAlive: true)
Future<TenantRuntimeConfig> runtimeConfig(Ref ref) async {
  final tenant = ref.watch(tenantSlugProvider);
  final repository = ref.watch(runtimeConfigRepositoryProvider);

  final result = await repository.fetchRuntimeConfig(tenant);

  return result.match(
    (failure) => throw RuntimeConfigLoadException(failure),
    (config) => config,
  );
}

class RuntimeConfigLoadException implements Exception {
  const RuntimeConfigLoadException(this.failure);

  final ApiFailure failure;

  @override
  String toString() {
    return failure.message ?? 'Unable to load tenant configuration.';
  }
}
