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
class FavouriteListingIds extends _$FavouriteListingIds {
  final Set<String> _pendingIds = {};

  @override
  Future<Set<String>> build() async {
    final userId = await ref.watch(
      authControllerProvider.selectAsync((user) => user?.id),
    );

    if (userId == null) {
      return const {};
    }

    final result = await ref
        .watch(favouritesRepositoryProvider)
        .fetchFavourites();

    return result.match(
      (failure) => throw FavouritesLoadException(failure),
      (listings) => listings.map((listing) => listing.id).toSet(),
    );
  }

  Future<void> toggle(String listingId) async {
    final current = state.value;

    if (current == null || !_pendingIds.add(listingId)) {
      return;
    }

    final wasFavourite = current.contains(listingId);
    state = AsyncData(_withFavourite(current, listingId, !wasFavourite));

    try {
      final repository = ref.read(favouritesRepositoryProvider);
      final result = wasFavourite
          ? await repository.removeFavourite(listingId: listingId)
          : await repository.addFavourite(listingId: listingId);

      if (!ref.mounted) return;

      result.match((failure) {
        final latest = state.value ?? current;
        state = AsyncData(_withFavourite(latest, listingId, wasFavourite));
        throw FavouritesUpdateException(failure);
      }, (_) {});
    } finally {
      _pendingIds.remove(listingId);
    }
  }

  Set<String> _withFavourite(Set<String> ids, String listingId, bool add) {
    final updated = Set<String>.of(ids);
    if (add) {
      updated.add(listingId);
    } else {
      updated.remove(listingId);
    }
    return updated;
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
