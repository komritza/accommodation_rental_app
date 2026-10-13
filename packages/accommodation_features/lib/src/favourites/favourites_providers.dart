import 'package:accommodation_core/accommodation_core.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../auth/auth_providers.dart';
import '../common/dependencies.dart';

part 'favourites_providers.g.dart';

@Riverpod(keepAlive: true)
FavouritesRemoteDataSource favouritesRemoteDataSource(Ref ref) {
  return FavouritesRemoteDataSource(ref.watch(apiClientProvider));
}

@Riverpod(keepAlive: true)
FavouritesRepository favouritesRepository(Ref ref) {
  return FavouritesRepository(ref.watch(favouritesRemoteDataSourceProvider));
}

@Riverpod(keepAlive: true)
class Favourites extends _$Favourites {
  final Set<String> _pendingIds = {};

  @override
  Future<List<Listing>> build() async {
    final userId = await ref.watch(
      authControllerProvider.selectAsync((user) => user?.id),
    );

    if (userId == null) {
      return const [];
    }

    final result = await ref
        .watch(favouritesRepositoryProvider)
        .fetchFavourites();

    return result.match(
      (failure) => throw FavouritesLoadException(failure),
      (listings) => listings,
    );
  }

  Future<void> toggle(Listing listing) async {
    final current = state.value;

    if (current == null || !_pendingIds.add(listing.id)) {
      return;
    }

    final index = current.indexWhere((item) => item.id == listing.id);
    final wasFavourite = index != -1;
    state = AsyncData(
      wasFavourite
          ? _without(current, listing.id)
          : _withListing(current, listing, 0),
    );

    try {
      final repository = ref.read(favouritesRepositoryProvider);
      final result = wasFavourite
          ? await repository.removeFavourite(listingId: listing.id)
          : await repository.addFavourite(listingId: listing.id);

      if (!ref.mounted) return;

      result.match((failure) {
        final latest = state.value ?? current;
        state = AsyncData(
          wasFavourite
              ? _withListing(latest, current[index], index)
              : _without(latest, listing.id),
        );
        throw FavouritesUpdateException(failure);
      }, (_) {});
    } finally {
      _pendingIds.remove(listing.id);
    }
  }

  List<Listing> _withListing(List<Listing> listings, Listing listing, int at) {
    return [...listings]..insert(at.clamp(0, listings.length), listing);
  }

  List<Listing> _without(List<Listing> listings, String listingId) {
    return [
      for (final item in listings)
        if (item.id != listingId) item,
    ];
  }
}

class FavouritesLoadException implements Exception {
  const FavouritesLoadException(this.failure);

  final ApiFailure failure;
}

class FavouritesUpdateException implements Exception {
  const FavouritesUpdateException(this.failure);

  final ApiFailure failure;
}
