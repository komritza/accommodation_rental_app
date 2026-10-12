import 'package:freezed_annotation/freezed_annotation.dart';

import 'stay_dates.dart';

part 'listing_availability.freezed.dart';
part 'listing_availability.g.dart';

enum UnavailableReason { booked, blocked }

/// The days of a listing's calendar that are taken within `[from, to)`.
///
/// Free days are absent from [unavailable].
@freezed
abstract class ListingAvailability with _$ListingAvailability {
  factory ListingAvailability({
    required String listingId,
    @CalendarDateConverter() required DateTime from,
    @CalendarDateConverter() required DateTime to,
    required List<UnavailableDay> unavailable,
  }) = _ListingAvailability;

  ListingAvailability._();

  factory ListingAvailability.fromJson(Map<String, dynamic> json) =>
      _$ListingAvailabilityFromJson(json);

  late final Set<DateTime> _takenDays = {
    for (final day in unavailable) day.date,
  };

  /// Whether the night of [day] is taken, by a booking or by the host.
  bool isTaken(DateTime day) =>
      _takenDays.contains(StayDates.calendarDate(day));
}

@freezed
abstract class UnavailableDay with _$UnavailableDay {
  const factory UnavailableDay({
    @CalendarDateConverter() required DateTime date,
    @JsonKey(unknownEnumValue: UnavailableReason.booked)
    required UnavailableReason reason,
  }) = _UnavailableDay;

  factory UnavailableDay.fromJson(Map<String, dynamic> json) =>
      _$UnavailableDayFromJson(json);
}

/// Reads a `YYYY-MM-DD` date as a UTC calendar date, so it compares equal to
/// [StayDates.calendarDate] whatever the device time zone.
class CalendarDateConverter implements JsonConverter<DateTime, String> {
  const CalendarDateConverter();

  @override
  DateTime fromJson(String json) =>
      StayDates.calendarDate(DateTime.parse(json));

  @override
  String toJson(DateTime date) => StayDates.isoDate(date);
}
