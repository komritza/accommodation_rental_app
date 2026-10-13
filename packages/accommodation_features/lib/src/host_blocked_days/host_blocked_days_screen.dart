import 'package:accommodation_core/accommodation_core.dart';
import 'package:accommodation_ui/accommodation_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../common/dependencies.dart';
import '../common/guest_calendar.dart';
import '../listing_detail/listing_detail_providers.dart';
import 'host_blocked_days_providers.dart';
import 'host_blocked_days_selection_provider.dart';

class HostBlockedDaysScreen extends ConsumerWidget {
  const HostBlockedDaysScreen({super.key, required this.listingId});

  final String listingId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final runtimeConfig = ref.watch(runtimeConfigProvider);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.hostBlockedDaysTitle)),
      body: runtimeConfig.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => _Message(l10n.hostBlockedDaysLoadError),
        data: (config) => config.permissions.blockedDays
            ? _HostBlockedDaysContent(listingId: listingId)
            : _Message(l10n.hostBlockedDaysNotAvailable),
      ),
    );
  }
}

class _HostBlockedDaysContent extends ConsumerWidget {
  const _HostBlockedDaysContent({required this.listingId});

  final String listingId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final availability = ref.watch(listingAvailabilityProvider(listingId));
    final blockedDays = ref.watch(hostBlockedDaysProvider(listingId));

    if (availability.hasError || blockedDays.hasError) {
      return _Message(
        l10n.hostBlockedDaysLoadError,
        onRetry: () {
          ref.invalidate(listingAvailabilityProvider(listingId));
          ref.invalidate(hostBlockedDaysProvider(listingId));
        },
      );
    }

    final availabilityValue = availability.value;
    final blockedDaysValue = blockedDays.value;
    if (availabilityValue == null || blockedDaysValue == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return _HostBlockedDaysCalendar(
      listingId: listingId,
      bookedDates: {
        for (final day in availabilityValue.unavailable)
          if (day.reason == UnavailableReason.booked) day.date,
      },
      blockedDates: {for (final day in blockedDaysValue) day.date},
    );
  }
}

class _HostBlockedDaysCalendar extends ConsumerWidget {
  const _HostBlockedDaysCalendar({
    required this.listingId,
    required this.bookedDates,
    required this.blockedDates,
  });

  final String listingId;

  /// UTC calendar dates, as [StayDates.calendarDate] makes them.
  final Set<DateTime> bookedDates;
  final Set<DateTime> blockedDates;

  bool _isBooked(DateTime day) =>
      bookedDates.contains(StayDates.calendarDate(day));

  bool _isBlocked(DateTime day) =>
      blockedDates.contains(StayDates.calendarDate(day));

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final today = ref.watch(guestCalendarTodayProvider);
    final window = listingAvailabilityWindow(today);
    final selection = ref.watch(hostBlockedDaysSelectionProvider(listingId));
    final mutation = ref.watch(hostBlockedDaysControllerProvider(listingId));

    final selectionController = ref.read(
      hostBlockedDaysSelectionProvider(listingId).notifier,
    );
    final mutationController = ref.read(
      hostBlockedDaysControllerProvider(listingId).notifier,
    );

    final start = selection.start;
    final isBlockedDaySelected =
        start != null && selection.end == start && _isBlocked(start);

    Future<void> block() async {
      final dates = daysToBlock(
        start: start!,
        end: selection.end,
        isTaken: (day) => _isBooked(day) || _isBlocked(day),
      );
      if (dates.isEmpty || await mutationController.blockDays(dates)) {
        selectionController.clear();
      }
    }

    Future<void> unblock() async {
      if (await mutationController.unblockDay(start!)) {
        selectionController.clear();
      }
    }

