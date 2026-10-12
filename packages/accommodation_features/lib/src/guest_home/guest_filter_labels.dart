import 'package:accommodation_core/accommodation_core.dart';
import 'package:accommodation_ui/accommodation_ui.dart';
import 'package:flutter/material.dart';

String formatGuestPrice(
  num amount, {
  required String? currencyCode,
  required String locale,
}) {
  if (currencyCode == null) return '$amount';

  return formatCurrencyAmount(
    amount,
    currencyCode: currencyCode,
    locale: locale,
  );
}

String guestPriceRangeLabel(
  AppLocalizations l10n, {
  required num min,
  required num max,
  required String? currencyCode,
  required String locale,
}) {
  return l10n.priceRange(
    formatGuestPrice(min, currencyCode: currencyCode, locale: locale),
    formatGuestPrice(max, currencyCode: currencyCode, locale: locale),
  );
}

/// The check-in and check-out days, for example "Mar 1–Mar 3".
String guestStayDatesLabel(
  AppLocalizations l10n,
  MaterialLocalizations dates,
  StayDates stay,
) {
  return l10n.dateRange(
    dates.formatShortMonthDay(stay.checkIn),
    dates.formatShortMonthDay(stay.checkOut),
  );
}

String guestSearchSummary(
  AppLocalizations l10n,
  MaterialLocalizations dates,
  ListingSearchQuery filters, {
  required String? currencyCode,
  required String locale,
}) {
  final stay = filters.dates;
  final guests = filters.guests;

  return [
    stay == null
        ? l10n.guestHomeAnyDates
        : guestStayDatesLabel(l10n, dates, stay),
    guests == null ? l10n.guestHomeAddGuests : l10n.guestCount(guests),
    filters.hasPriceRange
        ? guestPriceRangeLabel(
            l10n,
            min: filters.minPrice!,
            max: filters.maxPrice!,
            currencyCode: currencyCode,
            locale: locale,
          )
        : l10n.guestHomeAnyPrice,
  ].join(' · ');
}
