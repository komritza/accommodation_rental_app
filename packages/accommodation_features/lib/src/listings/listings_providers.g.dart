// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'listings_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(listingsRemoteDataSource)
final listingsRemoteDataSourceProvider = ListingsRemoteDataSourceProvider._();

final class ListingsRemoteDataSourceProvider
    extends
        $FunctionalProvider<
          ListingsRemoteDataSource,
          ListingsRemoteDataSource,
          ListingsRemoteDataSource
        >
    with $Provider<ListingsRemoteDataSource> {
  ListingsRemoteDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'listingsRemoteDataSourceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$listingsRemoteDataSourceHash();

  @$internal
  @override
  $ProviderElement<ListingsRemoteDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ListingsRemoteDataSource create(Ref ref) {
    return listingsRemoteDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ListingsRemoteDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ListingsRemoteDataSource>(value),
    );
  }
}

String _$listingsRemoteDataSourceHash() =>
    r'f27b619e3278ea8f6c14405cf90ef6521c56d9dd';

@ProviderFor(listingsRepository)
final listingsRepositoryProvider = ListingsRepositoryProvider._();

final class ListingsRepositoryProvider
    extends
        $FunctionalProvider<
          ListingsRepository,
          ListingsRepository,
          ListingsRepository
        >
    with $Provider<ListingsRepository> {
  ListingsRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'listingsRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$listingsRepositoryHash();

  @$internal
  @override
  $ProviderElement<ListingsRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ListingsRepository create(Ref ref) {
    return listingsRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ListingsRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ListingsRepository>(value),
    );
  }
}

String _$listingsRepositoryHash() =>
    r'e3d1e542d473f60cf9cd54c7f1aae200fa3670f2';

@ProviderFor(listingFacets)
final listingFacetsProvider = ListingFacetsProvider._();

final class ListingFacetsProvider
    extends
        $FunctionalProvider<
          AsyncValue<ListingFacets>,
          ListingFacets,
          FutureOr<ListingFacets>
        >
    with $FutureModifier<ListingFacets>, $FutureProvider<ListingFacets> {
  ListingFacetsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'listingFacetsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$listingFacetsHash();

  @$internal
  @override
  $FutureProviderElement<ListingFacets> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<ListingFacets> create(Ref ref) {
    return listingFacets(ref);
  }
}

String _$listingFacetsHash() => r'6cb7755c5a5b9a6d7a8bdb9b5e434c84d29d3418';
