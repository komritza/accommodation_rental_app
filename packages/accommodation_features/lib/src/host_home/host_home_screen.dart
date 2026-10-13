import 'dart:math' as math;

import 'package:accommodation_ui/accommodation_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../common/dependencies.dart';
import '../listings/listings_error_mapper.dart';
import 'host_listings_controller.dart';
import 'host_listings_state.dart';
import 'widgets/host_listing_card.dart';

class HostHomeScreen extends ConsumerWidget {
  const HostHomeScreen({
    super.key,
    required this.onProfilePressed,
    required this.onListingPressed,
  });

  final VoidCallback onProfilePressed;
  final ValueChanged<String> onListingPressed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final config = ref.watch(runtimeConfigProvider).value;
    final listings = ref.watch(hostListingsControllerProvider);

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
                      padding: horizontal.copyWith(
                        top: AppSpacing.md,
                        bottom: AppSpacing.md,
                      ),
                      sliver: SliverToBoxAdapter(
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    config?.name ?? '',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(
                                      context,
                                    ).textTheme.titleMedium,
                                  ),
                                  const SizedBox(height: AppSpacing.xxs),
                                  Text(
                                    l10n.hostHomeTitle,
                                    style: Theme.of(
                                      context,
                                    ).textTheme.headlineMedium,
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              onPressed: onProfilePressed,
                              tooltip: l10n.hostHomeProfileTooltip,
                              icon: const Icon(Icons.account_circle_outlined),
                            ),
                          ],
                        ),
                      ),
                    ),
                    ..._buildResults(
                      context,
                      ref,
                      listings: listings,
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
    final nearEnd = metrics.extentAfter < 400;

    if (depth == 0 && metrics.axis == Axis.vertical && nearEnd) {
      ref.read(hostListingsControllerProvider.notifier).loadNextPage();
    }

    return false;
  }

  List<Widget> _buildResults(
    BuildContext context,
    WidgetRef ref, {
    required AsyncValue<HostListingsState> listings,
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
                title: l10n.hostHomeLoadErrorTitle,
                message: localizedListingsError(l10n, listings.error),
                action: FilledButton(
                  onPressed: () =>
                      ref.invalidate(hostListingsControllerProvider),
                  child: Text(l10n.retry),
                ),
              ),
            ),
          ),
        ),
      ];
    }

    final state = listings.requireValue;

    if (state.listings.isEmpty) {
      return [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Padding(
            padding: padding.copyWith(
              top: AppSpacing.xl,
              bottom: AppSpacing.xl,
            ),
            child: AppStatusView(
              icon: Icons.home_work_outlined,
              title: l10n.hostHomeEmptyTitle,
              message: l10n.hostHomeEmptyMessage,
            ),
          ),
        ),
      ];
    }

    return [
      SliverPadding(
        padding: padding,
        sliver: SliverToBoxAdapter(
          child: Text(
            l10n.hostHomeListingCount(state.totalCount),
            style: mutedStyle,
          ),
        ),
      ),
      SliverPadding(
        padding: padding.copyWith(top: AppSpacing.md, bottom: AppSpacing.md),
        sliver: SliverList.separated(
          itemCount: state.listings.length,
          separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.xl),
          itemBuilder: (context, index) {
            final listing = state.listings[index];

            return HostListingCard(
              listing: listing,
              onTap: () => onListingPressed(listing.id),
            );
          },
        ),
      ),
      SliverPadding(
        padding: padding,
        sliver: SliverToBoxAdapter(child: _HostListingsFooter(state: state)),
      ),
    ];
  }
}

class _HostListingsFooter extends ConsumerWidget {
  const _HostListingsFooter({required this.state});

  final HostListingsState state;

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
            l10n.hostHomeLoadMoreError,
            textAlign: TextAlign.center,
            style: mutedStyle,
          ),
          TextButton(
            onPressed: ref
                .read(hostListingsControllerProvider.notifier)
                .retryNextPage,
            child: Text(l10n.retry),
          ),
        ],
      );
    } else if (state.hasMore) {
      child = const Center(child: CircularProgressIndicator());
    } else {
      child = Text(
        l10n.hostHomeEndOfResults,
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
