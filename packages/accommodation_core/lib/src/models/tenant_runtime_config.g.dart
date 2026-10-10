// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tenant_runtime_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TenantRuntimeConfig _$TenantRuntimeConfigFromJson(Map<String, dynamic> json) =>
    _TenantRuntimeConfig(
      slug: $enumDecode(_$TenantSlugEnumMap, json['slug']),
      name: json['name'] as String,
      currency: json['currency'] as String,
      locales: (json['locales'] as List<dynamic>)
          .map((e) => $enumDecode(_$TenantLocaleEnumMap, e))
          .toList(),
      defaultLocale: $enumDecode(_$TenantLocaleEnumMap, json['defaultLocale']),
      supportEmail: json['supportEmail'] as String,
      termsOfUseUrl: json['termsOfUseUrl'] as String,
      privacyPolicyUrl: json['privacyPolicyUrl'] as String,
      permissions: TenantPermissions.fromJson(
        json['permissions'] as Map<String, dynamic>,
      ),
      theme: TenantTheme.fromJson(json['theme'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TenantRuntimeConfigToJson(
  _TenantRuntimeConfig instance,
) => <String, dynamic>{
  'slug': _$TenantSlugEnumMap[instance.slug]!,
  'name': instance.name,
  'currency': instance.currency,
  'locales': instance.locales.map((e) => _$TenantLocaleEnumMap[e]!).toList(),
  'defaultLocale': _$TenantLocaleEnumMap[instance.defaultLocale]!,
  'supportEmail': instance.supportEmail,
  'termsOfUseUrl': instance.termsOfUseUrl,
  'privacyPolicyUrl': instance.privacyPolicyUrl,
  'permissions': instance.permissions.toJson(),
  'theme': instance.theme.toJson(),
};

const _$TenantSlugEnumMap = {
  TenantSlug.alpine: 'alpine',
  TenantSlug.riviera: 'riviera',
};

const _$TenantLocaleEnumMap = {TenantLocale.en: 'en', TenantLocale.de: 'de'};

_TenantPermissions _$TenantPermissionsFromJson(Map<String, dynamic> json) =>
    _TenantPermissions(
      hostPanel: json['hostPanel'] as bool,
      favourites: json['favourites'] as bool,
      reviews: json['reviews'] as bool,
      blockedDays: json['blockedDays'] as bool,
    );

Map<String, dynamic> _$TenantPermissionsToJson(_TenantPermissions instance) =>
    <String, dynamic>{
      'hostPanel': instance.hostPanel,
      'favourites': instance.favourites,
      'reviews': instance.reviews,
      'blockedDays': instance.blockedDays,
    };

_TenantTheme _$TenantThemeFromJson(Map<String, dynamic> json) => _TenantTheme(
  light: ThemePalette.fromJson(json['light'] as Map<String, dynamic>),
  dark: ThemePalette.fromJson(json['dark'] as Map<String, dynamic>),
);

Map<String, dynamic> _$TenantThemeToJson(_TenantTheme instance) =>
    <String, dynamic>{
      'light': instance.light.toJson(),
      'dark': instance.dark.toJson(),
    };

_ThemePalette _$ThemePaletteFromJson(Map<String, dynamic> json) =>
    _ThemePalette(
      surfacePrimary: json['surface-primary'] as String,
      surfaceSecondary: json['surface-secondary'] as String,
      surfaceAction: json['surface-action'] as String,
      textDefault: json['text-default'] as String,
      textMuted: json['text-muted'] as String,
      textOnAction: json['text-on-action'] as String,
      borderPrimary: json['border-primary'] as String,
      iconAction: json['icon-action'] as String,
    );

Map<String, dynamic> _$ThemePaletteToJson(_ThemePalette instance) =>
    <String, dynamic>{
      'surface-primary': instance.surfacePrimary,
      'surface-secondary': instance.surfaceSecondary,
      'surface-action': instance.surfaceAction,
      'text-default': instance.textDefault,
      'text-muted': instance.textMuted,
      'text-on-action': instance.textOnAction,
      'border-primary': instance.borderPrimary,
      'icon-action': instance.iconAction,
    };
