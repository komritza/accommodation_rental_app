import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../listings/listings_providers.dart';
import 'guest_listing_filters.dart';
import 'guest_listings_state.dart';

part 'guest_listings_controller.g.dart';

@riverpod
class GuestListingsController extends _$GuestListingsController {
  @override
  Future<GuestListingsState> build() async {
    final filters = ref.watch(guestListingFiltersProvider);
    final result = await ref
        .watch(listingsRepositoryProvider)
        .fetchListings(query: filters);

    return result.match(
      (failure) => throw ListingsLoadException(failure),
      GuestListingsState.firstPage,
    );
  }

  Future<void> loadNextPage() async {
    final current = state.value;
    if (current == null || current.loadMoreFailure != null) return;

    await _fetchNextPage(current);
  }

  Future<void> retryNextPage() async {
    final current = state.value;
    if (current == null) return;

    await _fetchNextPage(current);
  }

  Future<void> _fetchNextPage(GuestListingsState current) async {
    if (state.isLoading || current.isLoadingMore || !current.hasMore) return;

    final requestRef = ref;
    final loading = current.copyWith(
      isLoadingMore: true,
      loadMoreFailure: null,
    );
    state = AsyncData(loading);

    final result = await ref
        .read(listingsRepositoryProvider)
        .fetchListings(
          query: ref.read(guestListingFiltersProvider),
          cursor: current.nextCursor,
        );

    final isStale =
        !requestRef.mounted ||
        state.isLoading ||
        !identical(state.value, loading);
    if (isStale) return;

    state = AsyncData(
      result.match(
        (failure) =>
            loading.copyWith(isLoadingMore: false, loadMoreFailure: failure),
        (page) => loading.copyWith(
          listings: [...loading.listings, ...page.items],
          totalCount: page.totalCount ?? loading.totalCount,
          nextCursor: page.nextCursor,
          isLoadingMore: false,
        ),
      ),
    );
  }
}
