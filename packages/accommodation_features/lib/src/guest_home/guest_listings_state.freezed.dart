// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'guest_listings_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$GuestListingsState {

 List<Listing> get listings; int get totalCount; String? get nextCursor; bool get isLoadingMore; ApiFailure? get loadMoreFailure;
/// Create a copy of GuestListingsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GuestListingsStateCopyWith<GuestListingsState> get copyWith => _$GuestListingsStateCopyWithImpl<GuestListingsState>(this as GuestListingsState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as GuestListingsState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GuestListingsState&&const DeepCollectionEquality().equals(other.listings, _this.listings)&&(identical(other.totalCount, _this.totalCount) || other.totalCount == _this.totalCount)&&(identical(other.nextCursor, _this.nextCursor) || other.nextCursor == _this.nextCursor)&&(identical(other.isLoadingMore, _this.isLoadingMore) || other.isLoadingMore == _this.isLoadingMore)&&(identical(other.loadMoreFailure, _this.loadMoreFailure) || other.loadMoreFailure == _this.loadMoreFailure));
}


@override
int get hashCode {
  final _this = this as GuestListingsState;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.listings),_this.totalCount,_this.nextCursor,_this.isLoadingMore,_this.loadMoreFailure);
}

@override
String toString() {
  final _this = this as GuestListingsState;
  return 'GuestListingsState(listings: ${_this.listings}, totalCount: ${_this.totalCount}, nextCursor: ${_this.nextCursor}, isLoadingMore: ${_this.isLoadingMore}, loadMoreFailure: ${_this.loadMoreFailure})';
}


}

/// @nodoc
abstract mixin class $GuestListingsStateCopyWith<$Res>  {
  factory $GuestListingsStateCopyWith(GuestListingsState value, $Res Function(GuestListingsState) _then) = _$GuestListingsStateCopyWithImpl;
@useResult
$Res call({
 List<Listing> listings, int totalCount, String? nextCursor, bool isLoadingMore, ApiFailure? loadMoreFailure
});




}
/// @nodoc
class _$GuestListingsStateCopyWithImpl<$Res>
    implements $GuestListingsStateCopyWith<$Res> {
  _$GuestListingsStateCopyWithImpl(this._self, this._then);

  final GuestListingsState _self;
  final $Res Function(GuestListingsState) _then;

/// Create a copy of GuestListingsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? listings = null,Object? totalCount = null,Object? nextCursor = freezed,Object? isLoadingMore = null,Object? loadMoreFailure = freezed,}) {
  return _then(GuestListingsState(
listings: null == listings ? _self.listings : listings // ignore: cast_nullable_to_non_nullable
as List<Listing>,totalCount: null == totalCount ? _self.totalCount : totalCount // ignore: cast_nullable_to_non_nullable
as int,nextCursor: freezed == nextCursor ? _self.nextCursor : nextCursor // ignore: cast_nullable_to_non_nullable
as String?,isLoadingMore: null == isLoadingMore ? _self.isLoadingMore : isLoadingMore // ignore: cast_nullable_to_non_nullable
as bool,loadMoreFailure: freezed == loadMoreFailure ? _self.loadMoreFailure : loadMoreFailure // ignore: cast_nullable_to_non_nullable
as ApiFailure?,
  ));
}

}


/// Adds pattern-matching-related methods to [GuestListingsState].
extension GuestListingsStatePatterns on GuestListingsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GuestListingsState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GuestListingsState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GuestListingsState value)  $default,){
final _that = this;
switch (_that) {
case _GuestListingsState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GuestListingsState value)?  $default,){
final _that = this;
switch (_that) {
case _GuestListingsState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<Listing> listings,  int totalCount,  String? nextCursor,  bool isLoadingMore,  ApiFailure? loadMoreFailure)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GuestListingsState() when $default != null:
return $default(_that.listings,_that.totalCount,_that.nextCursor,_that.isLoadingMore,_that.loadMoreFailure);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<Listing> listings,  int totalCount,  String? nextCursor,  bool isLoadingMore,  ApiFailure? loadMoreFailure)  $default,) {final _that = this;
switch (_that) {
case _GuestListingsState():
return $default(_that.listings,_that.totalCount,_that.nextCursor,_that.isLoadingMore,_that.loadMoreFailure);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<Listing> listings,  int totalCount,  String? nextCursor,  bool isLoadingMore,  ApiFailure? loadMoreFailure)?  $default,) {final _that = this;
switch (_that) {
case _GuestListingsState() when $default != null:
return $default(_that.listings,_that.totalCount,_that.nextCursor,_that.isLoadingMore,_that.loadMoreFailure);case _:
  return null;

}
}

}

