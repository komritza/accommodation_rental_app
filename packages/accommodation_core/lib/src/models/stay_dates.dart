import 'package:freezed_annotation/freezed_annotation.dart';

@immutable
class StayDates {
  factory StayDates({required DateTime checkIn, required DateTime checkOut}) {
    final stay = StayDates._(calendarDate(checkIn), calendarDate(checkOut));
    if (!isValidLength(stay.nights)) {
      throw ArgumentError.value(
        stay.nights,
        'nights',
        'must be between 1 and $maxNights',
      );
    }
    return stay;
  }

  const StayDates._(this.checkIn, this.checkOut);

  static const maxNights = 366;

  static bool isValidLength(int nights) => nights >= 1 && nights <= maxNights;

  static DateTime calendarDate(DateTime date) =>
      DateTime.utc(date.year, date.month, date.day);

  static int nightsBetween(DateTime from, DateTime to) =>
      calendarDate(to).difference(calendarDate(from)).inDays;

  final DateTime checkIn;
  final DateTime checkOut;

  int get nights => nightsBetween(checkIn, checkOut);

  String get checkInIso => _iso(checkIn);

  String get checkOutIso => _iso(checkOut);

  static String _iso(DateTime date) =>
      '${date.year.toString().padLeft(4, '0')}-'
      '${date.month.toString().padLeft(2, '0')}-'
      '${date.day.toString().padLeft(2, '0')}';

  @override
  bool operator ==(Object other) =>
      other is StayDates &&
      other.checkIn == checkIn &&
      other.checkOut == checkOut;

  @override
  int get hashCode => Object.hash(checkIn, checkOut);

  @override
  String toString() => 'StayDates($checkInIso → $checkOutIso)';
}
