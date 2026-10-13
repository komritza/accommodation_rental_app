import 'dart:async';

import 'package:accommodation_core/accommodation_core.dart';
import 'package:accommodation_core/testing.dart';
import 'package:accommodation_features/auth.dart';
import 'package:accommodation_features/favourites.dart';
import 'package:accommodation_features/src/guest_home/guest_filter_labels.dart';
import 'package:accommodation_features/testing.dart';
import 'package:accommodation_ui/accommodation_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

const _failure = ApiFailure(type: ApiFailureType.network);

final _lucerne = createTestListing(id: 'a');
final _zermatt = createTestListing(
  id: 'b',
  title: 'Chalet below the Matterhorn',
  city: 'Zermatt',
);

Future<List<String>> _pumpScreen(
  WidgetTester tester, {
  required FakeFavouritesRepository favourites,
}) async {
  final opened = <String>[];
  final config = createTestConfig();

  await tester.pumpWidget(
    ProviderScope(
      retry: (_, _) => null,
      overrides: [
        authControllerProvider.overrideWith(
          () => FakeAuthController(initialUser: testClient),
        ),
        favouritesRepositoryProvider.overrideWithValue(favourites),
      ],
      child: MaterialApp(
        locale: const Locale('en'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        theme: buildTenantTheme(
          config.theme.light,
          brightness: Brightness.light,
        ),
        home: FavouritesScreen(onListingPressed: opened.add),
      ),
    ),
  );
  await tester.pumpAndSettle();

  return opened;
}

void main() {
  final l10n = AppLocalizationsEn();

  testWidgets('shows the image, name, location, price and rating', (
    tester,
  ) async {
    await _pumpScreen(
      tester,
      favourites: FakeFavouritesRepository(favourites: [_lucerne]),
    );

    expect(find.text(l10n.favouritesTitle), findsOneWidget);
    expect(find.text(_lucerne.title), findsOneWidget);
    expect(find.text(l10n.listingLocation('Lucerne', 'CH')), findsOneWidget);
    expect(find.text('4.50'), findsOneWidget);
    expect(
      find.textContaining(
        formatGuestPrice(173, currencyCode: 'CHF', locale: 'en'),
        findRichText: true,
      ),
      findsOneWidget,
    );
  });

  testWidgets('shows an empty state without saved stays', (tester) async {
    await _pumpScreen(tester, favourites: FakeFavouritesRepository());

    expect(find.text(l10n.favouritesEmptyTitle), findsOneWidget);
    expect(find.text(l10n.favouritesEmptyMessage), findsOneWidget);
  });

  testWidgets('opens a saved listing', (tester) async {
    final opened = await _pumpScreen(
      tester,
      favourites: FakeFavouritesRepository(favourites: [_lucerne]),
    );

    await tester.tap(find.text(_lucerne.title));

    expect(opened, ['a']);
  });

  testWidgets('removes a listing from favourites right away', (tester) async {
    final favourites = FakeFavouritesRepository(
      favourites: [_lucerne, _zermatt],
    );
    final pending = favourites.pendingUpdates['a'] = Completer<void>();
    await _pumpScreen(tester, favourites: favourites);

    await tester.tap(find.byTooltip(l10n.favouriteRemove).first);
    await tester.pump();

    expect(find.text(_lucerne.title), findsNothing);
    expect(find.text(_zermatt.title), findsOneWidget);

    pending.complete();
    await tester.pumpAndSettle();

    expect(favourites.removed, ['a']);
    expect(find.text(_lucerne.title), findsNothing);
  });

  testWidgets('shows the empty state after removing the last listing', (
    tester,
  ) async {
    await _pumpScreen(
      tester,
      favourites: FakeFavouritesRepository(favourites: [_lucerne]),
    );

    await tester.tap(find.byTooltip(l10n.favouriteRemove));
    await tester.pumpAndSettle();

    expect(find.text(l10n.favouritesEmptyTitle), findsOneWidget);
  });

  testWidgets('restores the listing when removing it fails', (tester) async {
    final favourites = FakeFavouritesRepository(favourites: [_lucerne])
      ..updateFailures['a'] = _failure;
    await _pumpScreen(tester, favourites: favourites);

    await tester.tap(find.byTooltip(l10n.favouriteRemove));
    await tester.pumpAndSettle();

    expect(find.text(l10n.favouritesUpdateError), findsOneWidget);
    expect(find.text(_lucerne.title), findsOneWidget);
  });

  testWidgets('retries loading favourites that failed to load', (tester) async {
    final favourites = FakeFavouritesRepository(
      favourites: [_lucerne],
      fetchFailure: _failure,
    );
    await _pumpScreen(tester, favourites: favourites);

    expect(find.text(l10n.favouritesLoadError), findsOneWidget);
    expect(find.text(l10n.listingsErrorNetwork), findsOneWidget);

    favourites.fetchFailure = null;
    await tester.tap(find.text(l10n.retry));
    await tester.pumpAndSettle();

    expect(find.text(_lucerne.title), findsOneWidget);
    expect(favourites.fetchRequests, 2);
  });
}
