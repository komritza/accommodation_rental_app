import 'package:freezed_annotation/freezed_annotation.dart';

part 'tenant_runtime_config.freezed.dart';
part 'tenant_runtime_config.g.dart';

enum TenantSlug { alpine, riviera }

enum TenantLocale { en, de }

@freezed
abstract class TenantRuntimeConfig with _$TenantRuntimeConfig {
  const factory TenantRuntimeConfig({
    required TenantSlug slug,
    required String name,
    required String currency,
    required List<TenantLocale> locales,
    required TenantLocale defaultLocale,
    required String supportEmail,
    required String termsOfUseUrl,
    required String privacyPolicyUrl,
    required TenantPermissions permissions,
    required TenantTheme theme,
  }) = _TenantRuntimeConfig;

  factory TenantRuntimeConfig.fromJson(Map<String, dynamic> json) =>
      _$TenantRuntimeConfigFromJson(json);
}

@freezed
abstract class TenantPermissions with _$TenantPermissions {
  const factory TenantPermissions({
    required bool hostPanel,
    required bool favourites,
    required bool reviews,
    required bool blockedDays,
  }) = _TenantPermissions;

  factory TenantPermissions.fromJson(Map<String, dynamic> json) =>
      _$TenantPermissionsFromJson(json);
}

@freezed
abstract class TenantTheme with _$TenantTheme {
  const factory TenantTheme({
    required ThemePalette light,
    required ThemePalette dark,
  }) = _TenantTheme;

  factory TenantTheme.fromJson(Map<String, dynamic> json) =>
      _$TenantThemeFromJson(json);
}

@freezed
abstract class ThemePalette with _$ThemePalette {
  const factory ThemePalette({
    @JsonKey(name: 'surface-primary') required String surfacePrimary,
    @JsonKey(name: 'surface-secondary') required String surfaceSecondary,
    @JsonKey(name: 'surface-action') required String surfaceAction,
    @JsonKey(name: 'text-default') required String textDefault,
    @JsonKey(name: 'text-muted') required String textMuted,
    @JsonKey(name: 'text-on-action') required String textOnAction,
    @JsonKey(name: 'border-primary') required String borderPrimary,
    @JsonKey(name: 'icon-action') required String iconAction,
  }) = _ThemePalette;

  factory ThemePalette.fromJson(Map<String, dynamic> json) =>
      _$ThemePaletteFromJson(json);
}
