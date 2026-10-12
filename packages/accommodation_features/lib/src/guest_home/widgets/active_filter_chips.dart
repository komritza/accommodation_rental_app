import 'package:accommodation_ui/accommodation_ui.dart';
import 'package:flutter/material.dart';

import 'underlined_button_style.dart';

typedef ActiveFilter = ({String label, VoidCallback onRemove});

class ActiveFilterChips extends StatelessWidget {
  const ActiveFilterChips({
    super.key,
    required this.filters,
    required this.onClearAll,
    required this.padding,
  });

  final List<ActiveFilter> filters;
  final VoidCallback onClearAll;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colors = context.accommodationColors;

    return SizedBox(
      height: AppChipTokens.height,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: padding,
        children: [
          for (final filter in filters) ...[
            AppChip(
              label: filter.label,
              semanticLabel: l10n.guestHomeRemoveFilter(filter.label),
              trailingIcon: Icons.close,
              onPressed: filter.onRemove,
            ),
            const SizedBox(width: AppSpacing.xs),
          ],
          TextButton(
            onPressed: onClearAll,
            style: underlinedButtonStyle(
              context,
              color: colors.surfaceAction,
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xs),
            ),
            child: Text(l10n.guestHomeClearAll),
          ),
        ],
      ),
    );
  }
}
