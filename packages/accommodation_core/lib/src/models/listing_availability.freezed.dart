// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'listing_availability.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ListingAvailability {

 String get listingId;@CalendarDateConverter() DateTime get from;@CalendarDateConverter() DateTime get to; List<UnavailableDay> get unavailable;
/// Create a copy of ListingAvailability
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ListingAvailabilityCopyWith<ListingAvailability> get copyWith => _$ListingAvailabilityCopyWithImpl<ListingAvailability>(this as ListingAvailability, _$identity);

  /// Serializes this ListingAvailability to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ListingAvailability;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ListingAvailability&&const DeepCollectionEquality().equals(other._takenDays, _this._takenDays)&&(identical(other.listingId, _this.listingId) || other.listingId == _this.listingId)&&(identical(other.from, _this.from) || other.from == _this.from)&&(identical(other.to, _this.to) || other.to == _this.to)&&const DeepCollectionEquality().equals(other.unavailable, _this.unavailable));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ListingAvailability;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this._takenDays),_this.listingId,_this.from,_this.to,const DeepCollectionEquality().hash(_this.unavailable));
}

@override
String toString() {
  final _this = this as ListingAvailability;
  return 'ListingAvailability(_takenDays: ${_this._takenDays}, listingId: ${_this.listingId}, from: ${_this.from}, to: ${_this.to}, unavailable: ${_this.unavailable})';
}


}

/// @nodoc
abstract mixin class $ListingAvailabilityCopyWith<$Res>  {
  factory $ListingAvailabilityCopyWith(ListingAvailability value, $Res Function(ListingAvailability) _then) = _$ListingAvailabilityCopyWithImpl;
@useResult
$Res call({
 String listingId,@CalendarDateConverter() DateTime from,@CalendarDateConverter() DateTime to, List<UnavailableDay> unavailable
});




}
/// @nodoc
class _$ListingAvailabilityCopyWithImpl<$Res>
    implements $ListingAvailabilityCopyWith<$Res> {
  _$ListingAvailabilityCopyWithImpl(this._self, this._then);

  final ListingAvailability _self;
  final $Res Function(ListingAvailability) _then;

/// Create a copy of ListingAvailability
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? listingId = null,Object? from = null,Object? to = null,Object? unavailable = null,}) {
  return _then(ListingAvailability(
listingId: null == listingId ? _self.listingId : listingId // ignore: cast_nullable_to_non_nullable
as String,from: null == from ? _self.from : from // ignore: cast_nullable_to_non_nullable
as DateTime,to: null == to ? _self.to : to // ignore: cast_nullable_to_non_nullable
as DateTime,unavailable: null == unavailable ? _self.unavailable : unavailable // ignore: cast_nullable_to_non_nullable
as List<UnavailableDay>,
  ));
}

}


