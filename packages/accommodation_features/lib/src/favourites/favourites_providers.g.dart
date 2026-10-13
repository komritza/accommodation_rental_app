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

@ProviderFor(Favourites)
final favouritesProvider = FavouritesProvider._();

final class FavouritesProvider
    extends $AsyncNotifierProvider<Favourites, List<Listing>> {
  FavouritesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'favouritesProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$favouritesHash();

  @$internal
  @override
  Favourites create() => Favourites();
}

String _$favouritesHash() => r'020dde525618b09f3278de4d00a56a8b5a4f677f';

abstract class _$Favourites extends $AsyncNotifier<List<Listing>> {
  FutureOr<List<Listing>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<Listing>>, List<Listing>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<Listing>>, List<Listing>>,
              AsyncValue<List<Listing>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
