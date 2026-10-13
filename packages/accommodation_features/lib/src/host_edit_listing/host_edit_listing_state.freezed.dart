// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'host_edit_listing_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$HostEditListingState implements DiagnosticableTreeMixin {

 Listing get originalListing; String get title; String get description; num get pricePerNight; num get cleaningFee; int get maxGuests; int get bedrooms; int get beds; int get bathrooms; String get propertyType; List<String> get amenities; bool get isSaving; ApiFailure? get saveFailure;
/// Create a copy of HostEditListingState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HostEditListingStateCopyWith<HostEditListingState> get copyWith => _$HostEditListingStateCopyWithImpl<HostEditListingState>(this as HostEditListingState, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  final _this = this as HostEditListingState;
  properties
    ..add(DiagnosticsProperty('type', 'HostEditListingState'))
    ..add(DiagnosticsProperty('originalListing', _this.originalListing))..add(DiagnosticsProperty('title', _this.title))..add(DiagnosticsProperty('description', _this.description))..add(DiagnosticsProperty('pricePerNight', _this.pricePerNight))..add(DiagnosticsProperty('cleaningFee', _this.cleaningFee))..add(DiagnosticsProperty('maxGuests', _this.maxGuests))..add(DiagnosticsProperty('bedrooms', _this.bedrooms))..add(DiagnosticsProperty('beds', _this.beds))..add(DiagnosticsProperty('bathrooms', _this.bathrooms))..add(DiagnosticsProperty('propertyType', _this.propertyType))..add(DiagnosticsProperty('amenities', _this.amenities))..add(DiagnosticsProperty('isSaving', _this.isSaving))..add(DiagnosticsProperty('saveFailure', _this.saveFailure));
}

@override
bool operator ==(Object other) {
  final _this = this as HostEditListingState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HostEditListingState&&(identical(other.originalListing, _this.originalListing) || other.originalListing == _this.originalListing)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.description, _this.description) || other.description == _this.description)&&(identical(other.pricePerNight, _this.pricePerNight) || other.pricePerNight == _this.pricePerNight)&&(identical(other.cleaningFee, _this.cleaningFee) || other.cleaningFee == _this.cleaningFee)&&(identical(other.maxGuests, _this.maxGuests) || other.maxGuests == _this.maxGuests)&&(identical(other.bedrooms, _this.bedrooms) || other.bedrooms == _this.bedrooms)&&(identical(other.beds, _this.beds) || other.beds == _this.beds)&&(identical(other.bathrooms, _this.bathrooms) || other.bathrooms == _this.bathrooms)&&(identical(other.propertyType, _this.propertyType) || other.propertyType == _this.propertyType)&&const DeepCollectionEquality().equals(other.amenities, _this.amenities)&&(identical(other.isSaving, _this.isSaving) || other.isSaving == _this.isSaving)&&(identical(other.saveFailure, _this.saveFailure) || other.saveFailure == _this.saveFailure));
}


@override
int get hashCode {
  final _this = this as HostEditListingState;
  return Object.hash(runtimeType,_this.originalListing,_this.title,_this.description,_this.pricePerNight,_this.cleaningFee,_this.maxGuests,_this.bedrooms,_this.beds,_this.bathrooms,_this.propertyType,const DeepCollectionEquality().hash(_this.amenities),_this.isSaving,_this.saveFailure);
}

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  final _this = this as HostEditListingState;
  return 'HostEditListingState(originalListing: ${_this.originalListing}, title: ${_this.title}, description: ${_this.description}, pricePerNight: ${_this.pricePerNight}, cleaningFee: ${_this.cleaningFee}, maxGuests: ${_this.maxGuests}, bedrooms: ${_this.bedrooms}, beds: ${_this.beds}, bathrooms: ${_this.bathrooms}, propertyType: ${_this.propertyType}, amenities: ${_this.amenities}, isSaving: ${_this.isSaving}, saveFailure: ${_this.saveFailure})';
}


}

