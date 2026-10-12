import 'dart:math' as math;

import 'package:accommodation_ui/accommodation_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../common/dependencies.dart';
import '../listings/listings_error_mapper.dart';
import '../listings/listings_providers.dart';
import 'guest_filter_labels.dart';
import 'guest_home_layout_tokens.dart';
import 'guest_listing_filters.dart';
import 'guest_listings_controller.dart';
import 'guest_listings_state.dart';
import 'widgets/active_filter_chips.dart';
import 'widgets/guest_filters_sheet.dart';
import 'widgets/guest_search_bar.dart';
import 'widgets/listing_card.dart';

class GuestHomeScreen extends ConsumerWidget {
  const GuestHomeScreen({super.key, required this.onProfilePressed});

  final VoidCallback onProfilePressed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(listingFacetsProvider, (_, _) {});

    final l10n = AppLocalizations.of(context)!;
    final dateLocalizations = MaterialLocalizations.of(context);
    final locale = Localizations.localeOf(context).toLanguageTag();
    final config = ref.watch(runtimeConfigProvider).value;
    final currencyCode = config?.currency;
    final filters = ref.watch(guestListingFiltersProvider);
    final filtersNotifier = ref.read(guestListingFiltersProvider.notifier);
    final listings = ref.watch(guestListingsControllerProvider);

    final activeFilters = <ActiveFilter>[
      if (filters.dates case final stay?)
        (
          label: guestStayDatesLabel(l10n, dateLocalizations, stay),
          onRemove: filtersNotifier.clearDates,
        ),
      if (filters.city case final city?)
        (label: city, onRemove: filtersNotifier.clearCity),
      if (filters.guests case final guests?)
        (label: l10n.guestCount(guests), onRemove: filtersNotifier.clearGuests),
      if (filters.hasPriceRange)
        (
          label: guestPriceRangeLabel(
            l10n,
            min: filters.minPrice!,
            max: filters.maxPrice!,
            currencyCode: currencyCode,
            locale: locale,
          ),
          onRemove: filtersNotifier.clearPriceRange,
        ),
    ];

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final gutter = math.max(
              0.0,
              (constraints.maxWidth - AppLayoutTokens.contentMaxWidth) / 2,
            );
            final horizontal = EdgeInsets.symmetric(
              horizontal: gutter + AppSpacing.md,
            );

