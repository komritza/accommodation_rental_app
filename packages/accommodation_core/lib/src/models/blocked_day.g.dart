// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'blocked_day.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BlockedDay _$BlockedDayFromJson(Map<String, dynamic> json) => _BlockedDay(
  listingId: json['listingId'] as String,
  date: const CalendarDateConverter().fromJson(json['date'] as String),
);

Map<String, dynamic> _$BlockedDayToJson(_BlockedDay instance) =>
    <String, dynamic>{
      'listingId': instance.listingId,
      'date': const CalendarDateConverter().toJson(instance.date),
    };
