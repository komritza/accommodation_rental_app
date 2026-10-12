import 'package:accommodation_core/accommodation_core.dart';
import 'package:flutter/material.dart';

import '../design_system/design_system.dart';

ThemeData buildTenantTheme(
  ThemePalette palette, {
  required Brightness brightness,
}) {
  final colors = AccommodationColors.resolve(palette, brightness);

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
        error: colors.stateError,
      );

  return ThemeData(
    useMaterial3: true,
    brightness: brightness,
    colorScheme: colorScheme,
    scaffoldBackgroundColor: colors.surfacePrimary,
    textTheme: _textTheme,
    inputDecorationTheme: _inputDecorationTheme(colors),
    filledButtonTheme: _filledButtonTheme(colors),
    outlinedButtonTheme: _outlinedButtonTheme(colors),
    dividerTheme: DividerThemeData(
      color: colors.borderPrimary,
      thickness: AppBorderWidths.regular,
      space: AppBorderWidths.regular,
    ),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: colors.surfacePrimary,
      modalBackgroundColor: colors.surfacePrimary,
      surfaceTintColor: Colors.transparent,
      showDragHandle: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppRadii.md)),
      ),
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: colors.surfacePrimary,
      indicatorColor: colors.surfaceSecondary,
      surfaceTintColor: Colors.transparent,
    ),
    extensions: [colors],
  );
}

const _textTheme = TextTheme(
  headlineMedium: TextStyle(
    fontSize: AppTypography.sizeXl,
    fontWeight: AppTypography.weightExtraBold,
    height: AppTypography.lineHeightTight,
  ),
  titleLarge: TextStyle(
    fontSize: AppTypography.sizeLg,
    fontWeight: AppTypography.weightExtraBold,
  ),
  titleMedium: TextStyle(
    fontSize: AppTypography.sizeMd,
    fontWeight: AppTypography.weightSemibold,
  ),
  titleSmall: TextStyle(
    fontSize: AppTypography.sizeSm,
    fontWeight: AppTypography.weightMedium,
  ),
  bodyLarge: TextStyle(
    fontSize: AppTypography.sizeMd,
    height: AppTypography.lineHeightNormal,
  ),
  bodyMedium: TextStyle(fontSize: AppTypography.sizeSm),
  labelLarge: TextStyle(
    fontSize: AppTypography.sizeMd,
    fontWeight: AppTypography.weightSemibold,
  ),
);

InputDecorationTheme _inputDecorationTheme(AccommodationColors colors) {
  OutlineInputBorder outline(Color color, double width) {
    return OutlineInputBorder(
      borderRadius: AppRadii.smBorder,
      borderSide: BorderSide(color: color, width: width),
    );
  }

  final regularBorder = outline(colors.borderPrimary, AppBorderWidths.regular);

  return InputDecorationTheme(
    isDense: true,
    filled: true,
    fillColor: colors.surfacePrimary,
    contentPadding: AppInputTokens.contentPadding,
    border: regularBorder,
    enabledBorder: regularBorder,
    focusedBorder: outline(colors.surfaceAction, AppBorderWidths.focused),
    errorBorder: outline(colors.stateError, AppBorderWidths.regular),
    focusedErrorBorder: outline(colors.stateError, AppBorderWidths.focused),
  );
}

FilledButtonThemeData _filledButtonTheme(AccommodationColors colors) {
  return FilledButtonThemeData(
    style: FilledButton.styleFrom(
      minimumSize: const Size(0, AppButtonTokens.height),
      backgroundColor: colors.surfaceAction,
      foregroundColor: colors.textOnAction,
      disabledBackgroundColor: colors.surfaceAction.withValues(
        alpha: AppButtonTokens.disabledOpacity,
      ),
      disabledForegroundColor: colors.textOnAction,
      shape: const RoundedRectangleBorder(borderRadius: AppRadii.smBorder),
    ),
  );
}

OutlinedButtonThemeData _outlinedButtonTheme(AccommodationColors colors) {
  return OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      minimumSize: const Size(0, AppButtonTokens.height),
      foregroundColor: colors.textDefault,
      side: BorderSide(
        color: colors.borderPrimary,
        width: AppBorderWidths.regular,
      ),
      shape: const RoundedRectangleBorder(borderRadius: AppRadii.smBorder),
    ),
  );
}
