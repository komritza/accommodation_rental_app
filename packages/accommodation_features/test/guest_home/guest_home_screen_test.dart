import 'dart:async';

import 'package:accommodation_core/accommodation_core.dart';
import 'package:accommodation_core/testing.dart';
import 'package:accommodation_features/guest_home.dart';
import 'package:accommodation_features/listings.dart';
import 'package:accommodation_features/src/common/dependencies.dart';
import 'package:accommodation_features/src/common/guest_calendar.dart';
import 'package:accommodation_features/src/guest_home/guest_filter_draft.dart';
import 'package:accommodation_features/src/guest_home/widgets/guest_filters_sheet.dart';
import 'package:accommodation_features/src/guest_home/widgets/listing_card.dart';
import 'package:accommodation_features/testing.dart';
import 'package:accommodation_ui/accommodation_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

const _phoneSize = Size(390, 844);

final _today = DateTime.utc(2030, 3, 10);

Widget _wrap(
  FakeListingsRepository repository, {
  VoidCallback? onProfilePressed,
  ValueChanged<String>? onListingPressed,
  Brightness brightness = Brightness.light,
}) {
  final config = createTestConfig();
  final palette = brightness == Brightness.light
      ? config.theme.light
      : config.theme.dark;

  return ProviderScope(
    retry: (_, _) => null,
    overrides: [
      runtimeConfigProvider.overrideWith((ref) => config),
      listingsRepositoryProvider.overrideWithValue(repository),
      guestCalendarTodayProvider.overrideWithValue(_today),
    ],
    child: MaterialApp(
      locale: const Locale('en'),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: buildTenantTheme(palette, brightness: brightness),
      home: GuestHomeScreen(
        onProfilePressed: onProfilePressed ?? () {},
        onListingPressed: onListingPressed ?? (_) {},
      ),
    ),
  );
}

Future<void> _pumpScreen(
  WidgetTester tester,
  FakeListingsRepository repository, {
  Size size = _phoneSize,
  VoidCallback? onProfilePressed,
  ValueChanged<String>? onListingPressed,
}) async {
  tester.view.physicalSize = size;
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);

  await tester.pumpWidget(
    _wrap(
      repository,
      onProfilePressed: onProfilePressed,
      onListingPressed: onListingPressed,
    ),
  );
  await tester.pumpAndSettle();
}

Future<void> _openFiltersAndSettle(WidgetTester tester) async {
  await tester.tap(find.byTooltip('Filters'));
  await tester.pumpAndSettle();
  await tester.pump(guestFilterCountDebounce);
  await tester.pumpAndSettle();
}

Future<void> _tapInSheet(WidgetTester tester, Finder finder) async {
  await tester.scrollUntilVisible(
    finder,
    200,
    scrollable: find.descendant(
      of: find.byType(GuestFiltersSheet),
      matching: find.byWidgetPredicate(
        (widget) =>
            widget is Scrollable && widget.axisDirection == AxisDirection.down,
      ),
    ),
  );
  await tester.pumpAndSettle();
  await tester.tap(finder);
  await tester.pump();
}

