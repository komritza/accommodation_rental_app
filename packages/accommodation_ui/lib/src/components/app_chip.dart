import 'package:flutter/material.dart';

import '../design_system/design_system.dart';

class AppChip extends StatelessWidget {
  const AppChip({
    super.key,
    required this.label,
    required this.onPressed,
    this.selected,
    this.trailingIcon,
    this.semanticLabel,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool? selected;
  final IconData? trailingIcon;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final colors = context.accommodationColors;
    final isSelected = selected ?? false;

    return MergeSemantics(
      child: Semantics(
        selected: selected,
        child: OutlinedButton(
          onPressed: onPressed,
          style: OutlinedButton.styleFrom(
            minimumSize: const Size(0, AppChipTokens.height),
            padding: AppChipTokens.padding,
            backgroundColor: isSelected ? colors.surfaceAction : null,
            foregroundColor: isSelected
                ? colors.textOnAction
                : colors.textDefault,
            side: BorderSide(
              color: isSelected ? colors.surfaceAction : colors.borderPrimary,
              width: AppBorderWidths.regular,
            ),
            textStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: AppTypography.weightSemibold,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(label, semanticsLabel: semanticLabel),
              if (trailingIcon != null) ...[
                const SizedBox(width: AppSpacing.xs),
                Icon(trailingIcon, size: AppIconSizes.sm),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
