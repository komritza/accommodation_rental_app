import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../listings/listings_providers.dart';
import 'host_bookings_state.dart';

part 'host_bookings_controller.g.dart';

@riverpod
class HostBookingsController extends _$HostBookingsController {
  @override
  Future<HostBookingsState> build(String listingId) async {
    final result = await ref
        .watch(listingsRepositoryProvider)
        .fetchHostBookings(listingId: listingId);

    return result.match(
      (failure) => throw ListingsLoadException(failure),
      HostBookingsState.firstPage,
    );
  }

  /// Also retries a page that failed to load.
  Future<void> loadMore() async {
    final current = state.value;
    if (state.isLoading ||
        current == null ||
        current.isLoadingMore ||
        !current.hasMore) {
      return;
    }

    final loading = current.copyWith(
      isLoadingMore: true,
      loadMoreFailure: null,
    );
    state = AsyncData(loading);

    final result = await ref
        .read(listingsRepositoryProvider)
        .fetchHostBookings(listingId: listingId, cursor: current.nextCursor);

    if (!ref.mounted || !identical(state.value, loading)) return;

    state = AsyncData(
      result.match(
        (failure) =>
            loading.copyWith(isLoadingMore: false, loadMoreFailure: failure),
        (page) => loading.copyWith(
          bookings: [...loading.bookings, ...page.items],
          totalCount: page.totalCount ?? loading.totalCount,
          nextCursor: page.nextCursor,
          isLoadingMore: false,
        ),
      ),
    );
  }
}
