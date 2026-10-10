// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tenant_runtime_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TenantRuntimeConfig {

 TenantSlug get slug; String get name; String get currency; List<TenantLocale> get locales; TenantLocale get defaultLocale; String get supportEmail; String get termsOfUseUrl; String get privacyPolicyUrl; TenantPermissions get permissions; TenantTheme get theme;
/// Create a copy of TenantRuntimeConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TenantRuntimeConfigCopyWith<TenantRuntimeConfig> get copyWith => _$TenantRuntimeConfigCopyWithImpl<TenantRuntimeConfig>(this as TenantRuntimeConfig, _$identity);

  /// Serializes this TenantRuntimeConfig to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as TenantRuntimeConfig;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TenantRuntimeConfig&&(identical(other.slug, _this.slug) || other.slug == _this.slug)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.currency, _this.currency) || other.currency == _this.currency)&&const DeepCollectionEquality().equals(other.locales, _this.locales)&&(identical(other.defaultLocale, _this.defaultLocale) || other.defaultLocale == _this.defaultLocale)&&(identical(other.supportEmail, _this.supportEmail) || other.supportEmail == _this.supportEmail)&&(identical(other.termsOfUseUrl, _this.termsOfUseUrl) || other.termsOfUseUrl == _this.termsOfUseUrl)&&(identical(other.privacyPolicyUrl, _this.privacyPolicyUrl) || other.privacyPolicyUrl == _this.privacyPolicyUrl)&&(identical(other.permissions, _this.permissions) || other.permissions == _this.permissions)&&(identical(other.theme, _this.theme) || other.theme == _this.theme));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as TenantRuntimeConfig;
  return Object.hash(runtimeType,_this.slug,_this.name,_this.currency,const DeepCollectionEquality().hash(_this.locales),_this.defaultLocale,_this.supportEmail,_this.termsOfUseUrl,_this.privacyPolicyUrl,_this.permissions,_this.theme);
}

@override
String toString() {
  final _this = this as TenantRuntimeConfig;
  return 'TenantRuntimeConfig(slug: ${_this.slug}, name: ${_this.name}, currency: ${_this.currency}, locales: ${_this.locales}, defaultLocale: ${_this.defaultLocale}, supportEmail: ${_this.supportEmail}, termsOfUseUrl: ${_this.termsOfUseUrl}, privacyPolicyUrl: ${_this.privacyPolicyUrl}, permissions: ${_this.permissions}, theme: ${_this.theme})';
}


}

/// @nodoc
abstract mixin class $TenantRuntimeConfigCopyWith<$Res>  {
  factory $TenantRuntimeConfigCopyWith(TenantRuntimeConfig value, $Res Function(TenantRuntimeConfig) _then) = _$TenantRuntimeConfigCopyWithImpl;
@useResult
$Res call({
 TenantSlug slug, String name, String currency, List<TenantLocale> locales, TenantLocale defaultLocale, String supportEmail, String termsOfUseUrl, String privacyPolicyUrl, TenantPermissions permissions, TenantTheme theme
});


$TenantPermissionsCopyWith<$Res> get permissions;$TenantThemeCopyWith<$Res> get theme;

}
/// @nodoc
class _$TenantRuntimeConfigCopyWithImpl<$Res>
    implements $TenantRuntimeConfigCopyWith<$Res> {
  _$TenantRuntimeConfigCopyWithImpl(this._self, this._then);

  final TenantRuntimeConfig _self;
  final $Res Function(TenantRuntimeConfig) _then;

/// Create a copy of TenantRuntimeConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? slug = null,Object? name = null,Object? currency = null,Object? locales = null,Object? defaultLocale = null,Object? supportEmail = null,Object? termsOfUseUrl = null,Object? privacyPolicyUrl = null,Object? permissions = null,Object? theme = null,}) {
  return _then(TenantRuntimeConfig(
slug: null == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as TenantSlug,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,locales: null == locales ? _self.locales : locales // ignore: cast_nullable_to_non_nullable
as List<TenantLocale>,defaultLocale: null == defaultLocale ? _self.defaultLocale : defaultLocale // ignore: cast_nullable_to_non_nullable
as TenantLocale,supportEmail: null == supportEmail ? _self.supportEmail : supportEmail // ignore: cast_nullable_to_non_nullable
as String,termsOfUseUrl: null == termsOfUseUrl ? _self.termsOfUseUrl : termsOfUseUrl // ignore: cast_nullable_to_non_nullable
as String,privacyPolicyUrl: null == privacyPolicyUrl ? _self.privacyPolicyUrl : privacyPolicyUrl // ignore: cast_nullable_to_non_nullable
as String,permissions: null == permissions ? _self.permissions : permissions // ignore: cast_nullable_to_non_nullable
as TenantPermissions,theme: null == theme ? _self.theme : theme // ignore: cast_nullable_to_non_nullable
as TenantTheme,
  ));
}
/// Create a copy of TenantRuntimeConfig
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TenantPermissionsCopyWith<$Res> get permissions {
  
  return $TenantPermissionsCopyWith<$Res>(_self.permissions, (value) {
    return _then(_self.copyWith(permissions: value));
  });
}/// Create a copy of TenantRuntimeConfig
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TenantThemeCopyWith<$Res> get theme {
  
  return $TenantThemeCopyWith<$Res>(_self.theme, (value) {
    return _then(_self.copyWith(theme: value));
  });
}
}


