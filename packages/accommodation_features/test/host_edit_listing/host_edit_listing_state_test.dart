import 'package:accommodation_core/accommodation_core.dart';
import 'package:accommodation_core/testing.dart';
import 'package:accommodation_features/src/host_edit_listing/host_edit_listing_error_mapper.dart';
import 'package:accommodation_features/src/host_edit_listing/host_edit_listing_state.dart';
import 'package:accommodation_features/src/host_edit_listing/host_edit_listing_validators.dart';
import 'package:accommodation_ui/accommodation_ui.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final l10n = AppLocalizationsEn();

  group('HostEditListingState', () {
    final state = HostEditListingState.fromListing(createTestListing());

    test('has no changes when nothing was edited', () {
      expect(state.hasChanges, isFalse);
      expect(state.changes, isEmpty);
    });

    test('sends only the fields that differ from the listing', () {
      final edited = state.copyWith(
        pricePerNight: 199,
        maxGuests: 4,
        amenities: const ['wifi', 'sauna'],
      );

      expect(edited.changes, {
        'pricePerNight': 199,
        'maxGuests': 4,
        'amenities': ['wifi', 'sauna'],
      });
    });

    test('trims text and ignores whitespace-only edits', () {
      expect(state.copyWith(title: '  ${state.title}  ').hasChanges, isFalse);
      expect(state.copyWith(title: '  New title ').changes, {
        'title': 'New title',
      });
    });

    test('counts an edit undone by hand as no change', () {
      final undone = state
          .copyWith(pricePerNight: 250)
          .copyWith(pricePerNight: state.pricePerNight);

      expect(undone.hasChanges, isFalse);
    });
  });

  group('validateListingNumber', () {
    test('requires a value', () {
      expect(
        validateListingNumber(l10n, ' ', wholeNumber: false),
        l10n.hostEditListingFieldRequired,
      );
    });

    test('accepts a decimal comma for prices', () {
      expect(validateListingNumber(l10n, '12,5', wholeNumber: false), isNull);
      expect(parseListingNumber('12,5', wholeNumber: false), 12.5);
    });

    test('refuses fractions and negatives for counts', () {
      expect(
        validateListingNumber(l10n, '2.5', wholeNumber: true),
        l10n.hostEditListingInvalidWholeNumber,
      );
      expect(
        validateListingNumber(l10n, '-1', wholeNumber: true),
        l10n.hostEditListingInvalidWholeNumber,
      );
      expect(
        validateListingNumber(l10n, '-1', wholeNumber: false),
        l10n.hostEditListingInvalidNumber,
      );
    });

    test('enforces a minimum whatever the language', () {
      final german = lookupAppLocalizations(const Locale('de'));

      expect(
        validateListingNumber(german, '0', wholeNumber: true, min: 1),
        german.hostEditListingMinValue(1),
      );
      expect(
        validateListingNumber(german, '1', wholeNumber: true, min: 1),
        isNull,
      );
    });
  });

  group('localizedHostEditListingError', () {
    ApiFailure http(String? messageCode) => ApiFailure(
      type: ApiFailureType.http,
      statusCode: 400,
      messageCode: messageCode,
      message: 'Server wording that must not reach the user',
    );

    test('maps known message codes to our own wording', () {
      expect(
        localizedHostEditListingError(l10n, http('error.badRequest')),
        l10n.hostEditListingErrorRejected,
      );
      expect(
        localizedHostEditListingError(l10n, http('error.fieldRequired')),
        l10n.hostEditListingErrorFieldRequired,
      );
      expect(
        localizedHostEditListingError(l10n, http('listing.NotFoundException')),
        l10n.hostEditListingErrorNotFound,
      );
    });

    test('falls back to a generic message for an unknown code', () {
      expect(
        localizedHostEditListingError(l10n, http('error.somethingNew')),
        l10n.hostEditListingErrorGeneric,
      );
      expect(
        localizedHostEditListingError(l10n, http(null)),
        l10n.hostEditListingErrorGeneric,
      );
    });

    test('tells a network failure apart', () {
      expect(
        localizedHostEditListingError(
          l10n,
          const ApiFailure(type: ApiFailureType.network),
        ),
        l10n.listingsErrorNetwork,
      );
    });
  });
}
