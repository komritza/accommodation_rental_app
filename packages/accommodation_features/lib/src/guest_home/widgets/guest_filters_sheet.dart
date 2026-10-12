import 'package:accommodation_core/accommodation_core.dart';
import 'package:accommodation_ui/accommodation_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../common/guest_calendar.dart';
import '../../listings/listings_error_mapper.dart';
import '../../listings/listings_providers.dart';
import '../guest_filter_draft.dart';
import '../guest_filter_labels.dart';
import '../guest_listing_filters.dart';
import 'underlined_button_style.dart';

Future<void> showGuestFiltersSheet(BuildContext context) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    useRootNavigator: true,
    useSafeArea: true,
    builder: (context) => const GuestFiltersSheet(),
  );
}

class GuestFiltersSheet extends ConsumerWidget {
  const GuestFiltersSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final facets = ref.watch(listingFacetsProvider);

    return FractionallySizedBox(
      heightFactor: AppSheetTokens.heightFactor,
      child: Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: AppLayoutTokens.contentMaxWidth,
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                child: Row(
                  children: [
                    Expanded(
                      child: Semantics(
                        header: true,
                        child: Text(
                          l10n.guestFiltersTitle,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      tooltip: l10n.guestFiltersClose,
                      icon: const Icon(Icons.close, size: AppIconSizes.md),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: facets.when(
                  data: (facets) => _FilterSections(facets: facets),
                  error: (error, stackTrace) => Center(
                    child: Padding(
                      padding: const EdgeInsets.all(AppSpacing.md),
                      child: AppStatusView(
                        icon: Icons.cloud_off_outlined,
                        title: l10n.guestFiltersLoadError,
                        message: localizedListingsError(l10n, error),
                        action: FilledButton(
                          onPressed: () =>
                              ref.invalidate(listingFacetsProvider),
                          child: Text(l10n.retry),
                        ),
                      ),
                    ),
                  ),
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                ),
              ),
              const Divider(),
              const _FilterActions(),
            ],
          ),
        ),
      ),
    );
  }
}

class _FilterSections extends ConsumerWidget {
  const _FilterSections({required this.facets});

  final ListingFacets facets;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final draftState = ref.watch(guestFilterDraftProvider);
    final draft = draftState.filters;
    final notifier = ref.read(guestFilterDraftProvider.notifier);
    final guests = draft.guests ?? 1;

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
      children: [
        _FilterSection(
          title: l10n.guestFiltersDestination,
          child: Wrap(
            spacing: AppSpacing.xs,
            runSpacing: AppSpacing.xs,
            children: [
              AppChip(
                label: l10n.guestHomeAnywhere,
                selected: draft.city == null,
                onPressed: () => notifier.selectCity(null),
              ),
              for (final city in facets.cities)
                AppChip(
                  label: city,
                  selected: draft.city == city,
                  onPressed: () => notifier.selectCity(city),
                ),
            ],
          ),
        ),
        const Divider(),
        _FilterSection(
          title: l10n.guestFiltersDates,
          child: _StayDatesPicker(
            stay: draft.dates,
            pendingCheckIn: draftState.pendingCheckIn,
            today: ref.watch(guestCalendarTodayProvider),
            onDaySelected: notifier.selectDay,
          ),
        ),
        const Divider(),
        _GuestsStepper(
          guests: guests,
          canDecrement: guests > 1,
          canIncrement: guests < facets.maxGuests,
          onDecrement: notifier.decrementGuests,
          onIncrement: () =>
              notifier.incrementGuests(maxGuests: facets.maxGuests),
        ),
        const Divider(),
        _PriceRangeSection(
          draft: draft,
          bounds: priceBoundsOf(facets),
          currencyCode: facets.currency,
          onChanged: (values, bounds) => notifier.setPriceRange(
            min: values.start.round(),
            max: values.end.round(),
            bounds: bounds,
          ),
        ),
      ],
    );
  }
}

class _FilterSection extends StatelessWidget {
  const _FilterSection({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: AppSpacing.md),
          child,
        ],
      ),
    );
  }
}

class _StayDatesPicker extends StatelessWidget {
  const _StayDatesPicker({
    required this.stay,
    required this.pendingCheckIn,
    required this.today,
    required this.onDaySelected,
  });

  final StayDates? stay;
  final DateTime? pendingCheckIn;
  final DateTime today;
  final ValueChanged<DateTime> onDaySelected;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final stay = this.stay;
    final checkIn = stay?.checkIn ?? pendingCheckIn;
    final checkOut = stay?.checkOut;
    final lastMonth = DateUtils.addMonthsToMonthDate(
      today,
      guestCalendarMonthsAhead,
    );
    final pending = pendingCheckIn;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(
              child: _DateValue(label: l10n.guestFiltersCheckIn, date: checkIn),
            ),
            const SizedBox(width: AppSpacing.xs),
            Expanded(
              child: _DateValue(
                label: l10n.guestFiltersCheckOut,
                date: checkOut,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        AppDateRangeCalendar(
          firstDate: today,
          lastDate: DateTime(
            lastMonth.year,
            lastMonth.month,
            DateUtils.getDaysInMonth(lastMonth.year, lastMonth.month),
          ),
          rangeStart: checkIn,
          rangeEnd: checkOut,
          selectableDayPredicate: pending == null
              ? null
              : (day) =>
                    StayDates.nightsBetween(pending, day) <=
                    StayDates.maxNights,
          onDaySelected: onDaySelected,
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          stay == null
              ? l10n.guestFiltersPickDates
              : l10n.guestFiltersNightsHint(stay.nights),
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: context.accommodationColors.textMuted,
          ),
        ),
      ],
    );
  }
}