/// Adds pattern-matching-related methods to [TenantRuntimeConfig].
extension TenantRuntimeConfigPatterns on TenantRuntimeConfig {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TenantRuntimeConfig value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TenantRuntimeConfig() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TenantRuntimeConfig value)  $default,){
final _that = this;
switch (_that) {
case _TenantRuntimeConfig():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TenantRuntimeConfig value)?  $default,){
final _that = this;
switch (_that) {
case _TenantRuntimeConfig() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( TenantSlug slug,  String name,  String currency,  List<TenantLocale> locales,  TenantLocale defaultLocale,  String supportEmail,  String termsOfUseUrl,  String privacyPolicyUrl,  TenantPermissions permissions,  TenantTheme theme)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TenantRuntimeConfig() when $default != null:
return $default(_that.slug,_that.name,_that.currency,_that.locales,_that.defaultLocale,_that.supportEmail,_that.termsOfUseUrl,_that.privacyPolicyUrl,_that.permissions,_that.theme);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( TenantSlug slug,  String name,  String currency,  List<TenantLocale> locales,  TenantLocale defaultLocale,  String supportEmail,  String termsOfUseUrl,  String privacyPolicyUrl,  TenantPermissions permissions,  TenantTheme theme)  $default,) {final _that = this;
switch (_that) {
case _TenantRuntimeConfig():
return $default(_that.slug,_that.name,_that.currency,_that.locales,_that.defaultLocale,_that.supportEmail,_that.termsOfUseUrl,_that.privacyPolicyUrl,_that.permissions,_that.theme);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( TenantSlug slug,  String name,  String currency,  List<TenantLocale> locales,  TenantLocale defaultLocale,  String supportEmail,  String termsOfUseUrl,  String privacyPolicyUrl,  TenantPermissions permissions,  TenantTheme theme)?  $default,) {final _that = this;
switch (_that) {
case _TenantRuntimeConfig() when $default != null:
return $default(_that.slug,_that.name,_that.currency,_that.locales,_that.defaultLocale,_that.supportEmail,_that.termsOfUseUrl,_that.privacyPolicyUrl,_that.permissions,_that.theme);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TenantRuntimeConfig implements TenantRuntimeConfig {
  const _TenantRuntimeConfig({required this.slug, required this.name, required this.currency, required  List<TenantLocale> locales, required this.defaultLocale, required this.supportEmail, required this.termsOfUseUrl, required this.privacyPolicyUrl, required this.permissions, required this.theme}): _locales = locales;
  factory _TenantRuntimeConfig.fromJson(Map<String, dynamic> json) => _$TenantRuntimeConfigFromJson(json);

@override final  TenantSlug slug;
@override final  String name;
@override final  String currency;
 final  List<TenantLocale> _locales;
@override List<TenantLocale> get locales {
  if (_locales is EqualUnmodifiableListView) return _locales;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_locales);
}

@override final  TenantLocale defaultLocale;
@override final  String supportEmail;
@override final  String termsOfUseUrl;
@override final  String privacyPolicyUrl;
@override final  TenantPermissions permissions;
@override final  TenantTheme theme;

/// Create a copy of TenantRuntimeConfig
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TenantRuntimeConfigCopyWith<_TenantRuntimeConfig> get copyWith => __$TenantRuntimeConfigCopyWithImpl<_TenantRuntimeConfig>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TenantRuntimeConfigToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TenantRuntimeConfig&&(identical(other.slug, slug) || other.slug == slug)&&(identical(other.name, name) || other.name == name)&&(identical(other.currency, currency) || other.currency == currency)&&const DeepCollectionEquality().equals(other.locales, _locales)&&(identical(other.defaultLocale, defaultLocale) || other.defaultLocale == defaultLocale)&&(identical(other.supportEmail, supportEmail) || other.supportEmail == supportEmail)&&(identical(other.termsOfUseUrl, termsOfUseUrl) || other.termsOfUseUrl == termsOfUseUrl)&&(identical(other.privacyPolicyUrl, privacyPolicyUrl) || other.privacyPolicyUrl == privacyPolicyUrl)&&(identical(other.permissions, permissions) || other.permissions == permissions)&&(identical(other.theme, theme) || other.theme == theme));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,slug,name,currency,const DeepCollectionEquality().hash(_locales),defaultLocale,supportEmail,termsOfUseUrl,privacyPolicyUrl,permissions,theme);
}

@override
String toString() {
    return 'TenantRuntimeConfig(slug: $slug, name: $name, currency: $currency, locales: $locales, defaultLocale: $defaultLocale, supportEmail: $supportEmail, termsOfUseUrl: $termsOfUseUrl, privacyPolicyUrl: $privacyPolicyUrl, permissions: $permissions, theme: $theme)';
}


}

