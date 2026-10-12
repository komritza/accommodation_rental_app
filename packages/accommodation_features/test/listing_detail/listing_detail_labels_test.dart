import 'package:accommodation_core/testing.dart';
import 'package:accommodation_features/src/listing_detail/listing_detail_labels.dart';
import 'package:accommodation_ui/accommodation_ui.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final l10n = AppLocalizationsEn();

  group('amenityLabel', () {
    test('localizes known amenities', () {
      expect(amenityLabel(l10n, 'wifi'), 'Wi-Fi');
      expect(amenityLabel(l10n, 'hot_tub'), 'Hot tub');
      expect(
        amenityLabel(lookupAppLocalizations(const Locale('de')), 'hot_tub'),
        'Whirlpool',
      );
    });

    test('falls back to a readable slug for unknown amenities', () {
      expect(amenityLabel(l10n, 'rooftop_cinema'), 'Rooftop Cinema');
    });
  });

  group('listingFactsSummary', () {
    test('lists guests, bedrooms, beds and bathrooms', () {
      final listing = createTestListing(
        maxGuests: 4,
        bedrooms: 2,
        beds: 3,
        bathrooms: 1,
      );

      expect(
        listingFactsSummary(l10n, listing),
        '4 guests · 2 bedrooms · 3 beds · 1 bathroom',
      );
    });

    test('skips the facts the listing has none of', () {
      final listing = createTestListing(maxGuests: 2, bedrooms: 0, beds: 1);

      expect(
        listingFactsSummary(l10n, listing),
        '2 guests · 1 bed · 1 bathroom',
      );
    });
  });
}