/// Adds pattern-matching-related methods to [ListingAvailability].
extension ListingAvailabilityPatterns on ListingAvailability {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ListingAvailability value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ListingAvailability() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ListingAvailability value)  $default,){
final _that = this;
switch (_that) {
case _ListingAvailability():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ListingAvailability value)?  $default,){
final _that = this;
switch (_that) {
case _ListingAvailability() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String listingId, @CalendarDateConverter()  DateTime from, @CalendarDateConverter()  DateTime to,  List<UnavailableDay> unavailable)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ListingAvailability() when $default != null:
return $default(_that.listingId,_that.from,_that.to,_that.unavailable);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String listingId, @CalendarDateConverter()  DateTime from, @CalendarDateConverter()  DateTime to,  List<UnavailableDay> unavailable)  $default,) {final _that = this;
switch (_that) {
case _ListingAvailability():
return $default(_that.listingId,_that.from,_that.to,_that.unavailable);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String listingId, @CalendarDateConverter()  DateTime from, @CalendarDateConverter()  DateTime to,  List<UnavailableDay> unavailable)?  $default,) {final _that = this;
switch (_that) {
case _ListingAvailability() when $default != null:
return $default(_that.listingId,_that.from,_that.to,_that.unavailable);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ListingAvailability extends ListingAvailability {
   _ListingAvailability({required this.listingId, @CalendarDateConverter() required this.from, @CalendarDateConverter() required this.to, required  List<UnavailableDay> unavailable}): _unavailable = unavailable,super._();
  factory _ListingAvailability.fromJson(Map<String, dynamic> json) => _$ListingAvailabilityFromJson(json);

@override final  String listingId;
@override@CalendarDateConverter() final  DateTime from;
@override@CalendarDateConverter() final  DateTime to;
 final  List<UnavailableDay> _unavailable;
@override List<UnavailableDay> get unavailable {
  if (_unavailable is EqualUnmodifiableListView) return _unavailable;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_unavailable);
}


/// Create a copy of ListingAvailability
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ListingAvailabilityCopyWith<_ListingAvailability> get copyWith => __$ListingAvailabilityCopyWithImpl<_ListingAvailability>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ListingAvailabilityToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ListingAvailability&&(identical(other.listingId, listingId) || other.listingId == listingId)&&(identical(other.from, from) || other.from == from)&&(identical(other.to, to) || other.to == to)&&const DeepCollectionEquality().equals(other.unavailable, _unavailable));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,listingId,from,to,const DeepCollectionEquality().hash(_unavailable));
}

@override
String toString() {
    return 'ListingAvailability(listingId: $listingId, from: $from, to: $to, unavailable: $unavailable)';
}


}

/// @nodoc
abstract mixin class _$ListingAvailabilityCopyWith<$Res> implements $ListingAvailabilityCopyWith<$Res> {
  factory _$ListingAvailabilityCopyWith(_ListingAvailability value, $Res Function(_ListingAvailability) _then) = __$ListingAvailabilityCopyWithImpl;
@override @useResult
$Res call({
 String listingId,@CalendarDateConverter() DateTime from,@CalendarDateConverter() DateTime to, List<UnavailableDay> unavailable
});




}
/// @nodoc
class __$ListingAvailabilityCopyWithImpl<$Res>
    implements _$ListingAvailabilityCopyWith<$Res> {
  __$ListingAvailabilityCopyWithImpl(this._self, this._then);

  final _ListingAvailability _self;
  final $Res Function(_ListingAvailability) _then;

/// Create a copy of ListingAvailability
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? listingId = null,Object? from = null,Object? to = null,Object? unavailable = null,}) {
  return _then(_ListingAvailability(
listingId: null == listingId ? _self.listingId : listingId // ignore: cast_nullable_to_non_nullable
as String,from: null == from ? _self.from : from // ignore: cast_nullable_to_non_nullable
as DateTime,to: null == to ? _self.to : to // ignore: cast_nullable_to_non_nullable
as DateTime,unavailable: null == unavailable ? _self._unavailable : unavailable // ignore: cast_nullable_to_non_nullable
as List<UnavailableDay>,
  ));
}


}


/// @nodoc
mixin _$UnavailableDay {

@CalendarDateConverter() DateTime get date;@JsonKey(unknownEnumValue: UnavailableReason.booked) UnavailableReason get reason;
/// Create a copy of UnavailableDay
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UnavailableDayCopyWith<UnavailableDay> get copyWith => _$UnavailableDayCopyWithImpl<UnavailableDay>(this as UnavailableDay, _$identity);

  /// Serializes this UnavailableDay to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as UnavailableDay;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UnavailableDay&&(identical(other.date, _this.date) || other.date == _this.date)&&(identical(other.reason, _this.reason) || other.reason == _this.reason));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as UnavailableDay;
  return Object.hash(runtimeType,_this.date,_this.reason);
}

@override
String toString() {
  final _this = this as UnavailableDay;
  return 'UnavailableDay(date: ${_this.date}, reason: ${_this.reason})';
}


}

