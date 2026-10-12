import 'package:accommodation_core/accommodation_core.dart';
import 'package:accommodation_ui/accommodation_ui.dart';

import '../listings/listings_error_mapper.dart';
import '../listings/listings_providers.dart';

bool isListingNotFound(Object? error) {
  return error is ListingsLoadException &&
      error.failure.type == ApiFailureType.http &&
      error.failure.statusCode == 404;
}

String localizedListingDetailErrorTitle(AppLocalizations l10n, Object? error) {
  return isListingNotFound(error)
      ? l10n.listingDetailNotFoundTitle
      : l10n.listingDetailErrorTitle;
}

String localizedListingDetailError(AppLocalizations l10n, Object? error) {
  return isListingNotFound(error)
      ? l10n.listingDetailNotFoundMessage
      : localizedListingsError(l10n, error);
}