/// @nodoc
abstract mixin class _$TenantRuntimeConfigCopyWith<$Res> implements $TenantRuntimeConfigCopyWith<$Res> {
  factory _$TenantRuntimeConfigCopyWith(_TenantRuntimeConfig value, $Res Function(_TenantRuntimeConfig) _then) = __$TenantRuntimeConfigCopyWithImpl;
@override @useResult
$Res call({
 TenantSlug slug, String name, String currency, List<TenantLocale> locales, TenantLocale defaultLocale, String supportEmail, String termsOfUseUrl, String privacyPolicyUrl, TenantPermissions permissions, TenantTheme theme
});


@override $TenantPermissionsCopyWith<$Res> get permissions;@override $TenantThemeCopyWith<$Res> get theme;

}
/// @nodoc
class __$TenantRuntimeConfigCopyWithImpl<$Res>
    implements _$TenantRuntimeConfigCopyWith<$Res> {
  __$TenantRuntimeConfigCopyWithImpl(this._self, this._then);

  final _TenantRuntimeConfig _self;
  final $Res Function(_TenantRuntimeConfig) _then;

/// Create a copy of TenantRuntimeConfig
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? slug = null,Object? name = null,Object? currency = null,Object? locales = null,Object? defaultLocale = null,Object? supportEmail = null,Object? termsOfUseUrl = null,Object? privacyPolicyUrl = null,Object? permissions = null,Object? theme = null,}) {
  return _then(_TenantRuntimeConfig(
slug: null == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as TenantSlug,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,locales: null == locales ? _self._locales : locales // ignore: cast_nullable_to_non_nullable
as List<TenantLocale>,defaultLocale: null == defaultLocale ? _self.defaultLocale : defaultLocale // ignore: cast_nullable_to_non_nullable
as TenantLocale,supportEmail: null == supportEmail ? _self.supportEmail : supportEmail // ignore: cast_nullable_to_non_nullable
as String,termsOfUseUrl: null == termsOfUseUrl ? _self.termsOfUseUrl : termsOfUseUrl // ignore: cast_nullable_to_non_nullable
as String,privacyPolicyUrl: null == privacyPolicyUrl ? _self.privacyPolicyUrl : privacyPolicyUrl // ignore: cast_nullable_to_non_nullable
as String,permissions: null == permissions ? _self.permissions : permissions // ignore: cast_nullable_to_non_nullable
as TenantPermissions,theme: null == theme ? _self.theme : theme // ignore: cast_nullable_to_non_nullable
as TenantTheme,
  ));
}

/// Create a copy of TenantRuntimeConfig
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TenantPermissionsCopyWith<$Res> get permissions {
  
  return $TenantPermissionsCopyWith<$Res>(_self.permissions, (value) {
    return _then(_self.copyWith(permissions: value));
  });
}/// Create a copy of TenantRuntimeConfig
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TenantThemeCopyWith<$Res> get theme {
  
  return $TenantThemeCopyWith<$Res>(_self.theme, (value) {
    return _then(_self.copyWith(theme: value));
  });
}
}


/// @nodoc
mixin _$TenantPermissions {

 bool get hostPanel; bool get favourites; bool get reviews; bool get blockedDays;
/// Create a copy of TenantPermissions
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TenantPermissionsCopyWith<TenantPermissions> get copyWith => _$TenantPermissionsCopyWithImpl<TenantPermissions>(this as TenantPermissions, _$identity);

  /// Serializes this TenantPermissions to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as TenantPermissions;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TenantPermissions&&(identical(other.hostPanel, _this.hostPanel) || other.hostPanel == _this.hostPanel)&&(identical(other.favourites, _this.favourites) || other.favourites == _this.favourites)&&(identical(other.reviews, _this.reviews) || other.reviews == _this.reviews)&&(identical(other.blockedDays, _this.blockedDays) || other.blockedDays == _this.blockedDays));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as TenantPermissions;
  return Object.hash(runtimeType,_this.hostPanel,_this.favourites,_this.reviews,_this.blockedDays);
}