/// @nodoc


class _GuestListingsState extends GuestListingsState {
  const _GuestListingsState({required  List<Listing> listings, required this.totalCount, this.nextCursor, this.isLoadingMore = false, this.loadMoreFailure}): _listings = listings,super._();
  

 final  List<Listing> _listings;
@override List<Listing> get listings {
  if (_listings is EqualUnmodifiableListView) return _listings;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_listings);
}

@override final  int totalCount;
@override final  String? nextCursor;
@override@JsonKey() final  bool isLoadingMore;
@override final  ApiFailure? loadMoreFailure;

/// Create a copy of GuestListingsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GuestListingsStateCopyWith<_GuestListingsState> get copyWith => __$GuestListingsStateCopyWithImpl<_GuestListingsState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _GuestListingsState&&const DeepCollectionEquality().equals(other.listings, _listings)&&(identical(other.totalCount, totalCount) || other.totalCount == totalCount)&&(identical(other.nextCursor, nextCursor) || other.nextCursor == nextCursor)&&(identical(other.isLoadingMore, isLoadingMore) || other.isLoadingMore == isLoadingMore)&&(identical(other.loadMoreFailure, loadMoreFailure) || other.loadMoreFailure == loadMoreFailure));
}


@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_listings),totalCount,nextCursor,isLoadingMore,loadMoreFailure);
}

@override
String toString() {
    return 'GuestListingsState(listings: $listings, totalCount: $totalCount, nextCursor: $nextCursor, isLoadingMore: $isLoadingMore, loadMoreFailure: $loadMoreFailure)';
}


}

/// @nodoc
abstract mixin class _$GuestListingsStateCopyWith<$Res> implements $GuestListingsStateCopyWith<$Res> {
  factory _$GuestListingsStateCopyWith(_GuestListingsState value, $Res Function(_GuestListingsState) _then) = __$GuestListingsStateCopyWithImpl;
@override @useResult
$Res call({
 List<Listing> listings, int totalCount, String? nextCursor, bool isLoadingMore, ApiFailure? loadMoreFailure
});




}
/// @nodoc
class __$GuestListingsStateCopyWithImpl<$Res>
    implements _$GuestListingsStateCopyWith<$Res> {
  __$GuestListingsStateCopyWithImpl(this._self, this._then);

  final _GuestListingsState _self;
  final $Res Function(_GuestListingsState) _then;

/// Create a copy of GuestListingsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? listings = null,Object? totalCount = null,Object? nextCursor = freezed,Object? isLoadingMore = null,Object? loadMoreFailure = freezed,}) {
  return _then(_GuestListingsState(
listings: null == listings ? _self._listings : listings // ignore: cast_nullable_to_non_nullable
as List<Listing>,totalCount: null == totalCount ? _self.totalCount : totalCount // ignore: cast_nullable_to_non_nullable
as int,nextCursor: freezed == nextCursor ? _self.nextCursor : nextCursor // ignore: cast_nullable_to_non_nullable
as String?,isLoadingMore: null == isLoadingMore ? _self.isLoadingMore : isLoadingMore // ignore: cast_nullable_to_non_nullable
as bool,loadMoreFailure: freezed == loadMoreFailure ? _self.loadMoreFailure : loadMoreFailure // ignore: cast_nullable_to_non_nullable
as ApiFailure?,
  ));
}


}

// dart format on
