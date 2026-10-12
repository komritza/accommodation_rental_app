import 'package:flutter/material.dart';

import '../design_system/design_system.dart';

class AppBadge extends StatelessWidget {
  const AppBadge({
    super.key,
    required this.label,
    this.backgroundColor,
    this.foregroundColor,
    this.padding,
  });

  final String label;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    final colors = context.accommodationColors;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding:
          padding ??
          const EdgeInsets.symmetric(
            horizontal: AppSpacing.xs,
            vertical: AppSpacing.xxs,
          ),
      decoration: BoxDecoration(
        color: backgroundColor ?? colors.surfacePrimary,
        borderRadius: AppRadii.mdBorder,
      ),
      child: Text(
        label,
        style: textTheme.bodyMedium?.copyWith(
          color: foregroundColor ?? colors.textDefault,
          fontWeight: AppTypography.weightSemibold,
        ),
      ),
    );
  }
}