@override
String toString() {
  final _this = this as TenantPermissions;
  return 'TenantPermissions(hostPanel: ${_this.hostPanel}, favourites: ${_this.favourites}, reviews: ${_this.reviews}, blockedDays: ${_this.blockedDays})';
}


}

/// @nodoc
abstract mixin class $TenantPermissionsCopyWith<$Res>  {
  factory $TenantPermissionsCopyWith(TenantPermissions value, $Res Function(TenantPermissions) _then) = _$TenantPermissionsCopyWithImpl;
@useResult
$Res call({
 bool hostPanel, bool favourites, bool reviews, bool blockedDays
});




}
/// @nodoc
class _$TenantPermissionsCopyWithImpl<$Res>
    implements $TenantPermissionsCopyWith<$Res> {
  _$TenantPermissionsCopyWithImpl(this._self, this._then);

  final TenantPermissions _self;
  final $Res Function(TenantPermissions) _then;

/// Create a copy of TenantPermissions
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? hostPanel = null,Object? favourites = null,Object? reviews = null,Object? blockedDays = null,}) {
  return _then(TenantPermissions(
hostPanel: null == hostPanel ? _self.hostPanel : hostPanel // ignore: cast_nullable_to_non_nullable
as bool,favourites: null == favourites ? _self.favourites : favourites // ignore: cast_nullable_to_non_nullable
as bool,reviews: null == reviews ? _self.reviews : reviews // ignore: cast_nullable_to_non_nullable
as bool,blockedDays: null == blockedDays ? _self.blockedDays : blockedDays // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [TenantPermissions].
extension TenantPermissionsPatterns on TenantPermissions {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TenantPermissions value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TenantPermissions() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TenantPermissions value)  $default,){
final _that = this;
switch (_that) {
case _TenantPermissions():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TenantPermissions value)?  $default,){
final _that = this;
switch (_that) {
case _TenantPermissions() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool hostPanel,  bool favourites,  bool reviews,  bool blockedDays)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TenantPermissions() when $default != null:
return $default(_that.hostPanel,_that.favourites,_that.reviews,_that.blockedDays);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool hostPanel,  bool favourites,  bool reviews,  bool blockedDays)  $default,) {final _that = this;
switch (_that) {
case _TenantPermissions():
return $default(_that.hostPanel,_that.favourites,_that.reviews,_that.blockedDays);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool hostPanel,  bool favourites,  bool reviews,  bool blockedDays)?  $default,) {final _that = this;
switch (_that) {
case _TenantPermissions() when $default != null:
return $default(_that.hostPanel,_that.favourites,_that.reviews,_that.blockedDays);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TenantPermissions implements TenantPermissions {
  const _TenantPermissions({required this.hostPanel, required this.favourites, required this.reviews, required this.blockedDays});
  factory _TenantPermissions.fromJson(Map<String, dynamic> json) => _$TenantPermissionsFromJson(json);

@override final  bool hostPanel;
@override final  bool favourites;
@override final  bool reviews;
@override final  bool blockedDays;

/// Create a copy of TenantPermissions
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TenantPermissionsCopyWith<_TenantPermissions> get copyWith => __$TenantPermissionsCopyWithImpl<_TenantPermissions>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TenantPermissionsToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TenantPermissions&&(identical(other.hostPanel, hostPanel) || other.hostPanel == hostPanel)&&(identical(other.favourites, favourites) || other.favourites == favourites)&&(identical(other.reviews, reviews) || other.reviews == reviews)&&(identical(other.blockedDays, blockedDays) || other.blockedDays == blockedDays));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,hostPanel,favourites,reviews,blockedDays);
}

@override
String toString() {
    return 'TenantPermissions(hostPanel: $hostPanel, favourites: $favourites, reviews: $reviews, blockedDays: $blockedDays)';
}


}

