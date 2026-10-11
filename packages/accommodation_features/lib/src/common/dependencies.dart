import 'package:accommodation_core/accommodation_core.dart';
import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dependencies.g.dart';

@Riverpod(keepAlive: true)
TenantSlug tenantSlug(Ref ref) => throw UnimplementedError();
@Riverpod(keepAlive: true)
Dio apiClient(Ref ref) => throw UnimplementedError();
@Riverpod(keepAlive: true)
TokenStorage tokenStorage(Ref ref) => throw UnimplementedError();

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

class RuntimeConfigLoadException implements Exception {
  const RuntimeConfigLoadException(this.failure);

  final ApiFailure failure;

  @override
  String toString() {
    return failure.message ?? 'Unable to load tenant configuration.';
  }
}
