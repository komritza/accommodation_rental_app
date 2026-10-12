import 'package:accommodation_ui/accommodation_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../common/guest_calendar.dart';
import '../listing_detail_providers.dart';

class ListingAvailabilitySection extends ConsumerWidget {
  const ListingAvailabilitySection({super.key, required this.listingId});

  final String listingId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final colors = context.accommodationColors;
    final textTheme = Theme.of(context).textTheme;
    final provider = listingAvailabilityProvider(listingId);
    final availability = ref.watch(provider);
    final window = listingAvailabilityWindow(
      ref.watch(guestCalendarTodayProvider),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(l10n.listingAvailabilityTitle, style: textTheme.titleLarge),
        const SizedBox(height: AppSpacing.xxs),
        Text(
          l10n.listingAvailabilitySubtitle,
          style: textTheme.bodyMedium?.copyWith(color: colors.textMuted),
        ),
        const SizedBox(height: AppSpacing.md),
        if (availability.hasError && !availability.isLoading)
          _AvailabilityError(onRetry: () => ref.invalidate(provider))
        else ...[
          AnimatedOpacity(
            opacity: availability.hasValue
                ? 1
                : AppButtonTokens.disabledOpacity,
            duration: Durations.short4,
            child: AppDateRangeCalendar(
              firstDate: window.from,
              lastDate: window.to.subtract(const Duration(days: 1)),
              unavailableDayPredicate: availability.value?.isTaken,
              unavailableDayLabel: l10n.availabilityLegendTaken,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          const _AvailabilityLegend(),
        ],
      ],
    );
  }
}

class _AvailabilityError extends StatelessWidget {
  const _AvailabilityError({required this.onRetry});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colors = context.accommodationColors;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        borderRadius: AppRadii.mdBorder,
        border: Border.all(
          color: colors.borderPrimary,
          width: AppBorderWidths.regular,
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.cloud_off_outlined,
            size: AppIconSizes.md,
            color: colors.textMuted,
          ),
          const SizedBox(width: AppSpacing.xs),
          Expanded(
            child: Text(
              l10n.listingAvailabilityError,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          TextButton(onPressed: onRetry, child: Text(l10n.retry)),
        ],
      ),
    );
  }
}

class _AvailabilityLegend extends StatelessWidget {
  const _AvailabilityLegend();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colors = context.accommodationColors;

    return Wrap(
      spacing: AppSpacing.md,
      runSpacing: AppSpacing.xs,
      children: [
        _LegendItem(
          label: l10n.availabilityLegendAvailable,
          swatch: _LegendDot(color: colors.textDefault),
        ),
        _LegendItem(
          label: l10n.availabilityLegendTaken,
          swatch: _LegendDot(
            color: colors.textMuted.withValues(
              alpha: AppButtonTokens.disabledOpacity,
            ),
            struckThrough: true,
          ),
        ),
        _LegendItem(
          label: l10n.availabilityLegendToday,
          swatch: DecoratedBox(
            decoration: ShapeDecoration(
              shape: CircleBorder(
                side: BorderSide(
                  color: colors.borderPrimary,
                  width: AppBorderWidths.regular,
                ),
              ),
            ),
            child: const SizedBox.square(dimension: AppIconSizes.md),
          ),
        ),
      ],
    );
  }
}

class _LegendDot extends StatelessWidget {
  const _LegendDot({required this.color, this.struckThrough = false});

  final Color color;
  final bool struckThrough;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        DecoratedBox(
          decoration: ShapeDecoration(
            shape: const CircleBorder(),
            color: color,
          ),
          child: const SizedBox.square(dimension: AppSpacing.xs),
        ),
        if (struckThrough)
          SizedBox(
            width: AppIconSizes.sm,
            height: AppBorderWidths.focused,
            child: ColoredBox(color: color),
          ),
      ],
    );
  }
}

class _LegendItem extends StatelessWidget {
  const _LegendItem({required this.label, required this.swatch});

  final String label;
  final Widget swatch;

  @override
  Widget build(BuildContext context) {
    final colors = context.accommodationColors;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ExcludeSemantics(
          child: SizedBox.square(
            dimension: AppIconSizes.md,
            child: Center(child: swatch),
          ),
        ),
        const SizedBox(width: AppSpacing.xs),
        Text(
          label,
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(color: colors.textMuted),
        ),
      ],
    );
  }
}
