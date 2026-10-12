import 'package:accommodation_core/accommodation_core.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'guest_listings_state.freezed.dart';

@freezed
abstract class GuestListingsState with _$GuestListingsState {
  const GuestListingsState._();

  const factory GuestListingsState({
    required List<Listing> listings,
    required int totalCount,
    String? nextCursor,
    @Default(false) bool isLoadingMore,
    ApiFailure? loadMoreFailure,
  }) = _GuestListingsState;

  factory GuestListingsState.firstPage(CursorPage<Listing> page) {
    return GuestListingsState(
      listings: page.items,
      totalCount: page.totalCount ?? page.items.length,
      nextCursor: page.nextCursor,
    );
  }

  bool get hasMore => nextCursor != null;
}
