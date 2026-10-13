import 'package:accommodation_core/accommodation_core.dart';
import 'package:accommodation_ui/accommodation_ui.dart';
import 'package:flutter/material.dart';

String bookingStatusLabel(AppLocalizations l10n, BookingStatus status) {
  return switch (status) {
    BookingStatus.confirmed => l10n.bookingStatusConfirmed,
    BookingStatus.pending => l10n.bookingStatusPending,
    BookingStatus.completed => l10n.bookingStatusCompleted,
    BookingStatus.cancelled => l10n.bookingStatusCancelled,
    BookingStatus.unknown => l10n.bookingStatusUnknown,
  };
}

String bookingSummary(
  AppLocalizations l10n,
  MaterialLocalizations dates,
  Booking booking,
) {
  return [
    l10n.dateRange(
      dates.formatMediumDate(booking.checkIn),
      dates.formatMediumDate(booking.checkOut),
    ),
    l10n.hostBookingsNights(booking.nights),
    l10n.guestCount(booking.guests),
  ].join(' · ');
}

({Color background, Color foreground}) bookingStatusColors(
  ColorScheme scheme,
  BookingStatus status,
) {
  return switch (status) {
    BookingStatus.confirmed => (
      background: scheme.primaryContainer,
      foreground: scheme.onPrimaryContainer,
    ),
    BookingStatus.pending => (
      background: scheme.tertiaryContainer,
      foreground: scheme.onTertiaryContainer,
    ),
    BookingStatus.cancelled => (
      background: scheme.errorContainer,
      foreground: scheme.onErrorContainer,
    ),
    BookingStatus.completed || BookingStatus.unknown => (
      background: scheme.surfaceContainerHighest,
      foreground: scheme.onSurfaceVariant,
    ),
  };
}