    return Padding(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        children: [
          Text(l10n.hostBlockedDaysInstructions),
          const SizedBox(height: AppSpacing.md),
          Expanded(
            child: AppDateRangeCalendar(
              firstDate: today,
              lastDate: window.to.subtract(const Duration(days: 1)),
              rangeStart: selection.start,
              rangeEnd: selection.end,
              unavailableDayPredicate: _isBooked,
              unavailableDayLabel: l10n.hostBlockedDaysBookedLabel,
              dayMarker: (day) {
                if (_isBooked(day)) {
                  return AppCalendarDayMarker(
                    tone: AppCalendarDayTone.critical,
                    label: l10n.hostBlockedDaysBookedLabel,
                  );
                }
                if (_isBlocked(day)) {
                  return AppCalendarDayMarker(
                    tone: AppCalendarDayTone.accent,
                    label: l10n.hostBlockedDaysBlockedLabel,
                  );
                }
                return null;
              },
              onDaySelected: mutation.isLoading
                  ? null
                  : (day) => selectionController.selectDay(
                      day,
                      isBlocked: _isBlocked(day),
                    ),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          const _BlockedDaysLegend(),
          if (mutation.hasError) ...[
            const SizedBox(height: AppSpacing.md),
            Text(
              l10n.hostBlockedDaysActionError,
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
          ],
          const SizedBox(height: AppSpacing.md),
          SizedBox(
            width: double.infinity,
            child: isBlockedDaySelected
                ? OutlinedButton.icon(
                    onPressed: mutation.isLoading ? null : unblock,
                    icon: const Icon(Icons.event_available_outlined),
                    label: Text(l10n.hostBlockedDaysUnblockButton),
                  )
                : FilledButton.icon(
                    onPressed: mutation.isLoading || start == null
                        ? null
                        : block,
                    icon: mutation.isLoading
                        ? const SizedBox.square(
                            dimension: AppIconSizes.md,
                            child: CircularProgressIndicator(
                              strokeWidth: AppBorderWidths.focused,
                            ),
                          )
                        : const Icon(Icons.event_busy_outlined),
                    label: Text(l10n.hostBlockedDaysBlockButton),
                  ),
          ),
        ],
      ),
    );
  }
}

class _Message extends StatelessWidget {
  const _Message(this.message, {this.onRetry});

  final String message;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    final onRetry = this.onRetry;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(message, textAlign: TextAlign.center),
            if (onRetry != null) ...[
              const SizedBox(height: AppSpacing.md),
              FilledButton(
                onPressed: onRetry,
                child: Text(AppLocalizations.of(context)!.retry),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _BlockedDaysLegend extends StatelessWidget {
  const _BlockedDaysLegend();

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final colors = context.accommodationColors;
    final l10n = AppLocalizations.of(context)!;

    return Wrap(
      spacing: AppSpacing.lg,
      runSpacing: AppSpacing.md,
      children: [
        _LegendItem(
          color: AppCalendarDayTone.critical.background(scheme),
          label: l10n.hostBlockedDaysBookedLabel,
        ),
        _LegendItem(
          color: AppCalendarDayTone.accent.background(scheme),
          label: l10n.hostBlockedDaysBlockedLabel,
        ),
        _LegendItem(
          color: Colors.transparent,
          borderColor: colors.borderPrimary,
          label: l10n.hostBlockedDaysAvailableLabel,
        ),
      ],
    );
  }
}

class _LegendItem extends StatelessWidget {
  const _LegendItem({
    required this.color,
    required this.label,
    this.borderColor,
  });

  final Color color;
  final Color? borderColor;
  final String label;

  @override
  Widget build(BuildContext context) {
    final borderColor = this.borderColor;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: AppIconSizes.sm,
          height: AppIconSizes.sm,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            border: borderColor == null
                ? null
                : Border.all(
                    color: borderColor,
                    width: AppBorderWidths.regular,
                  ),
          ),
        ),
        const SizedBox(width: AppSpacing.xs),
        Text(label, style: Theme.of(context).textTheme.bodySmall),
      ],
    );
  }
}
