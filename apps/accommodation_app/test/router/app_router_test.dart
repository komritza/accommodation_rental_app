import 'package:accommodation_app/router/app_router.dart';
import 'package:accommodation_app/screens/loading_screen.dart';
import 'package:accommodation_app/screens/route_not_found_screen.dart';
import 'package:accommodation_app/screens/session_restore_error_screen.dart';
import 'package:accommodation_core/accommodation_core.dart';
import 'package:accommodation_core/testing.dart';
import 'package:accommodation_features/auth.dart';
import 'package:accommodation_features/dependencies.dart';
import 'package:accommodation_features/favourites.dart';
import 'package:accommodation_features/guest_home.dart';
import 'package:accommodation_features/host_blocked_days.dart';
import 'package:accommodation_features/host_bookings.dart';
import 'package:accommodation_features/host_edit_listing.dart';
import 'package:accommodation_features/host_home.dart';
import 'package:accommodation_features/host_listing_detail.dart';
import 'package:accommodation_features/listing_detail.dart';
import 'package:accommodation_features/listings.dart';
import 'package:accommodation_features/profile.dart';
import 'package:accommodation_features/testing.dart';
import 'package:accommodation_ui/accommodation_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

Widget _wrap(
  ProviderContainer container, {
  required TenantRuntimeConfig config,
}) {
  return UncontrolledProviderScope(
    container: container,
    child: MaterialApp.router(
      locale: const Locale('en'),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: buildTenantTheme(config.theme.light, brightness: Brightness.light),
      routerConfig: container.read(appRouterProvider),
    ),
  );
}

ProviderContainer _container(
  AuthController Function() createController, {
  TenantRuntimeConfig? config,
}) {
  final runtimeConfig = config ?? createTestConfig();

  return ProviderContainer(
    retry: (_, _) => null,
    overrides: [
      tenantSlugProvider.overrideWith((ref) => TenantSlug.alpine),
      runtimeConfigProvider.overrideWith((ref) => runtimeConfig),
      authControllerProvider.overrideWith(createController),
      listingsRepositoryProvider.overrideWithValue(
        FakeListingsRepository(
          listings: [createTestListing()],
          hostListings: [createTestListing()],
        ),
      ),
      favouritesRepositoryProvider.overrideWithValue(
        FakeFavouritesRepository(),
      ),
    ],
  );
}

