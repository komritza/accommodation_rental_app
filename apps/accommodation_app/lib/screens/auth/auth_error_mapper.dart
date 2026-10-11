import 'package:accommodation_app/l10n/app_localizations.dart';
import 'package:accommodation_core/accommodation_core.dart';

String localizedAuthError(AppLocalizations l10n, ApiFailure failure) {
  if (failure.type == ApiFailureType.network) {
    return l10n.authErrorNetwork;
  }

  return switch (failure.statusCode) {
    401 => l10n.authErrorBadCredentials,
    409 => l10n.authErrorUserAlreadyExists,
    400 => l10n.authErrorBadRequest,
    _ => l10n.authErrorGeneric,
  };
}
