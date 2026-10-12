import 'package:accommodation_core/accommodation_core.dart';
import 'package:flutter/material.dart';

Color _parseHexColor(String value) {
  final hex = value.replaceFirst('#', '');
  final normalized = hex.length == 6 ? 'FF$hex' : hex;

  return Color(int.parse(normalized, radix: 16));
}

const _stateErrorLight = Color(0xFFBA1A1A);
const _stateErrorDark = Color(0xFFFFB4AB);
const _stateFavouriteLight = Color(0xFFE0182D);
const _stateFavouriteDark = Color(0xFFFF6B78);

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
    required this.stateError,
    required this.stateFavourite,
  });

  factory AccommodationColors.resolve(
    ThemePalette palette,
    Brightness brightness,
  ) {
    final isLight = brightness == Brightness.light;

    return AccommodationColors(
      surfacePrimary: _parseHexColor(palette.surfacePrimary),
      surfaceSecondary: _parseHexColor(palette.surfaceSecondary),
      surfaceAction: _parseHexColor(palette.surfaceAction),
      textDefault: _parseHexColor(palette.textDefault),
      textMuted: _parseHexColor(palette.textMuted),
      textOnAction: _parseHexColor(palette.textOnAction),
      borderPrimary: _parseHexColor(palette.borderPrimary),
      iconAction: _parseHexColor(palette.iconAction),
      stateError: isLight ? _stateErrorLight : _stateErrorDark,
      stateFavourite: isLight ? _stateFavouriteLight : _stateFavouriteDark,
    );
  }

  final Color surfacePrimary;
  final Color surfaceSecondary;
  final Color surfaceAction;

  final Color textDefault;
  final Color textMuted;
  final Color textOnAction;

  final Color borderPrimary;
  final Color iconAction;

  final Color stateError;
  final Color stateFavourite;

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
    Color? stateError,
    Color? stateFavourite,
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
      stateError: stateError ?? this.stateError,
      stateFavourite: stateFavourite ?? this.stateFavourite,
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
      stateError: Color.lerp(stateError, other.stateError, t)!,
      stateFavourite: Color.lerp(stateFavourite, other.stateFavourite, t)!,
    );
  }
}

extension AccommodationColorsContext on BuildContext {
  AccommodationColors get accommodationColors {
    final colors = Theme.of(this).extension<AccommodationColors>();
    if (colors == null) {
      throw StateError(
        'AccommodationColors is not attached to the current theme.',
      );
    }
    return colors;
  }
}