void main() {
  final l10n = AppLocalizationsEn();

  final listings = [
    createTestListing(
      id: 'a',
      title: 'Sunlit Quarters in Lucerne',
      city: 'Lucerne',
      maxGuests: 1,
      pricePerNight: 173,
      bedrooms: 3,
      beds: 2,
      bathrooms: 2,
    ),
    createTestListing(
      id: 'b',
      title: 'Chalet Matterhorn View',
      city: 'Zermatt',
      maxGuests: 6,
      pricePerNight: 237,
      bedrooms: 4,
      beds: 4,
      bathrooms: 3,
    ),
  ];

  testWidgets('shows the tenant header, search summary and listing cards', (
    tester,
  ) async {
    await _pumpScreen(tester, FakeListingsRepository(listings: listings));

    expect(find.text('Alpine'), findsOneWidget);
    expect(find.text(l10n.guestHomeAnywhere), findsOneWidget);
    expect(find.text('Any dates · Add guests · Any price'), findsOneWidget);
    expect(find.text(l10n.guestHomeStayCount(2)), findsOneWidget);
    expect(find.text('Sunlit Quarters in Lucerne'), findsOneWidget);
    expect(find.text('1 guest'), findsOneWidget);
    expect(find.text('CHF\u00A0173 / night'), findsOneWidget);
    expect(find.text(l10n.guestHomeClearAll), findsNothing);
    expect(find.text('2 beds'), findsOneWidget);
    expect(find.text('3 bedrooms'), findsOneWidget);
    expect(find.text('2 bathrooms'), findsOneWidget);

    await tester.scrollUntilVisible(find.text(l10n.guestHomeEndOfResults), 300);
    expect(find.text(l10n.guestHomeEndOfResults), findsOneWidget);
  });

  testWidgets('shows a loading indicator until the first page arrives', (
    tester,
  ) async {
    final repository = FakeListingsRepository(listings: listings)
      ..pendingResponse = Completer<void>();

    tester.view.physicalSize = _phoneSize;
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(_wrap(repository));
    await tester.pump();

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(find.text('Sunlit Quarters in Lucerne'), findsNothing);

    repository.pendingResponse!.complete();
    await tester.pumpAndSettle();

    expect(find.text('Sunlit Quarters in Lucerne'), findsOneWidget);
  });

  testWidgets('shows a localized error and retries', (tester) async {
    final repository = FakeListingsRepository(
      listings: listings,
      listingsFailure: const ApiFailure(type: ApiFailureType.network),
    );

    await _pumpScreen(tester, repository);

    expect(find.text(l10n.guestHomeLoadErrorTitle), findsOneWidget);
    expect(find.text(l10n.listingsErrorNetwork), findsOneWidget);

    repository.listingsFailure = null;
    await tester.tap(find.widgetWithText(FilledButton, l10n.retry));
    await tester.pumpAndSettle();

    expect(find.text('Sunlit Quarters in Lucerne'), findsOneWidget);
  });

  testWidgets('shows the empty state without a clear action when unfiltered', (
    tester,
  ) async {
    await _pumpScreen(tester, FakeListingsRepository());

    expect(find.text(l10n.guestHomeStayCount(0)), findsOneWidget);
    expect(find.text(l10n.guestHomeNoResultsTitle), findsOneWidget);
    expect(find.text(l10n.guestHomeClearFilters), findsNothing);
  });

  testWidgets('applies filters from the sheet and removes them as chips', (
    tester,
  ) async {
    final repository = FakeListingsRepository(listings: listings);
    await _pumpScreen(tester, repository);

    await _openFiltersAndSettle(tester);
    expect(find.text(l10n.guestFiltersTitle), findsOneWidget);
    expect(find.text(l10n.guestFiltersShowStayCount(2)), findsOneWidget);

    await tester.tap(find.widgetWithText(AppChip, 'Zermatt'));
    await _tapInSheet(tester, find.byTooltip(l10n.guestFiltersMoreGuests));
    await tester.pump(guestFilterCountDebounce);
    await tester.pumpAndSettle();
    expect(find.text(l10n.guestFiltersShowStayCount(1)), findsOneWidget);

    await tester.tap(find.text(l10n.guestFiltersShowStayCount(1)));
    await tester.pumpAndSettle();

    expect(find.text(l10n.guestFiltersTitle), findsNothing);
    expect(find.text('Any dates · 2 guests · Any price'), findsOneWidget);
    expect(find.bySemanticsLabel('Remove filter Zermatt'), findsOneWidget);
    expect(find.text('Chalet Matterhorn View'), findsOneWidget);
    expect(find.text('Sunlit Quarters in Lucerne'), findsNothing);
    expect(repository.requests.last.query.city, 'Zermatt');
    expect(repository.requests.last.query.guests, 2);

    await tester.tap(find.bySemanticsLabel('Remove filter Zermatt'));
    await tester.pumpAndSettle();
    expect(find.text(l10n.guestHomeAnywhere), findsOneWidget);

    await tester.tap(find.text(l10n.guestHomeClearAll));
    await tester.pumpAndSettle();
    expect(find.text(l10n.guestHomeClearAll), findsNothing);
    expect(find.text('Sunlit Quarters in Lucerne'), findsOneWidget);
  });

  testWidgets('filters by a stay with an exclusive check-out', (tester) async {
    final repository = FakeListingsRepository(
      listings: listings,
      bookings: {
        'a': [
          StayDates(
            checkIn: DateTime(2030, 3, 15),
            checkOut: DateTime(2030, 3, 17),
          ),
        ],
      },
    );
    await _pumpScreen(tester, repository);

    await _openFiltersAndSettle(tester);
    expect(find.text(l10n.guestFiltersAddDate), findsNWidgets(2));
    expect(find.text(l10n.guestFiltersPickDates), findsOneWidget);
    expect(
      tester.getSemantics(find.bySemanticsLabel('Saturday, March 9, 2030')),
      isSemantics(hasEnabledState: true, isEnabled: false),
    );

    await tester.tap(find.bySemanticsLabel('Friday, March 15, 2030'));
    await tester.pump();
    expect(find.text('Fri, Mar 15'), findsOneWidget);
    expect(find.text(l10n.guestFiltersAddDate), findsOneWidget);

    await tester.tap(find.bySemanticsLabel('Sunday, March 17, 2030'));
    await tester.pump(guestFilterCountDebounce);
    await tester.pumpAndSettle();
    expect(find.text('Sun, Mar 17'), findsOneWidget);
    expect(find.text(l10n.guestFiltersNightsHint(2)), findsOneWidget);
    expect(find.text(l10n.guestFiltersShowStayCount(1)), findsOneWidget);

    await tester.tap(find.text(l10n.guestFiltersShowStayCount(1)));
    await tester.pumpAndSettle();

    expect(find.text('Mar 15–Mar 17 · Add guests · Any price'), findsOneWidget);
    expect(
      find.bySemanticsLabel('Remove filter Mar 15–Mar 17'),
      findsOneWidget,
    );
    expect(find.text('Sunlit Quarters in Lucerne'), findsNothing);
    expect(repository.requests.last.query.dates!.checkInIso, '2030-03-15');
    expect(repository.requests.last.query.dates!.checkOutIso, '2030-03-17');

    await tester.tap(find.bySemanticsLabel('Remove filter Mar 15–Mar 17'));
    await tester.pumpAndSettle();
    expect(find.text('Any dates · Add guests · Any price'), findsOneWidget);
    expect(find.text('Sunlit Quarters in Lucerne'), findsOneWidget);
  });

  testWidgets('discards sheet changes that were not applied', (tester) async {
    final repository = FakeListingsRepository(listings: listings);
    await _pumpScreen(tester, repository);

    await _openFiltersAndSettle(tester);
    await tester.tap(find.widgetWithText(AppChip, 'Zermatt'));
    await tester.tap(find.byTooltip(l10n.guestFiltersClose));
    await tester.pumpAndSettle();

    expect(find.text(l10n.guestHomeAnywhere), findsOneWidget);

    await _openFiltersAndSettle(tester);
    final anywhere = tester.widget<AppChip>(
      find.widgetWithText(AppChip, l10n.guestHomeAnywhere),
    );
    expect(anywhere.selected, isTrue);
  });

  testWidgets('offers to clear filters when nothing matches', (tester) async {
    final repository = FakeListingsRepository(listings: listings);
    await _pumpScreen(tester, repository);

    await _openFiltersAndSettle(tester);
    await tester.tap(find.widgetWithText(AppChip, 'Lucerne'));
    await _tapInSheet(tester, find.byTooltip(l10n.guestFiltersMoreGuests));
    await tester.tap(find.byType(FilledButton));
    await tester.pumpAndSettle();

    expect(find.text(l10n.guestHomeNoResultsTitle), findsOneWidget);

    await tester.tap(find.text(l10n.guestHomeClearFilters));
    await tester.pumpAndSettle();

    expect(find.text(l10n.guestHomeStayCount(2)), findsOneWidget);
  });

  testWidgets('loads the next page while scrolling', (tester) async {
    final repository = FakeListingsRepository(
      listings: [
        for (var i = 0; i < 12; i++)
          createTestListing(id: 'lst_$i', title: 'Stay $i'),
      ],
      pageSize: 5,
    );
    tester.view.physicalSize = _phoneSize;
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(_wrap(repository));
    await tester.pump();

    // The footer spinner animates while more pages exist, so this cannot
    // wait for the frame queue to settle.
    await tester.scrollUntilVisible(find.text('Stay 11'), 400);
    await tester.scrollUntilVisible(find.text(l10n.guestHomeEndOfResults), 400);

    expect(find.text('Stay 11'), findsOneWidget);
    expect(repository.requests.map((request) => request.cursor), [
      null,
      '5',
      '10',
    ]);
  });

  testWidgets('opens the profile from the header', (tester) async {
    var profileOpened = false;
    await _pumpScreen(
      tester,
      FakeListingsRepository(listings: listings),
      onProfilePressed: () => profileOpened = true,
    );

    await tester.tap(find.byTooltip(l10n.guestNavProfile));

    expect(profileOpened, isTrue);
  });

  testWidgets('opens the tapped listing', (tester) async {
    final opened = <String>[];
    await _pumpScreen(
      tester,
      FakeListingsRepository(listings: listings),
      onListingPressed: opened.add,
    );

    await tester.tap(
      find.widgetWithText(ListingCard, 'Sunlit Quarters in Lucerne'),
    );

    expect(opened, ['a']);
  });

  testWidgets('keeps content to a readable column on wide screens', (
    tester,
  ) async {
    await _pumpScreen(
      tester,
      FakeListingsRepository(listings: listings),
      size: const Size(1024, 1366),
    );

    final cardWidth = tester.getSize(find.byType(AppCoverImage).first).width;
    expect(cardWidth, AppLayoutTokens.contentMaxWidth - 2 * AppSpacing.md);
  });
}