/// @nodoc
abstract mixin class $HostEditListingStateCopyWith<$Res>  {
  factory $HostEditListingStateCopyWith(HostEditListingState value, $Res Function(HostEditListingState) _then) = _$HostEditListingStateCopyWithImpl;
@useResult
$Res call({
 Listing originalListing, String title, String description, num pricePerNight, num cleaningFee, int maxGuests, int bedrooms, int beds, int bathrooms, String propertyType, List<String> amenities, bool isSaving, ApiFailure? saveFailure
});


$ListingCopyWith<$Res> get originalListing;

}
/// @nodoc
class _$HostEditListingStateCopyWithImpl<$Res>
    implements $HostEditListingStateCopyWith<$Res> {
  _$HostEditListingStateCopyWithImpl(this._self, this._then);

  final HostEditListingState _self;
  final $Res Function(HostEditListingState) _then;

/// Create a copy of HostEditListingState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? originalListing = null,Object? title = null,Object? description = null,Object? pricePerNight = null,Object? cleaningFee = null,Object? maxGuests = null,Object? bedrooms = null,Object? beds = null,Object? bathrooms = null,Object? propertyType = null,Object? amenities = null,Object? isSaving = null,Object? saveFailure = freezed,}) {
  return _then(HostEditListingState(
originalListing: null == originalListing ? _self.originalListing : originalListing // ignore: cast_nullable_to_non_nullable
as Listing,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,pricePerNight: null == pricePerNight ? _self.pricePerNight : pricePerNight // ignore: cast_nullable_to_non_nullable
as num,cleaningFee: null == cleaningFee ? _self.cleaningFee : cleaningFee // ignore: cast_nullable_to_non_nullable
as num,maxGuests: null == maxGuests ? _self.maxGuests : maxGuests // ignore: cast_nullable_to_non_nullable
as int,bedrooms: null == bedrooms ? _self.bedrooms : bedrooms // ignore: cast_nullable_to_non_nullable
as int,beds: null == beds ? _self.beds : beds // ignore: cast_nullable_to_non_nullable
as int,bathrooms: null == bathrooms ? _self.bathrooms : bathrooms // ignore: cast_nullable_to_non_nullable
as int,propertyType: null == propertyType ? _self.propertyType : propertyType // ignore: cast_nullable_to_non_nullable
as String,amenities: null == amenities ? _self.amenities : amenities // ignore: cast_nullable_to_non_nullable
as List<String>,isSaving: null == isSaving ? _self.isSaving : isSaving // ignore: cast_nullable_to_non_nullable
as bool,saveFailure: freezed == saveFailure ? _self.saveFailure : saveFailure // ignore: cast_nullable_to_non_nullable
as ApiFailure?,
  ));
}
/// Create a copy of HostEditListingState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ListingCopyWith<$Res> get originalListing {
  
  return $ListingCopyWith<$Res>(_self.originalListing, (value) {
    return _then(_self.copyWith(originalListing: value));
  });
}
}


