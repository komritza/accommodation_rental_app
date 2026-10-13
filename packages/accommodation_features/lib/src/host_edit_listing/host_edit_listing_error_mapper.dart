import 'package:accommodation_core/accommodation_core.dart';
import 'package:accommodation_ui/accommodation_ui.dart';

String localizedHostEditListingError(
  AppLocalizations l10n,
  ApiFailure failure,
) {
  if (failure.type == ApiFailureType.network) {
    return l10n.listingsErrorNetwork;
  }

  return switch (failure.messageCode) {
    'error.badRequest' => l10n.hostEditListingErrorRejected,
    'error.fieldRequired' => l10n.hostEditListingErrorFieldRequired,
    'listing.NotFoundException' => l10n.hostEditListingErrorNotFound,
    _ => l10n.hostEditListingErrorGeneric,
  };
}