class _DateValue extends StatelessWidget {
  const _DateValue({required this.label, required this.date});

  final String label;
  final DateTime? date;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final textTheme = Theme.of(context).textTheme;
    final date = this.date;

    return MergeSemantics(
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(
            color: context.accommodationColors.borderPrimary,
            width: AppBorderWidths.regular,
          ),
          borderRadius: AppRadii.smBorder,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.xs,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: textTheme.bodyMedium?.copyWith(
                  color: context.accommodationColors.textMuted,
                ),
              ),
              Text(
                date == null
                    ? l10n.guestFiltersAddDate
                    : MaterialLocalizations.of(context).formatMediumDate(date),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: textTheme.titleMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _GuestsStepper extends StatelessWidget {
  const _GuestsStepper({
    required this.guests,
    required this.canDecrement,
    required this.canIncrement,
    required this.onDecrement,
    required this.onIncrement,
  });

  final int guests;
  final bool canDecrement;
  final bool canIncrement;
  final VoidCallback onDecrement;
  final VoidCallback onIncrement;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final titleStyle = Theme.of(context).textTheme.titleMedium;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.lg),
      child: Row(
        children: [
          Expanded(child: Text(l10n.guestFiltersGuests, style: titleStyle)),
          AppIconButton(
            icon: Icons.remove,
            iconSize: AppIconSizes.sm,
            tooltip: l10n.guestFiltersFewerGuests,
            onPressed: canDecrement ? onDecrement : null,
          ),
          const SizedBox(width: AppSpacing.md),
          SizedBox(
            width: AppSpacing.xl,
            child: Text(
              '$guests',
              semanticsLabel: l10n.guestCount(guests),
              textAlign: TextAlign.center,
              style: titleStyle,
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          AppIconButton(
            icon: Icons.add,
            iconSize: AppIconSizes.sm,
            tooltip: l10n.guestFiltersMoreGuests,
            onPressed: canIncrement ? onIncrement : null,
          ),
        ],
      ),
    );
  }
}

class _PriceRangeSection extends StatelessWidget {
  const _PriceRangeSection({
    required this.draft,
    required this.bounds,
    required this.currencyCode,
    required this.onChanged,
  });

  final ListingSearchQuery draft;
  final PriceBounds bounds;
  final String currencyCode;
  final void Function(RangeValues values, PriceBounds bounds) onChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final locale = Localizations.localeOf(context).toLanguageTag();
    final min = bounds.min.toDouble();
    final max = bounds.max.toDouble();
    final values = RangeValues(
      (draft.minPrice ?? min).toDouble().clamp(min, max),
      (draft.maxPrice ?? max).toDouble().clamp(min, max),
    );
    final hasRange = bounds.max > bounds.min;

    String format(num amount) =>
        formatGuestPrice(amount, currencyCode: currencyCode, locale: locale);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            l10n.guestFiltersPricePerNight,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: AppSpacing.lg),
          RangeSlider(
            values: values,
            min: min,
            max: max,
            divisions: hasRange ? bounds.max - bounds.min : null,
            semanticFormatterCallback: (value) => format(value.round()),
            onChanged: hasRange ? (values) => onChanged(values, bounds) : null,
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _PriceValue(label: format(values.start.round())),
              _PriceValue(label: format(values.end.round())),
            ],
          ),
        ],
      ),
    );
  }
}

class _PriceValue extends StatelessWidget {
  const _PriceValue({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border.all(
          color: context.accommodationColors.borderPrimary,
          width: AppBorderWidths.regular,
        ),
        borderRadius: AppRadii.smBorder,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.xs,
        ),
        child: Text(label, style: Theme.of(context).textTheme.bodyMedium),
      ),
    );
  }
}

class _FilterActions extends ConsumerWidget {
  const _FilterActions();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final count = ref.watch(guestFilterResultCountProvider).value;

    return Padding(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(
            onPressed: ref.read(guestFilterDraftProvider.notifier).clear,
            style: underlinedButtonStyle(
              context,
              color: context.accommodationColors.textDefault,
            ),
            child: Text(l10n.guestHomeClearAll),
          ),
          const SizedBox(width: AppSpacing.md),
          Flexible(
            child: FilledButton(
              onPressed: () {
                ref
                    .read(guestListingFiltersProvider.notifier)
                    .apply(ref.read(guestFilterDraftProvider).filters);
                Navigator.of(context).pop();
              },
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              ),
              child: Text(
                count == null
                    ? l10n.guestFiltersShowStays
                    : l10n.guestFiltersShowStayCount(count),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