/// Adds pattern-matching-related methods to [HostEditListingState].
extension HostEditListingStatePatterns on HostEditListingState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HostEditListingState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HostEditListingState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HostEditListingState value)  $default,){
final _that = this;
switch (_that) {
case _HostEditListingState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HostEditListingState value)?  $default,){
final _that = this;
switch (_that) {
case _HostEditListingState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Listing originalListing,  String title,  String description,  num pricePerNight,  num cleaningFee,  int maxGuests,  int bedrooms,  int beds,  int bathrooms,  String propertyType,  List<String> amenities,  bool isSaving,  ApiFailure? saveFailure)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HostEditListingState() when $default != null:
return $default(_that.originalListing,_that.title,_that.description,_that.pricePerNight,_that.cleaningFee,_that.maxGuests,_that.bedrooms,_that.beds,_that.bathrooms,_that.propertyType,_that.amenities,_that.isSaving,_that.saveFailure);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Listing originalListing,  String title,  String description,  num pricePerNight,  num cleaningFee,  int maxGuests,  int bedrooms,  int beds,  int bathrooms,  String propertyType,  List<String> amenities,  bool isSaving,  ApiFailure? saveFailure)  $default,) {final _that = this;
switch (_that) {
case _HostEditListingState():
return $default(_that.originalListing,_that.title,_that.description,_that.pricePerNight,_that.cleaningFee,_that.maxGuests,_that.bedrooms,_that.beds,_that.bathrooms,_that.propertyType,_that.amenities,_that.isSaving,_that.saveFailure);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Listing originalListing,  String title,  String description,  num pricePerNight,  num cleaningFee,  int maxGuests,  int bedrooms,  int beds,  int bathrooms,  String propertyType,  List<String> amenities,  bool isSaving,  ApiFailure? saveFailure)?  $default,) {final _that = this;
switch (_that) {
case _HostEditListingState() when $default != null:
return $default(_that.originalListing,_that.title,_that.description,_that.pricePerNight,_that.cleaningFee,_that.maxGuests,_that.bedrooms,_that.beds,_that.bathrooms,_that.propertyType,_that.amenities,_that.isSaving,_that.saveFailure);case _:
  return null;

}
}

}

/// @nodoc


class _HostEditListingState extends HostEditListingState with DiagnosticableTreeMixin {
  const _HostEditListingState({required this.originalListing, required this.title, required this.description, required this.pricePerNight, required this.cleaningFee, required this.maxGuests, required this.bedrooms, required this.beds, required this.bathrooms, required this.propertyType, required  List<String> amenities, this.isSaving = false, this.saveFailure}): _amenities = amenities,super._();
  

@override final  Listing originalListing;
@override final  String title;
@override final  String description;
@override final  num pricePerNight;
@override final  num cleaningFee;
@override final  int maxGuests;
@override final  int bedrooms;
@override final  int beds;
@override final  int bathrooms;
@override final  String propertyType;
 final  List<String> _amenities;
@override List<String> get amenities {
  if (_amenities is EqualUnmodifiableListView) return _amenities;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_amenities);
}

@override@JsonKey() final  bool isSaving;
@override final  ApiFailure? saveFailure;

/// Create a copy of HostEditListingState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HostEditListingStateCopyWith<_HostEditListingState> get copyWith => __$HostEditListingStateCopyWithImpl<_HostEditListingState>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
    ..add(DiagnosticsProperty('type', 'HostEditListingState'))
    ..add(DiagnosticsProperty('originalListing', originalListing))..add(DiagnosticsProperty('title', title))..add(DiagnosticsProperty('description', description))..add(DiagnosticsProperty('pricePerNight', pricePerNight))..add(DiagnosticsProperty('cleaningFee', cleaningFee))..add(DiagnosticsProperty('maxGuests', maxGuests))..add(DiagnosticsProperty('bedrooms', bedrooms))..add(DiagnosticsProperty('beds', beds))..add(DiagnosticsProperty('bathrooms', bathrooms))..add(DiagnosticsProperty('propertyType', propertyType))..add(DiagnosticsProperty('amenities', amenities))..add(DiagnosticsProperty('isSaving', isSaving))..add(DiagnosticsProperty('saveFailure', saveFailure));
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _HostEditListingState&&(identical(other.originalListing, originalListing) || other.originalListing == originalListing)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.pricePerNight, pricePerNight) || other.pricePerNight == pricePerNight)&&(identical(other.cleaningFee, cleaningFee) || other.cleaningFee == cleaningFee)&&(identical(other.maxGuests, maxGuests) || other.maxGuests == maxGuests)&&(identical(other.bedrooms, bedrooms) || other.bedrooms == bedrooms)&&(identical(other.beds, beds) || other.beds == beds)&&(identical(other.bathrooms, bathrooms) || other.bathrooms == bathrooms)&&(identical(other.propertyType, propertyType) || other.propertyType == propertyType)&&const DeepCollectionEquality().equals(other.amenities, _amenities)&&(identical(other.isSaving, isSaving) || other.isSaving == isSaving)&&(identical(other.saveFailure, saveFailure) || other.saveFailure == saveFailure));
}


