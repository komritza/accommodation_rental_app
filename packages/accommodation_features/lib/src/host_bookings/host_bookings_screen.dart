import 'package:accommodation_core/accommodation_core.dart';
import 'package:accommodation_ui/accommodation_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../guest_home/guest_filter_labels.dart';
import '../listings/listings_error_mapper.dart';
import 'host_bookings_controller.dart';
import 'host_bookings_labels.dart';
import 'host_bookings_state.dart';

class HostBookingsScreen extends ConsumerWidget {
  const HostBookingsScreen({super.key, required this.listingId});

  final String listingId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final provider = hostBookingsControllerProvider(listingId);
    final bookings = ref.watch(provider);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.hostBookingsTitle)),
      body: bookings.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: AppStatusView(
              icon: Icons.cloud_off_outlined,
              title: l10n.hostBookingsLoadErrorTitle,
              message: localizedListingsError(l10n, error),
              action: FilledButton(
                onPressed: () => ref.invalidate(provider),
                child: Text(l10n.retry),
              ),
            ),
          ),
        ),
        data: (state) => state.bookings.isEmpty
            ? Center(
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  child: AppStatusView(
                    icon: Icons.event_note_outlined,
                    title: l10n.hostBookingsEmptyTitle,
                    message: l10n.hostBookingsEmptyMessage,
                  ),
                ),
              )
            : _HostBookingsList(listingId: listingId, state: state),
      ),
    );
  }
}

class _HostBookingsList extends StatelessWidget {
  const _HostBookingsList({required this.listingId, required this.state});

  final String listingId;
  final HostBookingsState state;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colors = context.accommodationColors;
    final hasFooter = state.hasMore || state.loadMoreFailure != null;

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: AppLayoutTokens.contentMaxWidth,
        ),
        child: ListView.separated(
          padding: const EdgeInsets.all(AppSpacing.md),
          itemCount: state.bookings.length + (hasFooter ? 2 : 1),
          separatorBuilder: (_, _) => const Divider(height: AppSpacing.lg),
          itemBuilder: (context, index) {
            if (index == 0) {
              return Text(
                l10n.hostBookingsCount(state.totalCount),
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: colors.textMuted),
              );
            }
            if (index > state.bookings.length) {
              return _HostBookingsFooter(listingId: listingId, state: state);
            }
            return _BookingTile(booking: state.bookings[index - 1]);
          },
        ),
      ),
    );
  }
}

class _BookingTile extends StatelessWidget {
  const _BookingTile({required this.booking});

  final Booking booking;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final colors = context.accommodationColors;
    final locale = Localizations.localeOf(context).toLanguageTag();
    final statusColors = bookingStatusColors(theme.colorScheme, booking.status);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                booking.guestName,
                style: theme.textTheme.titleMedium,
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            AppBadge(
              label: bookingStatusLabel(l10n, booking.status),
              backgroundColor: statusColors.background,
              foregroundColor: statusColors.foreground,
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.xxs),
        Text(
          bookingSummary(l10n, MaterialLocalizations.of(context), booking),
          style: theme.textTheme.bodyMedium?.copyWith(color: colors.textMuted),
        ),
        const SizedBox(height: AppSpacing.xxs),
        Text(
          formatGuestPrice(
            booking.totalPrice,
            currencyCode: booking.currency,
            locale: locale,
          ),
          style: theme.textTheme.bodyLarge,
        ),
      ],
    );
  }
}

class _HostBookingsFooter extends ConsumerWidget {
  const _HostBookingsFooter({required this.listingId, required this.state});

  final String listingId;
  final HostBookingsState state;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final loadMore = ref
        .read(hostBookingsControllerProvider(listingId).notifier)
        .loadMore;

    if (state.isLoadingMore) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.loadMoreFailure != null) {
      return Column(
        children: [
          Text(
            l10n.hostBookingsLoadMoreError,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: context.accommodationColors.textMuted,
            ),
          ),
          TextButton(onPressed: loadMore, child: Text(l10n.retry)),
        ],
      );
    }

    return Center(
      child: OutlinedButton(
        onPressed: loadMore,
        child: Text(l10n.hostBookingsLoadMore),
      ),
    );
  }
}
