import 'package:accommodation_core/accommodation_core.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'blocked_day.freezed.dart';
part 'blocked_day.g.dart';

@freezed
abstract class BlockedDay with _$BlockedDay {
  const factory BlockedDay({
    required String listingId,
    @CalendarDateConverter() required DateTime date,
  }) = _BlockedDay;

  factory BlockedDay.fromJson(Map<String, dynamic> json) =>
      _$BlockedDayFromJson(json);
}
