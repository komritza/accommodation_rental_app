import 'package:freezed_annotation/freezed_annotation.dart';

import 'listing_availability.dart';
import 'stay_dates.dart';

part 'booking.freezed.dart';
part 'booking.g.dart';

enum BookingStatus { confirmed, pending, completed, cancelled, unknown }

@freezed
abstract class Booking with _$Booking {
  const factory Booking({
    required String id,
    required String listingId,
    required String guestName,
    @CalendarDateConverter() required DateTime checkIn,

    @CalendarDateConverter() required DateTime checkOut,
    required int guests,
    @JsonKey(unknownEnumValue: BookingStatus.unknown)
    required BookingStatus status,

    required num totalPrice,
    required String currency,
  }) = _Booking;

  const Booking._();

  factory Booking.fromJson(Map<String, dynamic> json) =>
      _$BookingFromJson(json);

  int get nights => StayDates.nightsBetween(checkIn, checkOut);
}
