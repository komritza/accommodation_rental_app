// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'listing_availability.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ListingAvailability _$ListingAvailabilityFromJson(Map<String, dynamic> json) =>
    _ListingAvailability(
      listingId: json['listingId'] as String,
      from: const CalendarDateConverter().fromJson(json['from'] as String),
      to: const CalendarDateConverter().fromJson(json['to'] as String),
      unavailable: (json['unavailable'] as List<dynamic>)
          .map((e) => UnavailableDay.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ListingAvailabilityToJson(
  _ListingAvailability instance,
) => <String, dynamic>{
  'listingId': instance.listingId,
  'from': const CalendarDateConverter().toJson(instance.from),
  'to': const CalendarDateConverter().toJson(instance.to),
  'unavailable': instance.unavailable.map((e) => e.toJson()).toList(),
};

_UnavailableDay _$UnavailableDayFromJson(Map<String, dynamic> json) =>
    _UnavailableDay(
      date: const CalendarDateConverter().fromJson(json['date'] as String),
      reason: $enumDecode(
        _$UnavailableReasonEnumMap,
        json['reason'],
        unknownValue: UnavailableReason.booked,
      ),
    );

Map<String, dynamic> _$UnavailableDayToJson(_UnavailableDay instance) =>
    <String, dynamic>{
      'date': const CalendarDateConverter().toJson(instance.date),
      'reason': _$UnavailableReasonEnumMap[instance.reason]!,
    };

const _$UnavailableReasonEnumMap = {
  UnavailableReason.booked: 'booked',
  UnavailableReason.blocked: 'blocked',
};