/// @nodoc
abstract mixin class _$TenantPermissionsCopyWith<$Res> implements $TenantPermissionsCopyWith<$Res> {
  factory _$TenantPermissionsCopyWith(_TenantPermissions value, $Res Function(_TenantPermissions) _then) = __$TenantPermissionsCopyWithImpl;
@override @useResult
$Res call({
 bool hostPanel, bool favourites, bool reviews, bool blockedDays
});




}
/// @nodoc
class __$TenantPermissionsCopyWithImpl<$Res>
    implements _$TenantPermissionsCopyWith<$Res> {
  __$TenantPermissionsCopyWithImpl(this._self, this._then);

  final _TenantPermissions _self;
  final $Res Function(_TenantPermissions) _then;

/// Create a copy of TenantPermissions
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? hostPanel = null,Object? favourites = null,Object? reviews = null,Object? blockedDays = null,}) {
  return _then(_TenantPermissions(
hostPanel: null == hostPanel ? _self.hostPanel : hostPanel // ignore: cast_nullable_to_non_nullable
as bool,favourites: null == favourites ? _self.favourites : favourites // ignore: cast_nullable_to_non_nullable
as bool,reviews: null == reviews ? _self.reviews : reviews // ignore: cast_nullable_to_non_nullable
as bool,blockedDays: null == blockedDays ? _self.blockedDays : blockedDays // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$TenantTheme {

 ThemePalette get light; ThemePalette get dark;
/// Create a copy of TenantTheme
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TenantThemeCopyWith<TenantTheme> get copyWith => _$TenantThemeCopyWithImpl<TenantTheme>(this as TenantTheme, _$identity);

  /// Serializes this TenantTheme to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as TenantTheme;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TenantTheme&&(identical(other.light, _this.light) || other.light == _this.light)&&(identical(other.dark, _this.dark) || other.dark == _this.dark));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as TenantTheme;
  return Object.hash(runtimeType,_this.light,_this.dark);
}

@override
String toString() {
  final _this = this as TenantTheme;
  return 'TenantTheme(light: ${_this.light}, dark: ${_this.dark})';
}


}

/// @nodoc
abstract mixin class $TenantThemeCopyWith<$Res>  {
  factory $TenantThemeCopyWith(TenantTheme value, $Res Function(TenantTheme) _then) = _$TenantThemeCopyWithImpl;
@useResult
$Res call({
 ThemePalette light, ThemePalette dark
});


$ThemePaletteCopyWith<$Res> get light;$ThemePaletteCopyWith<$Res> get dark;

}
/// @nodoc
class _$TenantThemeCopyWithImpl<$Res>
    implements $TenantThemeCopyWith<$Res> {
  _$TenantThemeCopyWithImpl(this._self, this._then);

  final TenantTheme _self;
  final $Res Function(TenantTheme) _then;

/// Create a copy of TenantTheme
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? light = null,Object? dark = null,}) {
  return _then(TenantTheme(
light: null == light ? _self.light : light // ignore: cast_nullable_to_non_nullable
as ThemePalette,dark: null == dark ? _self.dark : dark // ignore: cast_nullable_to_non_nullable
as ThemePalette,
  ));
}
/// Create a copy of TenantTheme
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ThemePaletteCopyWith<$Res> get light {
  
  return $ThemePaletteCopyWith<$Res>(_self.light, (value) {
    return _then(_self.copyWith(light: value));
  });
}/// Create a copy of TenantTheme
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ThemePaletteCopyWith<$Res> get dark {
  
  return $ThemePaletteCopyWith<$Res>(_self.dark, (value) {
    return _then(_self.copyWith(dark: value));
  });
}
}


/// Adds pattern-matching-related methods to [TenantTheme].
extension TenantThemePatterns on TenantTheme {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TenantTheme value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TenantTheme() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TenantTheme value)  $default,){
final _that = this;
switch (_that) {
case _TenantTheme():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TenantTheme value)?  $default,){
final _that = this;
switch (_that) {
case _TenantTheme() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ThemePalette light,  ThemePalette dark)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TenantTheme() when $default != null:
return $default(_that.light,_that.dark);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ThemePalette light,  ThemePalette dark)  $default,) {final _that = this;
switch (_that) {
case _TenantTheme():
return $default(_that.light,_that.dark);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ThemePalette light,  ThemePalette dark)?  $default,) {final _that = this;
switch (_that) {
case _TenantTheme() when $default != null:
return $default(_that.light,_that.dark);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TenantTheme implements TenantTheme {
  const _TenantTheme({required this.light, required this.dark});
  factory _TenantTheme.fromJson(Map<String, dynamic> json) => _$TenantThemeFromJson(json);

@override final  ThemePalette light;
@override final  ThemePalette dark;

/// Create a copy of TenantTheme
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TenantThemeCopyWith<_TenantTheme> get copyWith => __$TenantThemeCopyWithImpl<_TenantTheme>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TenantThemeToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TenantTheme&&(identical(other.light, light) || other.light == light)&&(identical(other.dark, dark) || other.dark == dark));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,light,dark);
}

@override
String toString() {
    return 'TenantTheme(light: $light, dark: $dark)';
}


}

