import 'package:accommodation_app/l10n/app_localizations.dart';

final emailPattern = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]{2,}$');

const minPasswordLength = 8;

String? validateRequiredName(String? value, String message) {
  if (value == null || value.trim().isEmpty) {
    return message;
  }

  return null;
}

String? validateEmail(String? value, AppLocalizations l10n) {
  final trimmed = value?.trim() ?? '';

  if (trimmed.isEmpty) {
    return l10n.authEmailRequired;
  }

  if (!emailPattern.hasMatch(trimmed)) {
    return l10n.authEmailInvalid;
  }

  return null;
}

String? validatePassword(String? value, AppLocalizations l10n) {
  if (value == null || value.isEmpty) {
    return l10n.authPasswordRequired;
  }

  if (value.length < minPasswordLength) {
    return l10n.authPasswordTooShort;
  }

  return null;
}
