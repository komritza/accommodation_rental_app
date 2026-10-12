import 'dart:async';

import 'package:accommodation_core/accommodation_core.dart';
import 'package:accommodation_core/testing.dart';
import 'package:accommodation_features/auth.dart';
import 'package:accommodation_features/dependencies.dart';
import 'package:accommodation_features/favourites.dart';
import 'package:accommodation_features/listing_detail.dart';
import 'package:accommodation_features/listings.dart';
import 'package:accommodation_features/src/common/guest_calendar.dart';
import 'package:accommodation_features/src/listing_detail/widgets/listing_detail_image_carousel.dart';
import 'package:accommodation_features/testing.dart';
import 'package:accommodation_ui/accommodation_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

const _listingId = 'a';

final _listing = createTestListing(
  id: _listingId,
  images: const ['https://example.com/a-1.jpg', 'https://example.com/a-2.jpg'],
).copyWith(amenities: const ['wifi', 'hot_tub', 'rooftop_cinema']);

final _today = DateTime.utc(2026, 3, 2);

Future<void> _pumpScreen(
  WidgetTester tester, {
  required FakeListingsRepository listings,
  FakeFavouritesRepository? favourites,
  TenantRuntimeConfig? config,
  Locale locale = const Locale('en'),
  bool settle = true,
}) async {
  final runtimeConfig = config ?? createTestConfig();

  await tester.pumpWidget(
    ProviderScope(
      retry: (_, _) => null,
      overrides: [
        guestCalendarTodayProvider.overrideWithValue(_today),
        runtimeConfigProvider.overrideWith((ref) => runtimeConfig),
        authControllerProvider.overrideWith(
          () => FakeAuthController(initialUser: testClient),
        ),
        listingsRepositoryProvider.overrideWithValue(listings),
        favouritesRepositoryProvider.overrideWithValue(
          favourites ?? FakeFavouritesRepository(),
        ),
      ],
      child: MaterialApp(
        locale: locale,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        theme: buildTenantTheme(
          runtimeConfig.theme.light,
          brightness: Brightness.light,
        ),
        home: const ListingDetailScreen(listingId: _listingId),
      ),
    ),
  );
  if (settle) await tester.pumpAndSettle();
}

Future<void> _scrollToCalendar(WidgetTester tester) async {
  await tester.ensureVisible(find.byType(AppDateRangeCalendar));
  await tester.pumpAndSettle();
}

TextDecoration? _decorationOfDay(WidgetTester tester, int day) {
  return tester
      .widget<Text>(
        find.descendant(
          of: find.byType(AppDateRangeCalendar),
          matching: find.text('$day'),
        ),
      )
      .style
      ?.decoration;
}