/// @nodoc
abstract mixin class _$TenantThemeCopyWith<$Res> implements $TenantThemeCopyWith<$Res> {
  factory _$TenantThemeCopyWith(_TenantTheme value, $Res Function(_TenantTheme) _then) = __$TenantThemeCopyWithImpl;
@override @useResult
$Res call({
 ThemePalette light, ThemePalette dark
});


@override $ThemePaletteCopyWith<$Res> get light;@override $ThemePaletteCopyWith<$Res> get dark;

}
/// @nodoc
class __$TenantThemeCopyWithImpl<$Res>
    implements _$TenantThemeCopyWith<$Res> {
  __$TenantThemeCopyWithImpl(this._self, this._then);

  final _TenantTheme _self;
  final $Res Function(_TenantTheme) _then;

/// Create a copy of TenantTheme
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? light = null,Object? dark = null,}) {
  return _then(_TenantTheme(
light: null == light ? _self.light : light // ignore: cast_nullable_to_non_nullable
as ThemePalette,dark: null == dark ? _self.dark : dark // ignore: cast_nullable_to_non_nullable
as ThemePalette,
  ));
}

/// Create a copy of TenantTheme
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ThemePaletteCopyWith<$Res> get light {
  
  return $ThemePaletteCopyWith<$Res>(_self.light, (value) {
    return _then(_self.copyWith(light: value));
  });
}/// Create a copy of TenantTheme
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ThemePaletteCopyWith<$Res> get dark {
  
  return $ThemePaletteCopyWith<$Res>(_self.dark, (value) {
    return _then(_self.copyWith(dark: value));
  });
}
}


/// @nodoc
mixin _$ThemePalette {

@JsonKey(name: 'surface-primary') String get surfacePrimary;@JsonKey(name: 'surface-secondary') String get surfaceSecondary;@JsonKey(name: 'surface-action') String get surfaceAction;@JsonKey(name: 'text-default') String get textDefault;@JsonKey(name: 'text-muted') String get textMuted;@JsonKey(name: 'text-on-action') String get textOnAction;@JsonKey(name: 'border-primary') String get borderPrimary;@JsonKey(name: 'icon-action') String get iconAction;
/// Create a copy of ThemePalette
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ThemePaletteCopyWith<ThemePalette> get copyWith => _$ThemePaletteCopyWithImpl<ThemePalette>(this as ThemePalette, _$identity);

  /// Serializes this ThemePalette to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ThemePalette;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ThemePalette&&(identical(other.surfacePrimary, _this.surfacePrimary) || other.surfacePrimary == _this.surfacePrimary)&&(identical(other.surfaceSecondary, _this.surfaceSecondary) || other.surfaceSecondary == _this.surfaceSecondary)&&(identical(other.surfaceAction, _this.surfaceAction) || other.surfaceAction == _this.surfaceAction)&&(identical(other.textDefault, _this.textDefault) || other.textDefault == _this.textDefault)&&(identical(other.textMuted, _this.textMuted) || other.textMuted == _this.textMuted)&&(identical(other.textOnAction, _this.textOnAction) || other.textOnAction == _this.textOnAction)&&(identical(other.borderPrimary, _this.borderPrimary) || other.borderPrimary == _this.borderPrimary)&&(identical(other.iconAction, _this.iconAction) || other.iconAction == _this.iconAction));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ThemePalette;
  return Object.hash(runtimeType,_this.surfacePrimary,_this.surfaceSecondary,_this.surfaceAction,_this.textDefault,_this.textMuted,_this.textOnAction,_this.borderPrimary,_this.iconAction);
}

@override
String toString() {
  final _this = this as ThemePalette;
  return 'ThemePalette(surfacePrimary: ${_this.surfacePrimary}, surfaceSecondary: ${_this.surfaceSecondary}, surfaceAction: ${_this.surfaceAction}, textDefault: ${_this.textDefault}, textMuted: ${_this.textMuted}, textOnAction: ${_this.textOnAction}, borderPrimary: ${_this.borderPrimary}, iconAction: ${_this.iconAction})';
}


}

