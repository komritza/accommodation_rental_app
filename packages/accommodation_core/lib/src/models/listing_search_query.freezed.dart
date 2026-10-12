// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'listing_search_query.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ListingSearchQuery {

 String? get city; int? get guests; num? get minPrice; num? get maxPrice; StayDates? get dates;
/// Create a copy of ListingSearchQuery
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ListingSearchQueryCopyWith<ListingSearchQuery> get copyWith => _$ListingSearchQueryCopyWithImpl<ListingSearchQuery>(this as ListingSearchQuery, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ListingSearchQuery;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ListingSearchQuery&&(identical(other.city, _this.city) || other.city == _this.city)&&(identical(other.guests, _this.guests) || other.guests == _this.guests)&&(identical(other.minPrice, _this.minPrice) || other.minPrice == _this.minPrice)&&(identical(other.maxPrice, _this.maxPrice) || other.maxPrice == _this.maxPrice)&&(identical(other.dates, _this.dates) || other.dates == _this.dates));
}


@override
int get hashCode {
  final _this = this as ListingSearchQuery;
  return Object.hash(runtimeType,_this.city,_this.guests,_this.minPrice,_this.maxPrice,_this.dates);
}

@override
String toString() {
  final _this = this as ListingSearchQuery;
  return 'ListingSearchQuery(city: ${_this.city}, guests: ${_this.guests}, minPrice: ${_this.minPrice}, maxPrice: ${_this.maxPrice}, dates: ${_this.dates})';
}


}

/// @nodoc
abstract mixin class $ListingSearchQueryCopyWith<$Res>  {
  factory $ListingSearchQueryCopyWith(ListingSearchQuery value, $Res Function(ListingSearchQuery) _then) = _$ListingSearchQueryCopyWithImpl;
@useResult
$Res call({
 String? city, int? guests, num? minPrice, num? maxPrice, StayDates? dates
});




}
/// @nodoc
class _$ListingSearchQueryCopyWithImpl<$Res>
    implements $ListingSearchQueryCopyWith<$Res> {
  _$ListingSearchQueryCopyWithImpl(this._self, this._then);

  final ListingSearchQuery _self;
  final $Res Function(ListingSearchQuery) _then;

/// Create a copy of ListingSearchQuery
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? city = freezed,Object? guests = freezed,Object? minPrice = freezed,Object? maxPrice = freezed,Object? dates = freezed,}) {
  return _then(ListingSearchQuery(
city: freezed == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String?,guests: freezed == guests ? _self.guests : guests // ignore: cast_nullable_to_non_nullable
as int?,minPrice: freezed == minPrice ? _self.minPrice : minPrice // ignore: cast_nullable_to_non_nullable
as num?,maxPrice: freezed == maxPrice ? _self.maxPrice : maxPrice // ignore: cast_nullable_to_non_nullable
as num?,dates: freezed == dates ? _self.dates : dates // ignore: cast_nullable_to_non_nullable
as StayDates?,
  ));
}

}


/// Adds pattern-matching-related methods to [ListingSearchQuery].
extension ListingSearchQueryPatterns on ListingSearchQuery {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ListingSearchQuery value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ListingSearchQuery() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ListingSearchQuery value)  $default,){
final _that = this;
switch (_that) {
case _ListingSearchQuery():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ListingSearchQuery value)?  $default,){
final _that = this;
switch (_that) {
case _ListingSearchQuery() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? city,  int? guests,  num? minPrice,  num? maxPrice,  StayDates? dates)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ListingSearchQuery() when $default != null:
return $default(_that.city,_that.guests,_that.minPrice,_that.maxPrice,_that.dates);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? city,  int? guests,  num? minPrice,  num? maxPrice,  StayDates? dates)  $default,) {final _that = this;
switch (_that) {
case _ListingSearchQuery():
return $default(_that.city,_that.guests,_that.minPrice,_that.maxPrice,_that.dates);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? city,  int? guests,  num? minPrice,  num? maxPrice,  StayDates? dates)?  $default,) {final _that = this;
switch (_that) {
case _ListingSearchQuery() when $default != null:
return $default(_that.city,_that.guests,_that.minPrice,_that.maxPrice,_that.dates);case _:
  return null;

}
}

}

/// @nodoc


class _ListingSearchQuery extends ListingSearchQuery {
  const _ListingSearchQuery({this.city, this.guests, this.minPrice, this.maxPrice, this.dates}): super._();
  

@override final  String? city;
@override final  int? guests;
@override final  num? minPrice;
@override final  num? maxPrice;
@override final  StayDates? dates;

/// Create a copy of ListingSearchQuery
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ListingSearchQueryCopyWith<_ListingSearchQuery> get copyWith => __$ListingSearchQueryCopyWithImpl<_ListingSearchQuery>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ListingSearchQuery&&(identical(other.city, city) || other.city == city)&&(identical(other.guests, guests) || other.guests == guests)&&(identical(other.minPrice, minPrice) || other.minPrice == minPrice)&&(identical(other.maxPrice, maxPrice) || other.maxPrice == maxPrice)&&(identical(other.dates, dates) || other.dates == dates));
}


@override
int get hashCode {
    return Object.hash(runtimeType,city,guests,minPrice,maxPrice,dates);
}

@override
String toString() {
    return 'ListingSearchQuery(city: $city, guests: $guests, minPrice: $minPrice, maxPrice: $maxPrice, dates: $dates)';
}


}

/// @nodoc
abstract mixin class _$ListingSearchQueryCopyWith<$Res> implements $ListingSearchQueryCopyWith<$Res> {
  factory _$ListingSearchQueryCopyWith(_ListingSearchQuery value, $Res Function(_ListingSearchQuery) _then) = __$ListingSearchQueryCopyWithImpl;
@override @useResult
$Res call({
 String? city, int? guests, num? minPrice, num? maxPrice, StayDates? dates
});




}
/// @nodoc
class __$ListingSearchQueryCopyWithImpl<$Res>
    implements _$ListingSearchQueryCopyWith<$Res> {
  __$ListingSearchQueryCopyWithImpl(this._self, this._then);

  final _ListingSearchQuery _self;
  final $Res Function(_ListingSearchQuery) _then;

/// Create a copy of ListingSearchQuery
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? city = freezed,Object? guests = freezed,Object? minPrice = freezed,Object? maxPrice = freezed,Object? dates = freezed,}) {
  return _then(_ListingSearchQuery(
city: freezed == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String?,guests: freezed == guests ? _self.guests : guests // ignore: cast_nullable_to_non_nullable
as int?,minPrice: freezed == minPrice ? _self.minPrice : minPrice // ignore: cast_nullable_to_non_nullable
as num?,maxPrice: freezed == maxPrice ? _self.maxPrice : maxPrice // ignore: cast_nullable_to_non_nullable
as num?,dates: freezed == dates ? _self.dates : dates // ignore: cast_nullable_to_non_nullable
as StayDates?,
  ));
}


}

// dart format on
