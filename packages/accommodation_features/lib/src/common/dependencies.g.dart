// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dependencies.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(tenantSlug)
final tenantSlugProvider = TenantSlugProvider._();

final class TenantSlugProvider
    extends $FunctionalProvider<TenantSlug, TenantSlug, TenantSlug>
    with $Provider<TenantSlug> {
  TenantSlugProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'tenantSlugProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$tenantSlugHash();

  @$internal
  @override
  $ProviderElement<TenantSlug> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  TenantSlug create(Ref ref) {
    return tenantSlug(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TenantSlug value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TenantSlug>(value),
    );
  }
}

String _$tenantSlugHash() => r'bc7cb9dea301eeb2ae3b41376041a930f296805e';

@ProviderFor(apiClient)
final apiClientProvider = ApiClientProvider._();

final class ApiClientProvider extends $FunctionalProvider<Dio, Dio, Dio>
    with $Provider<Dio> {
  ApiClientProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'apiClientProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$apiClientHash();

  @$internal
  @override
  $ProviderElement<Dio> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Dio create(Ref ref) {
    return apiClient(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Dio value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Dio>(value),
    );
  }
}

String _$apiClientHash() => r'51fd7a42b2df0fc4dc2eaf5a0268b0800d71d341';

@ProviderFor(tokenStorage)
final tokenStorageProvider = TokenStorageProvider._();

final class TokenStorageProvider
    extends $FunctionalProvider<TokenStorage, TokenStorage, TokenStorage>
    with $Provider<TokenStorage> {
  TokenStorageProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'tokenStorageProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$tokenStorageHash();

  @$internal
  @override
  $ProviderElement<TokenStorage> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  TokenStorage create(Ref ref) {
    return tokenStorage(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TokenStorage value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TokenStorage>(value),
    );
  }
}

String _$tokenStorageHash() => r'3fdf49529dcb681d714f2321cd7bfc7e01e6eec4';

@ProviderFor(runtimeConfig)
final runtimeConfigProvider = RuntimeConfigProvider._();

final class RuntimeConfigProvider
    extends
        $FunctionalProvider<
          AsyncValue<TenantRuntimeConfig>,
          TenantRuntimeConfig,
          FutureOr<TenantRuntimeConfig>
        >
    with
        $FutureModifier<TenantRuntimeConfig>,
        $FutureProvider<TenantRuntimeConfig> {
  RuntimeConfigProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'runtimeConfigProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$runtimeConfigHash();

  @$internal
  @override
  $FutureProviderElement<TenantRuntimeConfig> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<TenantRuntimeConfig> create(Ref ref) {
    return runtimeConfig(ref);
  }
}

String _$runtimeConfigHash() => r'9cfae0cb6681b47ef6e587aa6cbd8816bd129a72';

@ProviderFor(runtimeConfigRemoteDataSource)
final runtimeConfigRemoteDataSourceProvider =
    RuntimeConfigRemoteDataSourceProvider._();

final class RuntimeConfigRemoteDataSourceProvider
    extends
        $FunctionalProvider<
          RuntimeConfigRemoteDataSource,
          RuntimeConfigRemoteDataSource,
          RuntimeConfigRemoteDataSource
        >
    with $Provider<RuntimeConfigRemoteDataSource> {
  RuntimeConfigRemoteDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'runtimeConfigRemoteDataSourceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$runtimeConfigRemoteDataSourceHash();

  @$internal
  @override
  $ProviderElement<RuntimeConfigRemoteDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  RuntimeConfigRemoteDataSource create(Ref ref) {
    return runtimeConfigRemoteDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RuntimeConfigRemoteDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RuntimeConfigRemoteDataSource>(
        value,
      ),
    );
  }
}

String _$runtimeConfigRemoteDataSourceHash() =>
    r'938b6236cb2ef8fbd84c644b667a99aadf8fd4dc';

@ProviderFor(runtimeConfigRepository)
final runtimeConfigRepositoryProvider = RuntimeConfigRepositoryProvider._();

final class RuntimeConfigRepositoryProvider
    extends
        $FunctionalProvider<
          RuntimeConfigRepository,
          RuntimeConfigRepository,
          RuntimeConfigRepository
        >
    with $Provider<RuntimeConfigRepository> {
  RuntimeConfigRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'runtimeConfigRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$runtimeConfigRepositoryHash();

  @$internal
  @override
  $ProviderElement<RuntimeConfigRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  RuntimeConfigRepository create(Ref ref) {
    return runtimeConfigRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RuntimeConfigRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RuntimeConfigRepository>(value),
    );
  }
}

String _$runtimeConfigRepositoryHash() =>
    r'005f36afc27c37be74d504ccc499b49b17535ca0';