/// @nodoc
abstract mixin class $ThemePaletteCopyWith<$Res>  {
  factory $ThemePaletteCopyWith(ThemePalette value, $Res Function(ThemePalette) _then) = _$ThemePaletteCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'surface-primary') String surfacePrimary,@JsonKey(name: 'surface-secondary') String surfaceSecondary,@JsonKey(name: 'surface-action') String surfaceAction,@JsonKey(name: 'text-default') String textDefault,@JsonKey(name: 'text-muted') String textMuted,@JsonKey(name: 'text-on-action') String textOnAction,@JsonKey(name: 'border-primary') String borderPrimary,@JsonKey(name: 'icon-action') String iconAction
});




}
/// @nodoc
class _$ThemePaletteCopyWithImpl<$Res>
    implements $ThemePaletteCopyWith<$Res> {
  _$ThemePaletteCopyWithImpl(this._self, this._then);

  final ThemePalette _self;
  final $Res Function(ThemePalette) _then;

/// Create a copy of ThemePalette
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? surfacePrimary = null,Object? surfaceSecondary = null,Object? surfaceAction = null,Object? textDefault = null,Object? textMuted = null,Object? textOnAction = null,Object? borderPrimary = null,Object? iconAction = null,}) {
  return _then(ThemePalette(
surfacePrimary: null == surfacePrimary ? _self.surfacePrimary : surfacePrimary // ignore: cast_nullable_to_non_nullable
as String,surfaceSecondary: null == surfaceSecondary ? _self.surfaceSecondary : surfaceSecondary // ignore: cast_nullable_to_non_nullable
as String,surfaceAction: null == surfaceAction ? _self.surfaceAction : surfaceAction // ignore: cast_nullable_to_non_nullable
as String,textDefault: null == textDefault ? _self.textDefault : textDefault // ignore: cast_nullable_to_non_nullable
as String,textMuted: null == textMuted ? _self.textMuted : textMuted // ignore: cast_nullable_to_non_nullable
as String,textOnAction: null == textOnAction ? _self.textOnAction : textOnAction // ignore: cast_nullable_to_non_nullable
as String,borderPrimary: null == borderPrimary ? _self.borderPrimary : borderPrimary // ignore: cast_nullable_to_non_nullable
as String,iconAction: null == iconAction ? _self.iconAction : iconAction // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ThemePalette].
extension ThemePalettePatterns on ThemePalette {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ThemePalette value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ThemePalette() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ThemePalette value)  $default,){
final _that = this;
switch (_that) {
case _ThemePalette():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ThemePalette value)?  $default,){
final _that = this;
switch (_that) {
case _ThemePalette() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'surface-primary')  String surfacePrimary, @JsonKey(name: 'surface-secondary')  String surfaceSecondary, @JsonKey(name: 'surface-action')  String surfaceAction, @JsonKey(name: 'text-default')  String textDefault, @JsonKey(name: 'text-muted')  String textMuted, @JsonKey(name: 'text-on-action')  String textOnAction, @JsonKey(name: 'border-primary')  String borderPrimary, @JsonKey(name: 'icon-action')  String iconAction)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ThemePalette() when $default != null:
return $default(_that.surfacePrimary,_that.surfaceSecondary,_that.surfaceAction,_that.textDefault,_that.textMuted,_that.textOnAction,_that.borderPrimary,_that.iconAction);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'surface-primary')  String surfacePrimary, @JsonKey(name: 'surface-secondary')  String surfaceSecondary, @JsonKey(name: 'surface-action')  String surfaceAction, @JsonKey(name: 'text-default')  String textDefault, @JsonKey(name: 'text-muted')  String textMuted, @JsonKey(name: 'text-on-action')  String textOnAction, @JsonKey(name: 'border-primary')  String borderPrimary, @JsonKey(name: 'icon-action')  String iconAction)  $default,) {final _that = this;
switch (_that) {
case _ThemePalette():
return $default(_that.surfacePrimary,_that.surfaceSecondary,_that.surfaceAction,_that.textDefault,_that.textMuted,_that.textOnAction,_that.borderPrimary,_that.iconAction);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'surface-primary')  String surfacePrimary, @JsonKey(name: 'surface-secondary')  String surfaceSecondary, @JsonKey(name: 'surface-action')  String surfaceAction, @JsonKey(name: 'text-default')  String textDefault, @JsonKey(name: 'text-muted')  String textMuted, @JsonKey(name: 'text-on-action')  String textOnAction, @JsonKey(name: 'border-primary')  String borderPrimary, @JsonKey(name: 'icon-action')  String iconAction)?  $default,) {final _that = this;
switch (_that) {
case _ThemePalette() when $default != null:
return $default(_that.surfacePrimary,_that.surfaceSecondary,_that.surfaceAction,_that.textDefault,_that.textMuted,_that.textOnAction,_that.borderPrimary,_that.iconAction);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ThemePalette implements ThemePalette {
  const _ThemePalette({@JsonKey(name: 'surface-primary') required this.surfacePrimary, @JsonKey(name: 'surface-secondary') required this.surfaceSecondary, @JsonKey(name: 'surface-action') required this.surfaceAction, @JsonKey(name: 'text-default') required this.textDefault, @JsonKey(name: 'text-muted') required this.textMuted, @JsonKey(name: 'text-on-action') required this.textOnAction, @JsonKey(name: 'border-primary') required this.borderPrimary, @JsonKey(name: 'icon-action') required this.iconAction});
  factory _ThemePalette.fromJson(Map<String, dynamic> json) => _$ThemePaletteFromJson(json);

@override@JsonKey(name: 'surface-primary') final  String surfacePrimary;
@override@JsonKey(name: 'surface-secondary') final  String surfaceSecondary;
@override@JsonKey(name: 'surface-action') final  String surfaceAction;
@override@JsonKey(name: 'text-default') final  String textDefault;
@override@JsonKey(name: 'text-muted') final  String textMuted;
@override@JsonKey(name: 'text-on-action') final  String textOnAction;
@override@JsonKey(name: 'border-primary') final  String borderPrimary;
@override@JsonKey(name: 'icon-action') final  String iconAction;

/// Create a copy of ThemePalette
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ThemePaletteCopyWith<_ThemePalette> get copyWith => __$ThemePaletteCopyWithImpl<_ThemePalette>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ThemePaletteToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ThemePalette&&(identical(other.surfacePrimary, surfacePrimary) || other.surfacePrimary == surfacePrimary)&&(identical(other.surfaceSecondary, surfaceSecondary) || other.surfaceSecondary == surfaceSecondary)&&(identical(other.surfaceAction, surfaceAction) || other.surfaceAction == surfaceAction)&&(identical(other.textDefault, textDefault) || other.textDefault == textDefault)&&(identical(other.textMuted, textMuted) || other.textMuted == textMuted)&&(identical(other.textOnAction, textOnAction) || other.textOnAction == textOnAction)&&(identical(other.borderPrimary, borderPrimary) || other.borderPrimary == borderPrimary)&&(identical(other.iconAction, iconAction) || other.iconAction == iconAction));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,surfacePrimary,surfaceSecondary,surfaceAction,textDefault,textMuted,textOnAction,borderPrimary,iconAction);
}

