import 'package:accommodation_core/accommodation_core.dart';
import 'package:accommodation_core/testing.dart';
import 'package:accommodation_features/host_edit_listing.dart';
import 'package:accommodation_features/listings.dart';
import 'package:accommodation_features/testing.dart';
import 'package:accommodation_ui/accommodation_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

const _listingId = 'lst_1';

Future<void> _pumpScreen(
  WidgetTester tester, {
  required FakeListingsRepository listings,
  VoidCallback? onSaved,
  Locale locale = const Locale('en'),
}) async {
  final config = createTestConfig();
  tester.view.physicalSize = const Size(800, 2400);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);

  await tester.pumpWidget(
    ProviderScope(
      retry: (_, _) => null,
      overrides: [listingsRepositoryProvider.overrideWithValue(listings)],
      child: MaterialApp(
        locale: locale,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        theme: buildTenantTheme(
          config.theme.light,
          brightness: Brightness.light,
        ),
        home: HostEditListingScreen(
          listingId: _listingId,
          onSaved: onSaved ?? () {},
        ),
      ),
    ),
  );
  await tester.pumpAndSettle();
}

FakeListingsRepository _repository() {
  final listing = createTestListing(id: _listingId);
  return FakeListingsRepository(listings: [listing], hostListings: [listing]);
}

Finder _field(String label) => find.widgetWithText(TextFormField, label);

void main() {
  final l10n = AppLocalizationsEn();

  testWidgets('saves only what changed and reports back', (tester) async {
    final listings = _repository();
    var saved = 0;
    await _pumpScreen(tester, listings: listings, onSaved: () => saved++);

    await tester.enterText(
      _field(l10n.hostEditListingPricePerNightField),
      '210,5',
    );
    await tester.tap(find.text('Wi-Fi'));
    await tester.pumpAndSettle();
    await tester.tap(find.text(l10n.hostEditListingSaveButton));
    await tester.pumpAndSettle();

    expect(listings.updateRequests.single.changes, {
      'pricePerNight': 210.5,
      'amenities': <String>[],
    });
    expect(saved, 1);
  });

  testWidgets('keeps save disabled until something changes', (tester) async {
    await _pumpScreen(tester, listings: _repository());

    final save = tester.widget<FilledButton>(
      find.widgetWithText(FilledButton, l10n.hostEditListingSaveButton),
    );
    expect(save.onPressed, isNull);
  });

  testWidgets('shows our wording, not the server message, when a save fails', (
    tester,
  ) async {
    final listings = _repository()
      ..updateFailure = const ApiFailure(
        type: ApiFailureType.http,
        statusCode: 400,
        messageCode: 'error.badRequest',
        message: 'Invalid payload',
      );
    var saved = 0;
    await _pumpScreen(tester, listings: listings, onSaved: () => saved++);

    await tester.enterText(_field(l10n.hostEditListingBedsField), '3');
    await tester.pump();
    await tester.tap(find.text(l10n.hostEditListingSaveButton));
    await tester.pumpAndSettle();

    expect(find.text(l10n.hostEditListingErrorRejected), findsOneWidget);
    expect(find.text('Invalid payload'), findsNothing);
    expect(saved, 0);
  });

  testWidgets('validates in the app language without sending anything', (
    tester,
  ) async {
    final listings = _repository();
    final german = lookupAppLocalizations(const Locale('de'));
    await _pumpScreen(tester, listings: listings, locale: const Locale('de'));

    await tester.enterText(_field(german.hostEditListingMaxGuestsField), '0');
    await tester.enterText(_field(german.hostEditListingTitleField), ' ');
    await tester.pumpAndSettle();

    expect(find.text(german.hostEditListingMinValue(1)), findsOneWidget);
    expect(find.text(german.hostEditListingFieldRequired), findsOneWidget);

    await tester.tap(find.text(german.hostEditListingSaveButton));
    await tester.pumpAndSettle();
    expect(listings.updateRequests, isEmpty);
  });

  testWidgets('offers the property types from the catalogue', (tester) async {
    final listings = _repository();
    await _pumpScreen(tester, listings: listings);

    await tester.tap(find.text('Apartment'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Chalet').last);
    await tester.pumpAndSettle();
    await tester.tap(find.text(l10n.hostEditListingSaveButton));
    await tester.pumpAndSettle();

    expect(listings.updateRequests.single.changes, {'propertyType': 'chalet'});
  });
}
