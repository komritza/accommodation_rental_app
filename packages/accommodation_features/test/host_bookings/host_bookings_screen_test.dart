import 'package:accommodation_core/accommodation_core.dart';
import 'package:accommodation_core/testing.dart';
import 'package:accommodation_features/host_bookings.dart';
import 'package:accommodation_features/listings.dart';
import 'package:accommodation_features/src/guest_home/guest_filter_labels.dart';
import 'package:accommodation_features/testing.dart';
import 'package:accommodation_ui/accommodation_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

const _listingId = 'lst_1';

Future<void> _pumpScreen(
  WidgetTester tester, {
  required FakeListingsRepository listings,
}) async {
  final config = createTestConfig();
  tester.view.physicalSize = const Size(800, 1200);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);

  await tester.pumpWidget(
    ProviderScope(
      retry: (_, _) => null,
      overrides: [listingsRepositoryProvider.overrideWithValue(listings)],
      child: MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        theme: buildTenantTheme(
          config.theme.light,
          brightness: Brightness.light,
        ),
        home: const HostBookingsScreen(listingId: _listingId),
      ),
    ),
  );
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('shows guest, stay, status and price of each booking', (
    tester,
  ) async {
    await _pumpScreen(
      tester,
      listings: FakeListingsRepository(
        hostBookings: {
          _listingId: [
            createTestBooking(
              guestName: 'Lena Graf',
              guests: 3,
              status: BookingStatus.pending,
              totalPrice: 406,
              currency: 'CHF',
            ),
          ],
        },
      ),
    );

    expect(find.text('1 booking'), findsOneWidget);
    expect(find.text('Lena Graf'), findsOneWidget);
    expect(find.text('Pending'), findsOneWidget);
    expect(find.textContaining('2 nights · 3 guests'), findsOneWidget);
    expect(
      find.text(formatGuestPrice(406, currencyCode: 'CHF', locale: 'en')),
      findsOneWidget,
    );
    expect(find.text('Load more'), findsNothing);
  });

  testWidgets('shows an empty state when the listing has no bookings', (
    tester,
  ) async {
    await _pumpScreen(tester, listings: FakeListingsRepository());

    expect(find.text('No bookings yet'), findsOneWidget);
  });

  testWidgets('loads the next page from the footer button', (tester) async {
    final listings = FakeListingsRepository(
      hostBookings: {
        _listingId: [
          for (var i = 0; i < 3; i++)
            createTestBooking(id: 'bkg_$i', guestName: 'Guest $i'),
        ],
      },
      pageSize: 2,
    );
    await _pumpScreen(tester, listings: listings);

    expect(find.text('3 bookings'), findsOneWidget);
    expect(find.text('Guest 2'), findsNothing);

    await tester.tap(find.text('Load more'));
    await tester.pumpAndSettle();

    expect(find.text('Guest 2'), findsOneWidget);
    expect(find.text('Load more'), findsNothing);
  });

  testWidgets('retries after the bookings fail to load', (tester) async {
    final listings = FakeListingsRepository(
      hostBookings: {
        _listingId: [createTestBooking(guestName: 'Lena Graf')],
      },
      hostBookingsFailure: const ApiFailure(type: ApiFailureType.network),
    );
    await _pumpScreen(tester, listings: listings);

    expect(find.text("Couldn't load bookings"), findsOneWidget);

    listings.hostBookingsFailure = null;
    await tester.tap(find.text('Retry'));
    await tester.pumpAndSettle();

    expect(find.text('Lena Graf'), findsOneWidget);
  });
}
