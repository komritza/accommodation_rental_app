import 'package:accommodation_core/accommodation_core.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'guest_calendar.g.dart';

const guestCalendarMonthsAhead = 12;

@riverpod
DateTime guestCalendarToday(Ref ref) => StayDates.calendarDate(DateTime.now());
