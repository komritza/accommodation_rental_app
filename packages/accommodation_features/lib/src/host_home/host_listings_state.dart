import 'package:accommodation_core/accommodation_core.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'host_listings_state.freezed.dart';

@freezed
abstract class HostListingsState with _$HostListingsState {
  const HostListingsState._();

  const factory HostListingsState({
    required List<Listing> listings,
    required int totalCount,
    String? nextCursor,
    @Default(false) bool isLoadingMore,
    ApiFailure? loadMoreFailure,
  }) = _HostListingsState;

  factory HostListingsState.firstPage(CursorPage<Listing> page) {
    return HostListingsState(
      listings: page.items,
      totalCount: page.totalCount ?? page.items.length,
      nextCursor: page.nextCursor,
    );
  }

  bool get hasMore => nextCursor != null;
}