            return NotificationListener<ScrollMetricsNotification>(
              onNotification: (notification) =>
                  _onScroll(ref, notification.depth, notification.metrics),
              child: NotificationListener<ScrollUpdateNotification>(
                onNotification: (notification) =>
                    _onScroll(ref, notification.depth, notification.metrics),
                child: CustomScrollView(
                  slivers: [
                    SliverPadding(
                      padding: horizontal.copyWith(top: AppSpacing.md),
                      sliver: SliverToBoxAdapter(
                        child: _GuestHomeHeader(
                          wordmark: config?.name ?? '',
                          onProfilePressed: onProfilePressed,
                        ),
                      ),
                    ),
                    SliverPadding(
                      padding: horizontal.copyWith(top: AppSpacing.md),
                      sliver: SliverToBoxAdapter(
                        child: GuestSearchBar(
                          title: filters.city ?? l10n.guestHomeAnywhere,
                          summary: guestSearchSummary(
                            l10n,
                            dateLocalizations,
                            filters,
                            currencyCode: currencyCode,
                            locale: locale,
                          ),
                          filtersTooltip: l10n.guestHomeFilters,
                          onSearchPressed: () => showGuestFiltersSheet(context),
                          onFiltersPressed: () =>
                              showGuestFiltersSheet(context),
                        ),
                      ),
                    ),
                    if (activeFilters.isNotEmpty)
                      SliverPadding(
                        padding: const EdgeInsets.only(top: AppSpacing.md),
                        sliver: SliverToBoxAdapter(
                          child: ActiveFilterChips(
                            filters: activeFilters,
                            onClearAll: filtersNotifier.clearAll,
                            padding: horizontal,
                          ),
                        ),
                      ),
                    ..._buildResults(
                      context,
                      ref,
                      listings: listings,
                      hasFilters: activeFilters.isNotEmpty,
                      padding: horizontal,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  bool _onScroll(WidgetRef ref, int depth, ScrollMetrics metrics) {
    final nearEnd =
        metrics.extentAfter < GuestHomeLayoutTokens.loadMoreTriggerExtent;
    if (depth == 0 && metrics.axis == Axis.vertical && nearEnd) {
      ref.read(guestListingsControllerProvider.notifier).loadNextPage();
    }
    return false;
  }

  List<Widget> _buildResults(
    BuildContext context,
    WidgetRef ref, {
    required AsyncValue<GuestListingsState> listings,
    required bool hasFilters,
    required EdgeInsets padding,
  }) {
    final l10n = AppLocalizations.of(context)!;
    final colors = context.accommodationColors;
    final mutedStyle = Theme.of(
      context,
    ).textTheme.bodyMedium?.copyWith(color: colors.textMuted);

    if (listings.isLoading) {
      return const [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Center(child: CircularProgressIndicator()),
        ),
      ];
    }

    if (listings.hasError) {
      return [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Padding(
            padding: padding.copyWith(
              top: AppSpacing.xl,
              bottom: AppSpacing.xl,
            ),
            child: Center(
              child: AppStatusView(
                icon: Icons.cloud_off_outlined,
                title: l10n.guestHomeLoadErrorTitle,
                message: localizedListingsError(l10n, listings.error),
                action: FilledButton(
                  onPressed: () =>
                      ref.invalidate(guestListingsControllerProvider),
                  child: Text(l10n.retry),
                ),
              ),
            ),
          ),
        ),
      ];
    }

    final state = listings.requireValue;

    return [
      SliverPadding(
        padding: padding.copyWith(top: AppSpacing.md),
        sliver: SliverToBoxAdapter(
          child: Text(
            l10n.guestHomeStayCount(state.totalCount),
            style: mutedStyle,
          ),
        ),
      ),
      if (state.listings.isEmpty)
        SliverPadding(
          padding: padding.copyWith(top: AppSpacing.xl, bottom: AppSpacing.xl),
          sliver: SliverToBoxAdapter(
            child: AppStatusView(
              icon: Icons.search,
              title: l10n.guestHomeNoResultsTitle,
              message: l10n.guestHomeNoResultsMessage,
              action: hasFilters
                  ? OutlinedButton(
                      onPressed: ref
                          .read(guestListingFiltersProvider.notifier)
                          .clearAll,
                      child: Text(l10n.guestHomeClearFilters),
                    )
                  : null,
            ),
          ),
        )
      else ...[
        SliverPadding(
          padding: padding.copyWith(top: AppSpacing.md),
          sliver: SliverList.separated(
            itemCount: state.listings.length,
            separatorBuilder: (context, index) =>
                const SizedBox(height: AppSpacing.lg),
            itemBuilder: (context, index) =>
                ListingCard(listing: state.listings[index]),
          ),
        ),
        SliverPadding(
          padding: padding,
          sliver: SliverToBoxAdapter(child: _ResultsFooter(state: state)),
        ),
      ],
    ];
  }
}

class _GuestHomeHeader extends StatelessWidget {
  const _GuestHomeHeader({
    required this.wordmark,
    required this.onProfilePressed,
  });

  final String wordmark;
  final VoidCallback onProfilePressed;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Row(
      children: [
        Expanded(
          child: Semantics(
            header: true,
            child: Text(
              wordmark,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
        ),
        const SizedBox(width: AppSpacing.md),
        AppIconButton(
          icon: Icons.person_outline,
          tooltip: l10n.guestNavProfile,
          variant: AppIconButtonVariant.tonal,
          onPressed: onProfilePressed,
        ),
      ],
    );
  }
}

class _ResultsFooter extends ConsumerWidget {
  const _ResultsFooter({required this.state});

  final GuestListingsState state;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final mutedStyle = Theme.of(context).textTheme.bodyMedium?.copyWith(
      color: context.accommodationColors.textMuted,
    );

    final Widget child;
    if (state.loadMoreFailure != null) {
      child = Column(
        children: [
          Text(
            l10n.guestHomeLoadMoreError,
            textAlign: TextAlign.center,
            style: mutedStyle,
          ),
          TextButton(
            onPressed: ref
                .read(guestListingsControllerProvider.notifier)
                .retryNextPage,
            child: Text(l10n.retry),
          ),
        ],
      );
    } else if (state.hasMore) {
      child = const Center(child: CircularProgressIndicator());
    } else {
      child = Text(
        l10n.guestHomeEndOfResults,
        textAlign: TextAlign.center,
        style: mutedStyle,
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
      child: child,
    );
  }
}
