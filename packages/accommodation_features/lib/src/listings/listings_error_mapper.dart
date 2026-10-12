import 'package:accommodation_core/accommodation_core.dart';
import 'package:accommodation_ui/accommodation_ui.dart';

import 'listings_providers.dart';

String localizedListingsError(AppLocalizations l10n, Object? error) {
  final failure = error is ListingsLoadException ? error.failure : error;

  if (failure is ApiFailure && failure.type == ApiFailureType.network) {
    return l10n.listingsErrorNetwork;
  }

  return l10n.listingsErrorGeneric;
}
