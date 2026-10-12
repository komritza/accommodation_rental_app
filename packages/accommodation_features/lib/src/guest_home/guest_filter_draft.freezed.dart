// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'guest_filter_draft.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$GuestFilterDraftState {

 ListingSearchQuery get filters; DateTime? get pendingCheckIn;
/// Create a copy of GuestFilterDraftState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GuestFilterDraftStateCopyWith<GuestFilterDraftState> get copyWith => _$GuestFilterDraftStateCopyWithImpl<GuestFilterDraftState>(this as GuestFilterDraftState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as GuestFilterDraftState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GuestFilterDraftState&&(identical(other.filters, _this.filters) || other.filters == _this.filters)&&(identical(other.pendingCheckIn, _this.pendingCheckIn) || other.pendingCheckIn == _this.pendingCheckIn));
}


@override
int get hashCode {
  final _this = this as GuestFilterDraftState;
  return Object.hash(runtimeType,_this.filters,_this.pendingCheckIn);
}

@override
String toString() {
  final _this = this as GuestFilterDraftState;
  return 'GuestFilterDraftState(filters: ${_this.filters}, pendingCheckIn: ${_this.pendingCheckIn})';
}


}

/// @nodoc
abstract mixin class $GuestFilterDraftStateCopyWith<$Res>  {
  factory $GuestFilterDraftStateCopyWith(GuestFilterDraftState value, $Res Function(GuestFilterDraftState) _then) = _$GuestFilterDraftStateCopyWithImpl;
@useResult
$Res call({
 ListingSearchQuery filters, DateTime? pendingCheckIn
});


$ListingSearchQueryCopyWith<$Res> get filters;

}
/// @nodoc
class _$GuestFilterDraftStateCopyWithImpl<$Res>
    implements $GuestFilterDraftStateCopyWith<$Res> {
  _$GuestFilterDraftStateCopyWithImpl(this._self, this._then);

  final GuestFilterDraftState _self;
  final $Res Function(GuestFilterDraftState) _then;

/// Create a copy of GuestFilterDraftState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? filters = null,Object? pendingCheckIn = freezed,}) {
  return _then(GuestFilterDraftState(
filters: null == filters ? _self.filters : filters // ignore: cast_nullable_to_non_nullable
as ListingSearchQuery,pendingCheckIn: freezed == pendingCheckIn ? _self.pendingCheckIn : pendingCheckIn // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}
/// Create a copy of GuestFilterDraftState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ListingSearchQueryCopyWith<$Res> get filters {
  
  return $ListingSearchQueryCopyWith<$Res>(_self.filters, (value) {
    return _then(_self.copyWith(filters: value));
  });
}
}


/// Adds pattern-matching-related methods to [GuestFilterDraftState].
extension GuestFilterDraftStatePatterns on GuestFilterDraftState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GuestFilterDraftState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GuestFilterDraftState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GuestFilterDraftState value)  $default,){
final _that = this;
switch (_that) {
case _GuestFilterDraftState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GuestFilterDraftState value)?  $default,){
final _that = this;
switch (_that) {
case _GuestFilterDraftState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ListingSearchQuery filters,  DateTime? pendingCheckIn)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GuestFilterDraftState() when $default != null:
return $default(_that.filters,_that.pendingCheckIn);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ListingSearchQuery filters,  DateTime? pendingCheckIn)  $default,) {final _that = this;
switch (_that) {
case _GuestFilterDraftState():
return $default(_that.filters,_that.pendingCheckIn);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ListingSearchQuery filters,  DateTime? pendingCheckIn)?  $default,) {final _that = this;
switch (_that) {
case _GuestFilterDraftState() when $default != null:
return $default(_that.filters,_that.pendingCheckIn);case _:
  return null;

}
}

}

/// @nodoc


class _GuestFilterDraftState implements GuestFilterDraftState {
  const _GuestFilterDraftState({required this.filters, this.pendingCheckIn});
  

@override final  ListingSearchQuery filters;
@override final  DateTime? pendingCheckIn;

/// Create a copy of GuestFilterDraftState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GuestFilterDraftStateCopyWith<_GuestFilterDraftState> get copyWith => __$GuestFilterDraftStateCopyWithImpl<_GuestFilterDraftState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _GuestFilterDraftState&&(identical(other.filters, filters) || other.filters == filters)&&(identical(other.pendingCheckIn, pendingCheckIn) || other.pendingCheckIn == pendingCheckIn));
}


@override
int get hashCode {
    return Object.hash(runtimeType,filters,pendingCheckIn);
}

@override
String toString() {
    return 'GuestFilterDraftState(filters: $filters, pendingCheckIn: $pendingCheckIn)';
}


}

/// @nodoc
abstract mixin class _$GuestFilterDraftStateCopyWith<$Res> implements $GuestFilterDraftStateCopyWith<$Res> {
  factory _$GuestFilterDraftStateCopyWith(_GuestFilterDraftState value, $Res Function(_GuestFilterDraftState) _then) = __$GuestFilterDraftStateCopyWithImpl;
@override @useResult
$Res call({
 ListingSearchQuery filters, DateTime? pendingCheckIn
});


@override $ListingSearchQueryCopyWith<$Res> get filters;

}
/// @nodoc
class __$GuestFilterDraftStateCopyWithImpl<$Res>
    implements _$GuestFilterDraftStateCopyWith<$Res> {
  __$GuestFilterDraftStateCopyWithImpl(this._self, this._then);

  final _GuestFilterDraftState _self;
  final $Res Function(_GuestFilterDraftState) _then;

/// Create a copy of GuestFilterDraftState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? filters = null,Object? pendingCheckIn = freezed,}) {
  return _then(_GuestFilterDraftState(
filters: null == filters ? _self.filters : filters // ignore: cast_nullable_to_non_nullable
as ListingSearchQuery,pendingCheckIn: freezed == pendingCheckIn ? _self.pendingCheckIn : pendingCheckIn // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

/// Create a copy of GuestFilterDraftState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ListingSearchQueryCopyWith<$Res> get filters {
  
  return $ListingSearchQueryCopyWith<$Res>(_self.filters, (value) {
    return _then(_self.copyWith(filters: value));
  });
}
}

// dart format on
