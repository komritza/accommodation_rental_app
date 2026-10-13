import 'package:accommodation_ui/accommodation_ui.dart';

String? validateRequiredText(AppLocalizations l10n, String? value) {
  return value == null || value.trim().isEmpty
      ? l10n.hostEditListingFieldRequired
      : null;
}

/// Accepts a decimal comma as well, as German keyboards type one.
num? parseListingNumber(String value, {required bool wholeNumber}) {
  final text = value.trim();
  return wholeNumber
      ? int.tryParse(text)
      : num.tryParse(text.replaceAll(',', '.'));
}

String? validateListingNumber(
  AppLocalizations l10n,
  String? value, {
  required bool wholeNumber,
  int min = 0,
}) {
  final text = value?.trim() ?? '';
  if (text.isEmpty) return l10n.hostEditListingFieldRequired;

  final number = parseListingNumber(text, wholeNumber: wholeNumber);
  if (number == null || number < 0) {
    return wholeNumber
        ? l10n.hostEditListingInvalidWholeNumber
        : l10n.hostEditListingInvalidNumber;
  }

  return number < min ? l10n.hostEditListingMinValue(min) : null;
}
