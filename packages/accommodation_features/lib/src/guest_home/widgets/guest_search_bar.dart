import 'package:accommodation_ui/accommodation_ui.dart';
import 'package:flutter/material.dart';

class GuestSearchBar extends StatelessWidget {
  const GuestSearchBar({
    super.key,
    required this.title,
    required this.summary,
    required this.filtersTooltip,
    required this.onSearchPressed,
    required this.onFiltersPressed,
  });

  final String title;
  final String summary;
  final String filtersTooltip;
  final VoidCallback onSearchPressed;
  final VoidCallback onFiltersPressed;

  @override
  Widget build(BuildContext context) {
    final colors = context.accommodationColors;
    final textTheme = Theme.of(context).textTheme;

    return Material(
      color: colors.surfaceSecondary,
      shape: const StadiumBorder(),
      clipBehavior: Clip.antiAlias,
      child: Row(
        children: [
          Expanded(
            child: Semantics(
              button: true,
              child: InkWell(
                onTap: onSearchPressed,
                customBorder: const StadiumBorder(),
                child: Padding(
                  padding: const EdgeInsetsDirectional.only(
                    start: AppSpacing.md,
                    end: AppSpacing.xs,
                    top: AppSpacing.xs,
                    bottom: AppSpacing.xs,
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.search, size: AppIconSizes.md),
                      const SizedBox(width: AppSpacing.md),
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: textTheme.titleMedium,
                            ),
                            Text(
                              summary,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: textTheme.bodyMedium?.copyWith(
                                color: colors.textMuted,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.only(
              end: AppSpacing.xs,
              top: AppSpacing.xs,
              bottom: AppSpacing.xs,
            ),
            child: AppIconButton(
              icon: Icons.tune,
              tooltip: filtersTooltip,
              onPressed: onFiltersPressed,
            ),
          ),
        ],
      ),
    );
  }
}