@override
String toString() {
    return 'ThemePalette(surfacePrimary: $surfacePrimary, surfaceSecondary: $surfaceSecondary, surfaceAction: $surfaceAction, textDefault: $textDefault, textMuted: $textMuted, textOnAction: $textOnAction, borderPrimary: $borderPrimary, iconAction: $iconAction)';
}


}

/// @nodoc
abstract mixin class _$ThemePaletteCopyWith<$Res> implements $ThemePaletteCopyWith<$Res> {
  factory _$ThemePaletteCopyWith(_ThemePalette value, $Res Function(_ThemePalette) _then) = __$ThemePaletteCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'surface-primary') String surfacePrimary,@JsonKey(name: 'surface-secondary') String surfaceSecondary,@JsonKey(name: 'surface-action') String surfaceAction,@JsonKey(name: 'text-default') String textDefault,@JsonKey(name: 'text-muted') String textMuted,@JsonKey(name: 'text-on-action') String textOnAction,@JsonKey(name: 'border-primary') String borderPrimary,@JsonKey(name: 'icon-action') String iconAction
});




}
/// @nodoc
class __$ThemePaletteCopyWithImpl<$Res>
    implements _$ThemePaletteCopyWith<$Res> {
  __$ThemePaletteCopyWithImpl(this._self, this._then);

  final _ThemePalette _self;
  final $Res Function(_ThemePalette) _then;

/// Create a copy of ThemePalette
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? surfacePrimary = null,Object? surfaceSecondary = null,Object? surfaceAction = null,Object? textDefault = null,Object? textMuted = null,Object? textOnAction = null,Object? borderPrimary = null,Object? iconAction = null,}) {
  return _then(_ThemePalette(
surfacePrimary: null == surfacePrimary ? _self.surfacePrimary : surfacePrimary // ignore: cast_nullable_to_non_nullable
as String,surfaceSecondary: null == surfaceSecondary ? _self.surfaceSecondary : surfaceSecondary // ignore: cast_nullable_to_non_nullable
as String,surfaceAction: null == surfaceAction ? _self.surfaceAction : surfaceAction // ignore: cast_nullable_to_non_nullable
as String,textDefault: null == textDefault ? _self.textDefault : textDefault // ignore: cast_nullable_to_non_nullable
as String,textMuted: null == textMuted ? _self.textMuted : textMuted // ignore: cast_nullable_to_non_nullable
as String,textOnAction: null == textOnAction ? _self.textOnAction : textOnAction // ignore: cast_nullable_to_non_nullable
as String,borderPrimary: null == borderPrimary ? _self.borderPrimary : borderPrimary // ignore: cast_nullable_to_non_nullable
as String,iconAction: null == iconAction ? _self.iconAction : iconAction // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