@override
int get hashCode {
    return Object.hash(runtimeType,originalListing,title,description,pricePerNight,cleaningFee,maxGuests,bedrooms,beds,bathrooms,propertyType,const DeepCollectionEquality().hash(_amenities),isSaving,saveFailure);
}

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
    return 'HostEditListingState(originalListing: $originalListing, title: $title, description: $description, pricePerNight: $pricePerNight, cleaningFee: $cleaningFee, maxGuests: $maxGuests, bedrooms: $bedrooms, beds: $beds, bathrooms: $bathrooms, propertyType: $propertyType, amenities: $amenities, isSaving: $isSaving, saveFailure: $saveFailure)';
}


}

/// @nodoc
abstract mixin class _$HostEditListingStateCopyWith<$Res> implements $HostEditListingStateCopyWith<$Res> {
  factory _$HostEditListingStateCopyWith(_HostEditListingState value, $Res Function(_HostEditListingState) _then) = __$HostEditListingStateCopyWithImpl;
@override @useResult
$Res call({
 Listing originalListing, String title, String description, num pricePerNight, num cleaningFee, int maxGuests, int bedrooms, int beds, int bathrooms, String propertyType, List<String> amenities, bool isSaving, ApiFailure? saveFailure
});


@override $ListingCopyWith<$Res> get originalListing;

}
/// @nodoc
class __$HostEditListingStateCopyWithImpl<$Res>
    implements _$HostEditListingStateCopyWith<$Res> {
  __$HostEditListingStateCopyWithImpl(this._self, this._then);

  final _HostEditListingState _self;
  final $Res Function(_HostEditListingState) _then;

/// Create a copy of HostEditListingState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? originalListing = null,Object? title = null,Object? description = null,Object? pricePerNight = null,Object? cleaningFee = null,Object? maxGuests = null,Object? bedrooms = null,Object? beds = null,Object? bathrooms = null,Object? propertyType = null,Object? amenities = null,Object? isSaving = null,Object? saveFailure = freezed,}) {
  return _then(_HostEditListingState(
originalListing: null == originalListing ? _self.originalListing : originalListing // ignore: cast_nullable_to_non_nullable
as Listing,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,pricePerNight: null == pricePerNight ? _self.pricePerNight : pricePerNight // ignore: cast_nullable_to_non_nullable
as num,cleaningFee: null == cleaningFee ? _self.cleaningFee : cleaningFee // ignore: cast_nullable_to_non_nullable
as num,maxGuests: null == maxGuests ? _self.maxGuests : maxGuests // ignore: cast_nullable_to_non_nullable
as int,bedrooms: null == bedrooms ? _self.bedrooms : bedrooms // ignore: cast_nullable_to_non_nullable
as int,beds: null == beds ? _self.beds : beds // ignore: cast_nullable_to_non_nullable
as int,bathrooms: null == bathrooms ? _self.bathrooms : bathrooms // ignore: cast_nullable_to_non_nullable
as int,propertyType: null == propertyType ? _self.propertyType : propertyType // ignore: cast_nullable_to_non_nullable
as String,amenities: null == amenities ? _self._amenities : amenities // ignore: cast_nullable_to_non_nullable
as List<String>,isSaving: null == isSaving ? _self.isSaving : isSaving // ignore: cast_nullable_to_non_nullable
as bool,saveFailure: freezed == saveFailure ? _self.saveFailure : saveFailure // ignore: cast_nullable_to_non_nullable
as ApiFailure?,
  ));
}

/// Create a copy of HostEditListingState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ListingCopyWith<$Res> get originalListing {
  
  return $ListingCopyWith<$Res>(_self.originalListing, (value) {
    return _then(_self.copyWith(originalListing: value));
  });
}
}

// dart format on
