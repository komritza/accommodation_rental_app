import 'package:accommodation_core/accommodation_core.dart';
import 'package:flutter/material.dart';

Color _parseHexColor(String value) {
  final hex = value.replaceFirst('#', '');
  final normalized = hex.length == 6 ? 'FF$hex' : hex;

  return Color(int.parse(normalized, radix: 16));
}

@immutable
class AccommodationColors extends ThemeExtension<AccommodationColors> {
  const AccommodationColors({
    required this.surfacePrimary,
    required this.surfaceSecondary,
    required this.surfaceAction,
    required this.textDefault,
    required this.textMuted,
    required this.textOnAction,
    required this.borderPrimary,
    required this.iconAction,
  });

  final Color surfacePrimary;
  final Color surfaceSecondary;
  final Color surfaceAction;
  final Color textDefault;
  final Color textMuted;
  final Color textOnAction;
  final Color borderPrimary;
  final Color iconAction;

  factory AccommodationColors.fromPalette(ThemePalette palette) {
    return AccommodationColors(
      surfacePrimary: _parseHexColor(palette.surfacePrimary),
      surfaceSecondary: _parseHexColor(palette.surfaceSecondary),
      surfaceAction: _parseHexColor(palette.surfaceAction),
      textDefault: _parseHexColor(palette.textDefault),
      textMuted: _parseHexColor(palette.textMuted),
      textOnAction: _parseHexColor(palette.textOnAction),
      borderPrimary: _parseHexColor(palette.borderPrimary),
      iconAction: _parseHexColor(palette.iconAction),
    );
  }

  @override
  AccommodationColors copyWith({
    Color? surfacePrimary,
    Color? surfaceSecondary,
    Color? surfaceAction,
    Color? textDefault,
    Color? textMuted,
    Color? textOnAction,
    Color? borderPrimary,
    Color? iconAction,
  }) {
    return AccommodationColors(
      surfacePrimary: surfacePrimary ?? this.surfacePrimary,
      surfaceSecondary: surfaceSecondary ?? this.surfaceSecondary,
      surfaceAction: surfaceAction ?? this.surfaceAction,
      textDefault: textDefault ?? this.textDefault,
      textMuted: textMuted ?? this.textMuted,
      textOnAction: textOnAction ?? this.textOnAction,
      borderPrimary: borderPrimary ?? this.borderPrimary,
      iconAction: iconAction ?? this.iconAction,
    );
  }

  @override
  AccommodationColors lerp(covariant AccommodationColors? other, double t) {
    if (other == null) return this;

    return AccommodationColors(
      surfacePrimary: Color.lerp(surfacePrimary, other.surfacePrimary, t)!,
      surfaceSecondary: Color.lerp(
        surfaceSecondary,
        other.surfaceSecondary,
        t,
      )!,
      surfaceAction: Color.lerp(surfaceAction, other.surfaceAction, t)!,
      textDefault: Color.lerp(textDefault, other.textDefault, t)!,
      textMuted: Color.lerp(textMuted, other.textMuted, t)!,
      textOnAction: Color.lerp(textOnAction, other.textOnAction, t)!,
      borderPrimary: Color.lerp(borderPrimary, other.borderPrimary, t)!,
      iconAction: Color.lerp(iconAction, other.iconAction, t)!,
    );
  }
}

ThemeData buildTenantTheme(
  ThemePalette palette, {
  required Brightness brightness,
}) {
  final colors = AccommodationColors.fromPalette(palette);

  final colorScheme =
      ColorScheme.fromSeed(
        seedColor: colors.surfaceAction,
        brightness: brightness,
      ).copyWith(
        primary: colors.surfaceAction,
        onPrimary: colors.textOnAction,
        surface: colors.surfacePrimary,
        onSurface: colors.textDefault,
        secondaryContainer: colors.surfaceSecondary,
        outline: colors.borderPrimary,
        onSurfaceVariant: colors.textMuted,
      );

  return ThemeData(
    useMaterial3: true,
    brightness: brightness,
    colorScheme: colorScheme,
    scaffoldBackgroundColor: colors.surfacePrimary,
    extensions: [colors],
  );
}