void main() {
  final l10n = AppLocalizationsEn();

  testWidgets('does not send the user to auth while session restore loads', (
    tester,
  ) async {
    final config = createTestConfig();
    final container = _container(LoadingAuthController.new);
    addTearDown(container.dispose);

    await tester.pumpWidget(_wrap(container, config: config));
    await tester.pump();

    expect(find.byType(LoadingScreen), findsOneWidget);
    expect(find.byType(AuthScreen), findsNothing);
  });

  testWidgets('shows the restore error instead of signing the user out', (
    tester,
  ) async {
    final config = createTestConfig();
    final container = _container(
      () => FakeAuthController(
        restoreError: const AuthSessionRestoreException(
          ApiFailure(type: ApiFailureType.network),
        ),
      ),
    );
    addTearDown(container.dispose);

    await tester.pumpWidget(_wrap(container, config: config));
    await tester.pumpAndSettle();

    expect(find.byType(SessionRestoreErrorScreen), findsOneWidget);
    expect(find.text(l10n.sessionRestoreErrorTitle), findsOneWidget);
    expect(find.byType(AuthScreen), findsNothing);
  });

  testWidgets('sends a signed-out user to the authentication screen', (
    tester,
  ) async {
    final config = createTestConfig();
    final container = _container(() => FakeAuthController());
    addTearDown(container.dispose);

    await tester.pumpWidget(_wrap(container, config: config));
    await tester.pumpAndSettle();

    expect(find.byType(AuthScreen), findsOneWidget);
  });

  testWidgets('sends a client to the guest home with guest tabs', (
    tester,
  ) async {
    final config = createTestConfig();
    final container = _container(
      () => FakeAuthController(initialUser: testClient),
    );
    addTearDown(container.dispose);

    await tester.pumpWidget(_wrap(container, config: config));
    await tester.pumpAndSettle();

    expect(find.byType(GuestHomeScreen), findsOneWidget);
    expect(find.byType(HostHomeScreen), findsNothing);
    final navigation = find.byType(NavigationBar);
    for (final label in [
      l10n.guestNavExplore,
      l10n.guestNavSaved,
      l10n.guestNavProfile,
    ]) {
      expect(
        find.descendant(of: navigation, matching: find.text(label)),
        findsOneWidget,
      );
    }
  });

  testWidgets('switches between guest tabs', (tester) async {
    final config = createTestConfig();
    final container = _container(
      () => FakeAuthController(initialUser: testClient),
    );
    addTearDown(container.dispose);

    await tester.pumpWidget(_wrap(container, config: config));
    await tester.pumpAndSettle();

    await tester.tap(find.text(l10n.guestNavSaved));
    await tester.pumpAndSettle();
    expect(find.byType(FavouritesScreen), findsOneWidget);

    await tester.tap(find.text(l10n.guestNavExplore));
    await tester.pumpAndSettle();
    expect(find.byType(GuestHomeScreen), findsOneWidget);
  });

  testWidgets('removes the saved tab and route when favourites are off', (
    tester,
  ) async {
    final config = createTestConfig(
      permissions: const TenantPermissions(
        hostPanel: true,
        favourites: false,
        reviews: false,
        blockedDays: true,
      ),
    );
    final container = _container(
      () => FakeAuthController(initialUser: testClient),
      config: config,
    );
    addTearDown(container.dispose);

    await tester.pumpWidget(_wrap(container, config: config));
    await tester.pumpAndSettle();

    expect(find.text(l10n.guestNavSaved), findsNothing);
    expect(find.text(l10n.guestNavProfile), findsOneWidget);

    container.read(appRouterProvider).go(AppRoutePaths.clientSaved);
    await tester.pumpAndSettle();
    expect(find.byType(FavouritesScreen), findsNothing);

    container.read(appRouterProvider).go(AppRoutePaths.clientSaved);
    await tester.pumpAndSettle();
    expect(find.byType(FavouritesScreen), findsNothing);
    expect(find.byType(RouteNotFoundScreen), findsOneWidget);
    await tester.tap(find.text(l10n.routeNotFoundAction));
    await tester.pumpAndSettle();
    expect(find.byType(GuestHomeScreen), findsOneWidget);
  });
  testWidgets('opens a listing from the guest home and goes back', (
    tester,
  ) async {
    final config = createTestConfig();
    final container = _container(
      () => FakeAuthController(initialUser: testClient),
    );
    addTearDown(container.dispose);

    await tester.pumpWidget(_wrap(container, config: config));
    await tester.pumpAndSettle();

    final card = find.bySemanticsLabel(RegExp('^Sunlit Quarters in Lucerne'));
    await tester.ensureVisible(card);
    await tester.pumpAndSettle();
    await tester.tap(card);
    await tester.pumpAndSettle();

    expect(find.byType(ListingDetailScreen), findsOneWidget);
    expect(find.text('Stays · Lucerne, CH'), findsOneWidget);
    expect(find.byType(NavigationBar), findsNothing);

    await tester.tap(find.byType(BackButton));
    await tester.pumpAndSettle();

    expect(find.byType(GuestHomeScreen), findsOneWidget);
  });

  testWidgets('sends a host to the host home page', (tester) async {
    final config = createTestConfig();
    final container = _container(
      () => FakeAuthController(initialUser: testHost),
    );
    addTearDown(container.dispose);

    await tester.pumpWidget(_wrap(container, config: config));
    await tester.pumpAndSettle();

    expect(find.byType(HostHomeScreen), findsOneWidget);
    expect(find.text(l10n.hostHomeTitle), findsOneWidget);
  });

  testWidgets('redirects a client away from the host destination', (
    tester,
  ) async {
    final config = createTestConfig();
    final container = _container(
      () => FakeAuthController(initialUser: testClient),
    );
    addTearDown(container.dispose);

    await tester.pumpWidget(_wrap(container, config: config));
    await tester.pumpAndSettle();

    container.read(appRouterProvider).go(AppRoutePaths.hostHome);
    await tester.pumpAndSettle();

    expect(find.byType(GuestHomeScreen), findsOneWidget);
    expect(find.byType(HostHomeScreen), findsNothing);
  });

  testWidgets('keeps a host out of the guest area', (tester) async {
    final config = createTestConfig();
    final container = _container(
      () => FakeAuthController(initialUser: testHost),
    );
    addTearDown(container.dispose);

    await tester.pumpWidget(_wrap(container, config: config));
    await tester.pumpAndSettle();

    container.read(appRouterProvider).go(AppRoutePaths.clientProfile);
    await tester.pumpAndSettle();

    expect(find.byType(HostHomeScreen), findsOneWidget);
    expect(find.byType(ProfileScreen), findsNothing);
    expect(find.byType(NavigationBar), findsNothing);
  });

  testWidgets('takes a host from a listing to its blocked days and bookings', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(800, 1200);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    final config = createTestConfig();
    final container = _container(
      () => FakeAuthController(initialUser: testHost),
    );
    addTearDown(container.dispose);

    await tester.pumpWidget(_wrap(container, config: config));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Sunlit Quarters in Lucerne'));
    await tester.pumpAndSettle();
    expect(find.byType(HostListingDetailScreen), findsOneWidget);

    await tester.tap(find.text(l10n.hostBlockedDaysManageButton));
    await tester.pumpAndSettle();
    expect(find.byType(HostBlockedDaysScreen), findsOneWidget);

    await tester.tap(find.byType(BackButton));
    await tester.pumpAndSettle();
    await tester.tap(find.text(l10n.hostBookingsButton));
    await tester.pumpAndSettle();
    expect(find.byType(HostBookingsScreen), findsOneWidget);

    await tester.tap(find.byType(BackButton));
    await tester.pumpAndSettle();
    await tester.tap(find.text(l10n.hostListingDetailEditButton));
    await tester.pumpAndSettle();
    expect(find.byType(HostEditListingScreen), findsOneWidget);
  });

  testWidgets('drops the blocked days route when the tenant turns it off', (
    tester,
  ) async {
    final config = createTestConfig(
      permissions: const TenantPermissions(
        hostPanel: true,
        favourites: true,
        reviews: true,
        blockedDays: false,
      ),
    );
    final container = _container(
      () => FakeAuthController(initialUser: testHost),
      config: config,
    );
    addTearDown(container.dispose);

    await tester.pumpWidget(_wrap(container, config: config));
    await tester.pumpAndSettle();

    container
        .read(appRouterProvider)
        .go(AppRoutePaths.hostListingDetail('lst_00001'));
    await tester.pumpAndSettle();
    expect(find.byType(HostListingDetailScreen), findsOneWidget);
    expect(find.text(l10n.hostBlockedDaysManageButton), findsNothing);

    container
        .read(appRouterProvider)
        .go(AppRoutePaths.hostBlockedDays('lst_00001'));
    await tester.pumpAndSettle();
    expect(find.byType(HostBlockedDaysScreen), findsNothing);
    expect(find.byType(RouteNotFoundScreen), findsOneWidget);
  });

  testWidgets('keeps a client out of the host listing routes', (tester) async {
    final config = createTestConfig();
    final container = _container(
      () => FakeAuthController(initialUser: testClient),
    );
    addTearDown(container.dispose);

    await tester.pumpWidget(_wrap(container, config: config));
    await tester.pumpAndSettle();

    for (final path in [
      AppRoutePaths.hostListingDetail('lst_00001'),
      AppRoutePaths.hostListingDetailEdit('lst_00001'),
      AppRoutePaths.hostBlockedDays('lst_00001'),
      AppRoutePaths.hostBookings('lst_00001'),
      AppRoutePaths.hostProfile,
    ]) {
      container.read(appRouterProvider).go(path);
      await tester.pumpAndSettle();

      expect(find.byType(GuestHomeScreen), findsOneWidget, reason: path);
      expect(find.byType(HostListingDetailScreen), findsNothing);
      expect(find.byType(HostEditListingScreen), findsNothing);
      expect(find.byType(HostBlockedDaysScreen), findsNothing);
    }
  });

  testWidgets('lets a host open the profile and sign out', (tester) async {
    final config = createTestConfig();
    final container = _container(
      () => FakeAuthController(initialUser: testHost),
    );
    addTearDown(container.dispose);

    await tester.pumpWidget(_wrap(container, config: config));
    await tester.pumpAndSettle();

    await tester.tap(find.byTooltip(l10n.hostHomeProfileTooltip));
    await tester.pumpAndSettle();
    expect(find.byType(ProfileScreen), findsOneWidget);
    expect(find.text('Nina Brunner'), findsOneWidget);

    await tester.tap(find.text(l10n.signOut));
    await tester.pumpAndSettle();
    expect(find.byType(AuthScreen), findsOneWidget);
  });

  testWidgets('shows the not found screen for an unknown guest path', (
    tester,
  ) async {
    final container = _container(
      () => FakeAuthController(initialUser: testClient),
    );

    addTearDown(container.dispose);

    await tester.pumpWidget(_wrap(container, config: createTestConfig()));
    await tester.pumpAndSettle();

    container.read(appRouterProvider).go('/client/does-not-exist');
    await tester.pumpAndSettle();

    expect(find.byType(RouteNotFoundScreen), findsOneWidget);
  });
}
