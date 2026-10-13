// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Booking _$BookingFromJson(Map<String, dynamic> json) => _Booking(
  id: json['id'] as String,
  listingId: json['listingId'] as String,
  guestName: json['guestName'] as String,
  checkIn: const CalendarDateConverter().fromJson(json['checkIn'] as String),
  checkOut: const CalendarDateConverter().fromJson(json['checkOut'] as String),
  guests: (json['guests'] as num).toInt(),
  status: $enumDecode(
    _$BookingStatusEnumMap,
    json['status'],
    unknownValue: BookingStatus.unknown,
  ),
  totalPrice: json['totalPrice'] as num,
  currency: json['currency'] as String,
);

Map<String, dynamic> _$BookingToJson(_Booking instance) => <String, dynamic>{
  'id': instance.id,
  'listingId': instance.listingId,
  'guestName': instance.guestName,
  'checkIn': const CalendarDateConverter().toJson(instance.checkIn),
  'checkOut': const CalendarDateConverter().toJson(instance.checkOut),
  'guests': instance.guests,
  'status': _$BookingStatusEnumMap[instance.status]!,
  'totalPrice': instance.totalPrice,
  'currency': instance.currency,
};

const _$BookingStatusEnumMap = {
  BookingStatus.confirmed: 'confirmed',
  BookingStatus.pending: 'pending',
  BookingStatus.completed: 'completed',
  BookingStatus.cancelled: 'cancelled',
  BookingStatus.unknown: 'unknown',
};
