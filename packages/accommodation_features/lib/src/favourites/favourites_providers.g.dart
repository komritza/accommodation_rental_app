// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favourites_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(favouritesRemoteDataSource)
final favouritesRemoteDataSourceProvider =
    FavouritesRemoteDataSourceProvider._();

final class FavouritesRemoteDataSourceProvider
    extends
        $FunctionalProvider<
          FavouritesRemoteDataSource,
          FavouritesRemoteDataSource,
          FavouritesRemoteDataSource
        >
    with $Provider<FavouritesRemoteDataSource> {
  FavouritesRemoteDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'favouritesRemoteDataSourceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$favouritesRemoteDataSourceHash();

  @$internal
  @override
  $ProviderElement<FavouritesRemoteDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  FavouritesRemoteDataSource create(Ref ref) {
    return favouritesRemoteDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FavouritesRemoteDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FavouritesRemoteDataSource>(value),
    );
  }
}

String _$favouritesRemoteDataSourceHash() =>
    r'9fe14307a861222d5bf8dd4a15a7e35a4b08ce24';

@ProviderFor(favouritesRepository)
final favouritesRepositoryProvider = FavouritesRepositoryProvider._();

final class FavouritesRepositoryProvider
    extends
        $FunctionalProvider<
          FavouritesRepository,
          FavouritesRepository,
          FavouritesRepository
        >
    with $Provider<FavouritesRepository> {
  FavouritesRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'favouritesRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$favouritesRepositoryHash();

  @$internal
  @override
  $ProviderElement<FavouritesRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  FavouritesRepository create(Ref ref) {
    return favouritesRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FavouritesRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FavouritesRepository>(value),
    );
  }
}

String _$favouritesRepositoryHash() =>
    r'6735d97329274e715fa00920eb4fdb45e6665277';

@ProviderFor(FavouriteListingIds)
final favouriteListingIdsProvider = FavouriteListingIdsProvider._();

final class FavouriteListingIdsProvider
    extends $AsyncNotifierProvider<FavouriteListingIds, Set<String>> {
  FavouriteListingIdsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'favouriteListingIdsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$favouriteListingIdsHash();

  @$internal
  @override
  FavouriteListingIds create() => FavouriteListingIds();
}

String _$favouriteListingIdsHash() =>
    r'598aa7304ffda099a422d354cd74af107c5759ad';

abstract class _$FavouriteListingIds extends $AsyncNotifier<Set<String>> {
  FutureOr<Set<String>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<Set<String>>, Set<String>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<Set<String>>, Set<String>>,
              AsyncValue<Set<String>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