void main() {
  final l10n = AppLocalizationsEn();

  testWidgets('shows the listing details in the app language', (tester) async {
    final listings = FakeListingsRepository(listings: [_listing]);

    await _pumpScreen(tester, listings: listings);

    expect(find.text('Stays · Lucerne, CH'), findsOneWidget);
    expect(find.text('Sunlit Quarters in Lucerne'), findsOneWidget);
    expect(find.text('Apartment'), findsOneWidget);
    expect(find.text('4.50'), findsOneWidget);
    expect(find.text('10 reviews'), findsOneWidget);
    expect(find.text('Lucerne, CH'), findsOneWidget);
    expect(
      find.text('2 guests · 1 bedroom · 1 bed · 1 bathroom'),
      findsOneWidget,
    );
    expect(find.text('A test listing.'), findsOneWidget);
    expect(find.text('Wi-Fi'), findsOneWidget);
    expect(find.text('Hot tub'), findsOneWidget);
    expect(find.text('Rooftop Cinema'), findsOneWidget);
    expect(listings.listingRequests.single, (id: _listingId, language: 'en'));
  });

  testWidgets('requests the listing in German for a German UI', (tester) async {
    final listings = FakeListingsRepository(listings: [_listing]);

    await _pumpScreen(tester, listings: listings, locale: const Locale('de'));

    expect(find.text('Unterkünfte · Lucerne, CH'), findsOneWidget);
    expect(listings.listingRequests.single.language, 'de');
  });

  testWidgets('marks a listing without reviews as new', (tester) async {
    final listings = FakeListingsRepository(
      listings: [_listing.copyWith(reviewsCount: 0, rating: 0)],
    );

    await _pumpScreen(tester, listings: listings);

    expect(find.text(l10n.chipNoRatingText), findsOneWidget);
    expect(find.text('0.00'), findsNothing);
    expect(find.text(l10n.listingDetailReviews(0)), findsNothing);
  });

  testWidgets('pages through the photos', (tester) async {
    await _pumpScreen(
      tester,
      listings: FakeListingsRepository(listings: [_listing]),
    );

    expect(
      find.bySemanticsLabel('Sunlit Quarters in Lucerne, photo 1 of 2'),
      findsOneWidget,
    );

    await tester.drag(
      find.descendant(
        of: find.byType(ListingDetailImageCarousel),
        matching: find.byType(PageView),
      ),
      const Offset(-500, 0),
    );
    await tester.pumpAndSettle();

    expect(
      find.bySemanticsLabel('Sunlit Quarters in Lucerne, photo 2 of 2'),
      findsOneWidget,
    );
  });

  testWidgets('shows a localized error and retries', (tester) async {
    final listings = FakeListingsRepository(
      listings: [_listing],
      listingFailure: const ApiFailure(type: ApiFailureType.network),
    );

    await _pumpScreen(tester, listings: listings);

    expect(find.text(l10n.listingDetailErrorTitle), findsOneWidget);
    expect(find.text(l10n.listingsErrorNetwork), findsOneWidget);

    listings.listingFailure = null;
    await tester.tap(find.widgetWithText(FilledButton, l10n.retry));
    await tester.pumpAndSettle();

    expect(find.text('Sunlit Quarters in Lucerne'), findsOneWidget);
  });

  testWidgets('explains a missing listing without offering a retry', (
    tester,
  ) async {
    await _pumpScreen(tester, listings: FakeListingsRepository());

    expect(find.text(l10n.listingDetailNotFoundTitle), findsOneWidget);
    expect(find.text(l10n.listingDetailNotFoundMessage), findsOneWidget);
    expect(find.text(l10n.retry), findsNothing);
  });

  testWidgets('saves and removes the listing from favourites', (tester) async {
    final favourites = FakeFavouritesRepository();
    await _pumpScreen(
      tester,
      listings: FakeListingsRepository(listings: [_listing]),
      favourites: favourites,
    );

    await tester.tap(find.byTooltip(l10n.favouriteAdd));
    await tester.pumpAndSettle();

    expect(favourites.added, [_listingId]);
    expect(find.byTooltip(l10n.favouriteRemove), findsOneWidget);
    expect(find.byIcon(Icons.favorite), findsOneWidget);

    await tester.tap(find.byTooltip(l10n.favouriteRemove));
    await tester.pumpAndSettle();

    expect(favourites.removed, [_listingId]);
    expect(find.byTooltip(l10n.favouriteAdd), findsOneWidget);
  });

  testWidgets('reports a failed favourite update and restores the icon', (
    tester,
  ) async {
    final favourites = FakeFavouritesRepository()
      ..updateFailures[_listingId] = const ApiFailure(
        type: ApiFailureType.network,
      );
    await _pumpScreen(
      tester,
      listings: FakeListingsRepository(listings: [_listing]),
      favourites: favourites,
    );

    await tester.tap(find.byTooltip(l10n.favouriteAdd));
    await tester.pumpAndSettle();

    expect(find.text(l10n.favouritesUpdateError), findsOneWidget);
    expect(find.byTooltip(l10n.favouriteAdd), findsOneWidget);
  });

  testWidgets('retries loading favourites that failed to load', (tester) async {
    final favourites = FakeFavouritesRepository(
      fetchFailure: const ApiFailure(type: ApiFailureType.network),
    );
    await _pumpScreen(
      tester,
      listings: FakeListingsRepository(listings: [_listing]),
      favourites: favourites,
    );

    favourites.fetchFailure = null;
    await tester.tap(find.byTooltip(l10n.favouriteAdd));
    await tester.pumpAndSettle();

    expect(find.text(l10n.favouritesLoadError), findsOneWidget);
    expect(favourites.fetchRequests, 2);
    expect(favourites.added, isEmpty);
  });

  testWidgets('hides favourites when the tenant turns them off', (
    tester,
  ) async {
    final favourites = FakeFavouritesRepository();
    await _pumpScreen(
      tester,
      listings: FakeListingsRepository(listings: [_listing]),
      favourites: favourites,
      config: createTestConfig(
        permissions: const TenantPermissions(
          hostPanel: true,
          favourites: false,
          reviews: true,
          blockedDays: true,
        ),
      ),
    );

    expect(find.byTooltip(l10n.favouriteAdd), findsNothing);
    expect(favourites.fetchRequests, 0);
  });

  group('availability', () {
    testWidgets('asks for a year from today and strikes through taken days', (
      tester,
    ) async {
      final listings = FakeListingsRepository(
        listings: [_listing],
        bookings: {
          _listingId: [
            StayDates(
              checkIn: DateTime.utc(2026, 3, 4),
              checkOut: DateTime.utc(2026, 3, 6),
            ),
          ],
        },
        blockedDays: {
          _listingId: [DateTime.utc(2026, 3, 10)],
        },
      );

      await _pumpScreen(tester, listings: listings);
      await _scrollToCalendar(tester);

      expect(find.text(l10n.listingAvailabilityTitle), findsOneWidget);
      expect(find.text('March 2026'), findsOneWidget);
      expect(listings.availabilityRequests.single, (
        id: _listingId,
        from: DateTime.utc(2026, 3, 2),
        to: DateTime.utc(2027, 3, 3),
      ));
      for (final day in [4, 5, 10]) {
        expect(_decorationOfDay(tester, day), TextDecoration.lineThrough);
      }
      expect(
        _decorationOfDay(tester, 6),
        isNot(TextDecoration.lineThrough),
        reason: 'check-out day',
      );
      expect(_decorationOfDay(tester, 3), isNot(TextDecoration.lineThrough));
      expect(
        tester.getSemantics(find.bySemanticsLabel('Wednesday, March 4, 2026')),
        isSemantics(value: l10n.availabilityLegendTaken),
      );
      for (final label in [
        l10n.availabilityLegendAvailable,
        l10n.availabilityLegendTaken,
        l10n.availabilityLegendToday,
      ]) {
        expect(find.text(label), findsOneWidget);
      }
    });

    testWidgets('dims the calendar until the taken days arrive', (
      tester,
    ) async {
      final listings = FakeListingsRepository(
        listings: [_listing],
        bookings: {
          _listingId: [
            StayDates(
              checkIn: DateTime.utc(2026, 3, 4),
              checkOut: DateTime.utc(2026, 3, 5),
            ),
          ],
        },
      )..pendingAvailability = Completer<void>();

      await _pumpScreen(tester, listings: listings, settle: false);
      await tester.pump();
      await tester.pump(Durations.medium2);

      final opacity = find.ancestor(
        of: find.byType(AppDateRangeCalendar),
        matching: find.byType(AnimatedOpacity),
      );
      expect(tester.widget<AnimatedOpacity>(opacity).opacity, lessThan(1));
      expect(_decorationOfDay(tester, 4), isNot(TextDecoration.lineThrough));

      listings.pendingAvailability!.complete();
      await tester.pumpAndSettle();

      expect(tester.widget<AnimatedOpacity>(opacity).opacity, 1);
      expect(_decorationOfDay(tester, 4), TextDecoration.lineThrough);
    });

    testWidgets('keeps the listing on screen when availability fails', (
      tester,
    ) async {
      final listings = FakeListingsRepository(
        listings: [_listing],
        availabilityFailure: const ApiFailure(type: ApiFailureType.network),
      );

      await _pumpScreen(tester, listings: listings);

      expect(find.text('Sunlit Quarters in Lucerne'), findsOneWidget);
      expect(find.text(l10n.listingAvailabilityError), findsOneWidget);
      expect(find.byType(AppDateRangeCalendar), findsNothing);

      listings.availabilityFailure = null;
      await tester.ensureVisible(find.widgetWithText(TextButton, l10n.retry));
      await tester.tap(find.widgetWithText(TextButton, l10n.retry));
      await tester.pumpAndSettle();

      expect(find.text(l10n.listingAvailabilityError), findsNothing);
      expect(find.byType(AppDateRangeCalendar), findsOneWidget);
      expect(listings.availabilityRequests, hasLength(2));
    });
  });
}
