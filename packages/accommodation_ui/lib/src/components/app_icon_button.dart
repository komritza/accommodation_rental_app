import 'package:flutter/material.dart';

import '../design_system/design_system.dart';

enum AppIconButtonVariant { tonal, outlined }

class AppIconButton extends StatelessWidget {
  const AppIconButton({
    super.key,
    required this.icon,
    required this.tooltip,
    required this.onPressed,
    this.variant = AppIconButtonVariant.outlined,
    this.iconSize = AppIconSizes.md,
  });

  final IconData icon;
  final String tooltip;
  final VoidCallback? onPressed;
  final AppIconButtonVariant variant;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    final colors = context.accommodationColors;
    final background = switch (variant) {
      AppIconButtonVariant.tonal => colors.surfaceSecondary,
      AppIconButtonVariant.outlined => colors.surfacePrimary,
    };

    return IconButton(
      onPressed: onPressed,
      tooltip: tooltip,
      icon: Icon(icon),
      style: IconButton.styleFrom(
        fixedSize: const Size.square(AppIconButtonTokens.size),
        minimumSize: const Size.square(AppIconButtonTokens.size),
        iconSize: iconSize,
        shape: const CircleBorder(),
        foregroundColor: colors.textDefault,
        disabledForegroundColor: colors.textDefault.withValues(
          alpha: AppButtonTokens.disabledOpacity,
        ),
        backgroundColor: background,
        disabledBackgroundColor: background,
        side: variant == AppIconButtonVariant.outlined
            ? BorderSide(
                color: colors.borderPrimary,
                width: AppBorderWidths.regular,
              )
            : null,
      ),
    );
  }
}
