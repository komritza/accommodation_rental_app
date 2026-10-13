import 'package:accommodation_core/accommodation_core.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'host_bookings_state.freezed.dart';

@freezed
abstract class HostBookingsState with _$HostBookingsState {
  const HostBookingsState._();

  const factory HostBookingsState({
    required List<Booking> bookings,
    required int totalCount,
    String? nextCursor,
    @Default(false) bool isLoadingMore,
    ApiFailure? loadMoreFailure,
  }) = _HostBookingsState;

  factory HostBookingsState.firstPage(CursorPage<Booking> page) {
    return HostBookingsState(
      bookings: page.items,
      totalCount: page.totalCount ?? page.items.length,
      nextCursor: page.nextCursor,
    );
  }

  bool get hasMore => nextCursor != null;
}