/// @nodoc
abstract mixin class $UnavailableDayCopyWith<$Res>  {
  factory $UnavailableDayCopyWith(UnavailableDay value, $Res Function(UnavailableDay) _then) = _$UnavailableDayCopyWithImpl;
@useResult
$Res call({
@CalendarDateConverter() DateTime date,@JsonKey(unknownEnumValue: UnavailableReason.booked) UnavailableReason reason
});




}
/// @nodoc
class _$UnavailableDayCopyWithImpl<$Res>
    implements $UnavailableDayCopyWith<$Res> {
  _$UnavailableDayCopyWithImpl(this._self, this._then);

  final UnavailableDay _self;
  final $Res Function(UnavailableDay) _then;

/// Create a copy of UnavailableDay
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? date = null,Object? reason = null,}) {
  return _then(UnavailableDay(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as UnavailableReason,
  ));
}

}


/// Adds pattern-matching-related methods to [UnavailableDay].
extension UnavailableDayPatterns on UnavailableDay {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UnavailableDay value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UnavailableDay() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UnavailableDay value)  $default,){
final _that = this;
switch (_that) {
case _UnavailableDay():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UnavailableDay value)?  $default,){
final _that = this;
switch (_that) {
case _UnavailableDay() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@CalendarDateConverter()  DateTime date, @JsonKey(unknownEnumValue: UnavailableReason.booked)  UnavailableReason reason)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UnavailableDay() when $default != null:
return $default(_that.date,_that.reason);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@CalendarDateConverter()  DateTime date, @JsonKey(unknownEnumValue: UnavailableReason.booked)  UnavailableReason reason)  $default,) {final _that = this;
switch (_that) {
case _UnavailableDay():
return $default(_that.date,_that.reason);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@CalendarDateConverter()  DateTime date, @JsonKey(unknownEnumValue: UnavailableReason.booked)  UnavailableReason reason)?  $default,) {final _that = this;
switch (_that) {
case _UnavailableDay() when $default != null:
return $default(_that.date,_that.reason);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UnavailableDay implements UnavailableDay {
  const _UnavailableDay({@CalendarDateConverter() required this.date, @JsonKey(unknownEnumValue: UnavailableReason.booked) required this.reason});
  factory _UnavailableDay.fromJson(Map<String, dynamic> json) => _$UnavailableDayFromJson(json);

@override@CalendarDateConverter() final  DateTime date;
@override@JsonKey(unknownEnumValue: UnavailableReason.booked) final  UnavailableReason reason;

/// Create a copy of UnavailableDay
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UnavailableDayCopyWith<_UnavailableDay> get copyWith => __$UnavailableDayCopyWithImpl<_UnavailableDay>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UnavailableDayToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _UnavailableDay&&(identical(other.date, date) || other.date == date)&&(identical(other.reason, reason) || other.reason == reason));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,date,reason);
}

@override
String toString() {
    return 'UnavailableDay(date: $date, reason: $reason)';
}


}

/// @nodoc
abstract mixin class _$UnavailableDayCopyWith<$Res> implements $UnavailableDayCopyWith<$Res> {
  factory _$UnavailableDayCopyWith(_UnavailableDay value, $Res Function(_UnavailableDay) _then) = __$UnavailableDayCopyWithImpl;
@override @useResult
$Res call({
@CalendarDateConverter() DateTime date,@JsonKey(unknownEnumValue: UnavailableReason.booked) UnavailableReason reason
});




}
/// @nodoc
class __$UnavailableDayCopyWithImpl<$Res>
    implements _$UnavailableDayCopyWith<$Res> {
  __$UnavailableDayCopyWithImpl(this._self, this._then);

  final _UnavailableDay _self;
  final $Res Function(_UnavailableDay) _then;

/// Create a copy of UnavailableDay
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? date = null,Object? reason = null,}) {
  return _then(_UnavailableDay(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as UnavailableReason,
  ));
}


}

// dart format on
