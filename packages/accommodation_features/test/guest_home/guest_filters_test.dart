import 'package:accommodation_core/accommodation_core.dart';
import 'package:accommodation_core/testing.dart';
import 'package:accommodation_features/src/guest_home/guest_filter_draft.dart';
import 'package:accommodation_features/src/guest_home/guest_filter_labels.dart';
import 'package:accommodation_features/src/guest_home/guest_listing_filters.dart';
import 'package:accommodation_features/src/listings/listings_providers.dart';
import 'package:accommodation_features/testing.dart';
import 'package:accommodation_ui/accommodation_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

void main() {
  late FakeListingsRepository repository;
  late ProviderContainer container;

  setUp(() {
    repository = FakeListingsRepository(
      listings: [
        createTestListing(id: 'a', city: 'Lucerne', maxGuests: 2),
        createTestListing(id: 'b', city: 'Zermatt', maxGuests: 6),
      ],
    );
    container = ProviderContainer(
      retry: (_, _) => null,
      overrides: [listingsRepositoryProvider.overrideWithValue(repository)],
    );
    container.listen(guestListingFiltersProvider, (_, _) {});
    container.listen(guestFilterDraftProvider, (_, _) {});
  });

  tearDown(() => container.dispose());

  GuestListingFilters filters() {
    return container.read(guestListingFiltersProvider.notifier);
  }

  GuestFilterDraft draft() => container.read(guestFilterDraftProvider.notifier);

  ListingSearchQuery draftFilters() =>
      container.read(guestFilterDraftProvider).filters;

  group('GuestListingFilters', () {
    test('clears one filter at a time or all of them', () {
      final stay = StayDates(
        checkIn: DateTime(2026, 3, 1),
        checkOut: DateTime(2026, 3, 3),
      );
      filters().apply(
        ListingSearchQuery(
          city: 'Lucerne',
          guests: 3,
          minPrice: 100,
          maxPrice: 200,
          dates: stay,
        ),
      );

      filters().clearGuests();
      expect(
        container.read(guestListingFiltersProvider),
        ListingSearchQuery(
          city: 'Lucerne',
          minPrice: 100,
          maxPrice: 200,
          dates: stay,
        ),
      );

      filters().clearDates();
      filters().clearPriceRange();
      expect(
        container.read(guestListingFiltersProvider),
        const ListingSearchQuery(city: 'Lucerne'),
      );

      filters().clearAll();
      expect(container.read(guestListingFiltersProvider).isEmpty, isTrue);
    });
  });

  group('GuestFilterDraft', () {
    test('starts from the applied filters', () {
      filters().apply(const ListingSearchQuery(city: 'Zermatt'));

      expect(draftFilters().city, 'Zermatt');
    });

    test('does not change the applied filters until they are applied', () {
      draft().selectCity('Lucerne');

      expect(draftFilters().city, 'Lucerne');
      expect(container.read(guestListingFiltersProvider).city, isNull);
    });

    test('steps guests between one and the catalogue maximum', () {
      draft().decrementGuests();
      expect(draftFilters().guests, isNull);

      draft().incrementGuests(maxGuests: 3);
      draft().incrementGuests(maxGuests: 3);
      draft().incrementGuests(maxGuests: 3);
      expect(draftFilters().guests, 3);

      draft().decrementGuests();
      draft().decrementGuests();
      expect(draftFilters().guests, isNull);
    });

    test('treats a price range covering every listing as no filter', () {
      const bounds = (min: 80, max: 400);

      draft().setPriceRange(min: 100, max: 300, bounds: bounds);
      expect(draftFilters().minPrice, 100);
      expect(draftFilters().maxPrice, 300);

      draft().setPriceRange(min: 80, max: 400, bounds: bounds);
      expect(draftFilters().hasPriceRange, isFalse);
    });

    test('rounds facet prices outward into whole slider bounds', () {
      final bounds = priceBoundsOf(
        createTestFacets(priceMin: 85.4, priceMax: 612.2),
      );

      expect(bounds, (min: 85, max: 613));
    });

    group('dates', () {
      test('takes the first day as check-in and a later one as check-out', () {
        draft().selectDay(DateTime(2026, 3, 1));

        var state = container.read(guestFilterDraftProvider);
        expect(state.pendingCheckIn, DateTime.utc(2026, 3, 1));
        expect(state.filters.dates, isNull);

        draft().selectDay(DateTime(2026, 3, 3));

        state = container.read(guestFilterDraftProvider);
        expect(state.pendingCheckIn, isNull);
        expect(state.filters.dates!.checkInIso, '2026-03-01');
        expect(state.filters.dates!.checkOutIso, '2026-03-03');
        expect(state.filters.dates!.nights, 2);
      });

      test('starts over on the same day, an earlier day or a new stay', () {
        draft()
          ..selectDay(DateTime(2026, 3, 5))
          ..selectDay(DateTime(2026, 3, 5));
        expect(
          container.read(guestFilterDraftProvider).pendingCheckIn,
          DateTime.utc(2026, 3, 5),
        );

        draft().selectDay(DateTime(2026, 3, 2));
        expect(
          container.read(guestFilterDraftProvider).pendingCheckIn,
          DateTime.utc(2026, 3, 2),
        );

        draft()
          ..selectDay(DateTime(2026, 3, 4))
          ..selectDay(DateTime(2026, 4, 1));
        final state = container.read(guestFilterDraftProvider);
        expect(state.filters.dates, isNull);
        expect(state.pendingCheckIn, DateTime.utc(2026, 4, 1));
      });

      test('never builds a stay longer than the API allows', () {
        draft()
          ..selectDay(DateTime(2026, 3, 1))
          ..selectDay(DateTime(2027, 3, 3));

        final state = container.read(guestFilterDraftProvider);
        expect(state.filters.dates, isNull);
        expect(state.pendingCheckIn, DateTime.utc(2027, 3, 3));
      });

      test('clear drops a half-picked stay too', () {
        draft()
          ..selectDay(DateTime(2026, 3, 1))
          ..clear();

        expect(
          container.read(guestFilterDraftProvider),
          const GuestFilterDraftState(filters: ListingSearchQuery()),
        );
      });
    });
  });

  group('guestFilterResultCount', () {
    test('debounces and counts listings for the draft filters', () async {
      container.listen(guestFilterResultCountProvider, (_, _) {});

      draft().incrementGuests(maxGuests: 6);
      draft().incrementGuests(maxGuests: 6);
      draft().incrementGuests(maxGuests: 6);
      final count = await container.read(guestFilterResultCountProvider.future);

      expect(count, 1);
      expect(repository.requests, hasLength(1));
      expect(repository.requests.single.query.guests, 4);
      expect(repository.requests.single.limit, 1);
    });

    test('counts only listings free for every night of the stay', () async {
      repository.bookings = {
        'a': [
          StayDates(
            checkIn: DateTime(2026, 3, 1),
            checkOut: DateTime(2026, 3, 3),
          ),
        ],
      };
      container.listen(guestFilterResultCountProvider, (_, _) {});

      draft()
        ..selectDay(DateTime(2026, 3, 2))
        ..selectDay(DateTime(2026, 3, 4));
      expect(await container.read(guestFilterResultCountProvider.future), 1);

      // The booking's check-out day is free for the next guest.
      draft()
        ..selectDay(DateTime(2026, 3, 3))
        ..selectDay(DateTime(2026, 3, 5));
      expect(await container.read(guestFilterResultCountProvider.future), 2);
      expect(repository.requests.last.query.dates!.checkInIso, '2026-03-03');
    });
  });

  group('labels', () {
    final l10n = AppLocalizationsEn();
    const dates = DefaultMaterialLocalizations();

    test('summarises dates, guests and price in the search bar', () {
      expect(
        guestSearchSummary(
          l10n,
          dates,
          const ListingSearchQuery(),
          currencyCode: 'EUR',
          locale: 'en',
        ),
        'Any dates · Add guests · Any price',
      );
      expect(
        guestSearchSummary(
          l10n,
          dates,
          ListingSearchQuery(
            guests: 1,
            minPrice: 80,
            maxPrice: 250,
            dates: StayDates(
              checkIn: DateTime(2026, 3, 1),
              checkOut: DateTime(2026, 3, 3),
            ),
          ),
          currencyCode: 'EUR',
          locale: 'en',
        ),
        'Mar 1–Mar 3 · 1 guest · €80–€250',
      );
    });
  });
}
