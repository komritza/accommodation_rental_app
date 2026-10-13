import 'package:accommodation_core/accommodation_core.dart';
import 'package:accommodation_core/testing.dart';
import 'package:accommodation_features/dependencies.dart';
import 'package:accommodation_features/host_blocked_days.dart';
import 'package:accommodation_features/listings.dart';
import 'package:accommodation_features/src/common/guest_calendar.dart';
import 'package:accommodation_features/testing.dart';
import 'package:accommodation_ui/accommodation_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

const _listingId = 'lst_1';

DateTime _day(int day) => DateTime.utc(2026, 3, day);

Future<void> _pumpScreen(
  WidgetTester tester, {
  required FakeListingsRepository listings,
  TenantRuntimeConfig? config,
}) async {
  final runtimeConfig = config ?? createTestConfig();
  tester.view.physicalSize = const Size(800, 1200);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);

  await tester.pumpWidget(
    ProviderScope(
      retry: (_, _) => null,
      overrides: [
        guestCalendarTodayProvider.overrideWithValue(_day(2)),
        runtimeConfigProvider.overrideWith((ref) => runtimeConfig),
        listingsRepositoryProvider.overrideWithValue(listings),
      ],
      child: MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        theme: buildTenantTheme(
          runtimeConfig.theme.light,
          brightness: Brightness.light,
        ),
        home: const HostBlockedDaysScreen(listingId: _listingId),
      ),
    ),
  );
  await tester.pumpAndSettle();
}

FakeListingsRepository _repository() {
  return FakeListingsRepository(
    bookings: {
      _listingId: [StayDates(checkIn: _day(5), checkOut: _day(7))],
    },
    blockedDays: {
      _listingId: [_day(10)],
    },
  );
}

Finder _calendarDay(int day) => find.descendant(
  of: find.byType(AppDateRangeCalendar),
  matching: find.text('$day'),
);

Color? _fillOf(WidgetTester tester, int day) {
  final ink = tester.widget<Ink>(
    find.ancestor(of: _calendarDay(day), matching: find.byType(Ink)),
  );
  return (ink.decoration! as ShapeDecoration).color;
}

ButtonStyleButton _button(WidgetTester tester, String label) {
  return tester.widget<ButtonStyleButton>(
    find.ancestor(
      of: find.text(label),
      matching: find.byWidgetPredicate((widget) => widget is ButtonStyleButton),
    ),
  );
}

void main() {
  final l10n = AppLocalizationsEn();

  testWidgets('paints booked and blocked days in their own colours', (
    tester,
  ) async {
    await _pumpScreen(tester, listings: _repository());

    final scheme = Theme.of(
      tester.element(find.byType(AppDateRangeCalendar)),
    ).colorScheme;
    expect(_fillOf(tester, 5), scheme.errorContainer);
    expect(_fillOf(tester, 6), scheme.errorContainer);
    expect(_fillOf(tester, 7), isNull);
    expect(_fillOf(tester, 10), scheme.tertiaryContainer);
    expect(
      tester.getSemantics(find.bySemanticsLabel('Thursday, March 5, 2026')),
      isSemantics(value: l10n.hostBlockedDaysBookedLabel, isEnabled: false),
    );
    expect(
      tester.getSemantics(find.bySemanticsLabel('Tuesday, March 10, 2026')),
      isSemantics(value: l10n.hostBlockedDaysBlockedLabel, isEnabled: true),
    );
  });

  testWidgets('does not let a booked day be selected', (tester) async {
    final listings = _repository();
    await _pumpScreen(tester, listings: listings);

    await tester.tap(_calendarDay(5));
    await tester.pumpAndSettle();

    expect(_button(tester, l10n.hostBlockedDaysBlockButton).onPressed, isNull);
    expect(find.text(l10n.hostBlockedDaysUnblockButton), findsNothing);
  });

  testWidgets('blocks a range and skips the booked days inside it', (
    tester,
  ) async {
    final listings = _repository();
    await _pumpScreen(tester, listings: listings);

    await tester.tap(_calendarDay(4));
    await tester.tap(_calendarDay(8));
    await tester.pumpAndSettle();
    await tester.tap(find.text(l10n.hostBlockedDaysBlockButton));
    await tester.pumpAndSettle();

    expect(listings.blockRequests, [_day(4), _day(7), _day(8)]);
    final scheme = Theme.of(
      tester.element(find.byType(AppDateRangeCalendar)),
    ).colorScheme;
    expect(_fillOf(tester, 4), scheme.tertiaryContainer);
    expect(_fillOf(tester, 8), scheme.tertiaryContainer);
    expect(_button(tester, l10n.hostBlockedDaysBlockButton).onPressed, isNull);
  });

  testWidgets('unblocks a blocked day', (tester) async {
    final listings = _repository();
    await _pumpScreen(tester, listings: listings);

    await tester.tap(_calendarDay(10));
    await tester.pumpAndSettle();
    await tester.tap(find.text(l10n.hostBlockedDaysUnblockButton));
    await tester.pumpAndSettle();

    expect(listings.unblockRequests, [_day(10)]);
    expect(_fillOf(tester, 10), isNull);
    expect(find.text(l10n.hostBlockedDaysUnblockButton), findsNothing);
  });

  testWidgets('keeps the selection and explains a failed unblock', (
    tester,
  ) async {
    final listings = _repository()
      ..unblockFailure = const ApiFailure(type: ApiFailureType.network);
    await _pumpScreen(tester, listings: listings);

    await tester.tap(_calendarDay(10));
    await tester.pumpAndSettle();
    await tester.tap(find.text(l10n.hostBlockedDaysUnblockButton));
    await tester.pumpAndSettle();

    expect(find.text(l10n.hostBlockedDaysActionError), findsOneWidget);
    expect(find.text(l10n.hostBlockedDaysUnblockButton), findsOneWidget);
  });

  testWidgets('offers a retry when the calendar fails to load', (tester) async {
    final listings = _repository()
      ..blockedDaysFailure = const ApiFailure(type: ApiFailureType.network);
    await _pumpScreen(tester, listings: listings);

    expect(find.text(l10n.hostBlockedDaysLoadError), findsOneWidget);

    listings.blockedDaysFailure = null;
    await tester.tap(find.text(l10n.retry));
    await tester.pumpAndSettle();

    expect(find.byType(AppDateRangeCalendar), findsOneWidget);
  });

  testWidgets('stays closed when the tenant turns blocking off', (
    tester,
  ) async {
    await _pumpScreen(
      tester,
      listings: _repository(),
      config: createTestConfig(
        permissions: const TenantPermissions(
          hostPanel: true,
          favourites: true,
          reviews: true,
          blockedDays: false,
        ),
      ),
    );

    expect(find.text(l10n.hostBlockedDaysNotAvailable), findsOneWidget);
    expect(find.byType(AppDateRangeCalendar), findsNothing);
  });
}
