import 'package:accommodation_core/accommodation_core.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'host_blocked_days_selection_provider.g.dart';

typedef HostBlockedDaysSelectionState = ({DateTime? start, DateTime? end});

@riverpod
class HostBlockedDaysSelection extends _$HostBlockedDaysSelection {
  @override
  HostBlockedDaysSelectionState build(String listingId) {
    return (start: null, end: null);
  }

  /// A blocked day is always selected on its own, so it can be unblocked.
  /// Any other tap starts a range, or ends the one already started.
  void selectDay(DateTime date, {required bool isBlocked}) {
    final day = StayDates.calendarDate(date);

    if (isBlocked || state.start == null || state.end != null) {
      state = (start: day, end: isBlocked ? day : null);
      return;
    }

    if (day.isBefore(state.start!)) {
      state = (start: day, end: null);
      return;
    }

    state = (start: state.start, end: day);
  }

  void clear() {
    state = (start: null, end: null);
  }
}

/// The days from [start] to [end], both inclusive, that still need a block
/// request: [isTaken] filters out days already booked or blocked.
List<DateTime> daysToBlock({
  required DateTime start,
  DateTime? end,
  required bool Function(DateTime day) isTaken,
}) {
  final first = StayDates.calendarDate(start);
  final last = StayDates.calendarDate(end ?? start);

  return [
    for (
      var day = first;
      !day.isAfter(last);
      day = day.add(const Duration(days: 1))
    )
      if (!isTaken(day)) day,
  ];
}
