import 'package:accommodation_core/testing.dart';
import 'package:accommodation_ui/accommodation_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final config = createTestConfig();

  group('buildTenantTheme', () {
    test('attaches semantic colors resolved from the tenant palette', () {
      final theme = buildTenantTheme(
        config.theme.light,
        brightness: Brightness.light,
      );
      final colors = theme.extension<AccommodationColors>()!;

      expect(colors.surfacePrimary, const Color(0xFFFFFFFF));
      expect(colors.surfaceAction, const Color(0xFF3366FF));
      expect(colors.textMuted, const Color(0xFF666666));
      expect(colors.stateError, const Color(0xFFBA1A1A));
    });

    test('uses the dark palette and dark state colors', () {
      final theme = buildTenantTheme(
        config.theme.dark,
        brightness: Brightness.dark,
      );
      final colors = theme.extension<AccommodationColors>()!;

      expect(theme.brightness, Brightness.dark);
      expect(theme.scaffoldBackgroundColor, const Color(0xFF111111));
      expect(colors.stateError, const Color(0xFFFFB4AB));
    });

    test('maps semantic colors onto Material color roles', () {
      final theme = buildTenantTheme(
        config.theme.light,
        brightness: Brightness.light,
      );
      final colors = theme.extension<AccommodationColors>()!;
      final scheme = theme.colorScheme;

      expect(scheme.primary, colors.surfaceAction);
      expect(scheme.onPrimary, colors.textOnAction);
      expect(scheme.surface, colors.surfacePrimary);
      expect(scheme.onSurface, colors.textDefault);
      expect(scheme.onSurfaceVariant, colors.textMuted);
      expect(scheme.outline, colors.borderPrimary);
      expect(scheme.error, colors.stateError);
    });

    test('styles inputs and filled buttons from tokens', () {
      final theme = buildTenantTheme(
        config.theme.light,
        brightness: Brightness.light,
      );
      final colors = theme.extension<AccommodationColors>()!;
      final input = theme.inputDecorationTheme;

      expect(input.contentPadding, AppInputTokens.contentPadding);
      final focused = input.focusedBorder! as OutlineInputBorder;
      expect(focused.borderRadius, AppRadii.smBorder);
      expect(focused.borderSide.color, colors.surfaceAction);
      expect(focused.borderSide.width, AppBorderWidths.focused);
      expect(
        (input.errorBorder! as OutlineInputBorder).borderSide.color,
        colors.stateError,
      );

      final button = theme.filledButtonTheme.style!;
      expect(button.minimumSize!.resolve({})!.height, AppButtonTokens.height);
      expect(
        button.backgroundColor!.resolve({WidgetState.disabled}),
        colors.surfaceAction.withValues(alpha: AppButtonTokens.disabledOpacity),
      );
    });

    test('applies the shared type scale', () {
      final textTheme = buildTenantTheme(
        config.theme.light,
        brightness: Brightness.light,
      ).textTheme;

      expect(textTheme.headlineMedium!.fontSize, AppTypography.sizeXl);
      expect(textTheme.titleLarge!.fontSize, AppTypography.sizeLg);
      expect(textTheme.labelLarge!.fontWeight, AppTypography.weightSemibold);
      expect(textTheme.bodyLarge!.color, const Color(0xFF111111));
    });
  });
}
