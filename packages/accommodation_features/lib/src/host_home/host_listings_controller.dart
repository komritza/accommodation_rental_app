import 'package:accommodation_core/accommodation_core.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../listings/listings_providers.dart';
import 'host_listings_state.dart';

part 'host_listings_controller.g.dart';

@riverpod
class HostListingsController extends _$HostListingsController {
  @override
  Future<HostListingsState> build() async {
    final result = await ref
        .watch(listingsRepositoryProvider)
        .fetchHostListings();

    return result.match(
      (failure) => throw ListingsLoadException(failure),
      HostListingsState.firstPage,
    );
  }

  Future<void> loadNextPage() async {
    final current = state.value;
    if (current == null || current.loadMoreFailure != null) return;

    await _fetchNextPage(current);
  }

  /// Swaps in an edited listing without reloading, so the loaded pages and
  /// the scroll position survive.
  void replaceListing(Listing listing) {
    final current = state.value;
    if (current == null) return;

    state = AsyncData(
      current.copyWith(
        listings: [
          for (final existing in current.listings)
            existing.id == listing.id ? listing : existing,
        ],
      ),
    );
  }

  Future<void> retryNextPage() async {
    final current = state.value;
    if (current == null) return;

    await _fetchNextPage(current);
  }

  Future<void> _fetchNextPage(HostListingsState current) async {
    if (state.isLoading || current.isLoadingMore || !current.hasMore) {
      return;
    }

    final requestRef = ref;
    final loading = current.copyWith(
      isLoadingMore: true,
      loadMoreFailure: null,
    );
    state = AsyncData(loading);

    final result = await ref
        .read(listingsRepositoryProvider)
        .fetchHostListings(cursor: current.nextCursor);

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
