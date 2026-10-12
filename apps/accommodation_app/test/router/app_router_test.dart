import 'package:accommodation_app/router/app_router.dart';
import 'package:accommodation_app/screens/loading_screen.dart';
import 'package:accommodation_app/screens/placeholders/guest_saved_placeholder.dart';
import 'package:accommodation_app/screens/placeholders/role_home_placeholder.dart';
import 'package:accommodation_app/screens/route_not_found_screen.dart';
import 'package:accommodation_app/screens/session_restore_error_screen.dart';
import 'package:accommodation_core/accommodation_core.dart';
import 'package:accommodation_core/testing.dart';
import 'package:accommodation_features/auth.dart';
import 'package:accommodation_features/dependencies.dart';
import 'package:accommodation_features/guest_home.dart';
import 'package:accommodation_features/listings.dart';
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
        FakeListingsRepository(listings: [createTestListing()]),
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
    expect(find.byType(HostHomePlaceholder), findsNothing);
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
    expect(find.byType(GuestSavedPlaceholder), findsOneWidget);

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
    expect(find.byType(GuestSavedPlaceholder), findsNothing);

    container.read(appRouterProvider).go(AppRoutePaths.clientSaved);
    await tester.pumpAndSettle();
    expect(find.byType(GuestSavedPlaceholder), findsNothing);
    expect(find.byType(RouteNotFoundScreen), findsOneWidget);
    await tester.tap(find.text(l10n.routeNotFoundAction));
    await tester.pumpAndSettle();
    expect(find.byType(GuestHomeScreen), findsOneWidget);
  });

  testWidgets('opens the profile from the guest home and signs out', (
    tester,
  ) async {
    final config = createTestConfig();
    final container = _container(
      () => FakeAuthController(initialUser: testClient),
    );
    addTearDown(container.dispose);

    await tester.pumpWidget(_wrap(container, config: config));
    await tester.pumpAndSettle();

    await tester.tap(
      find.descendant(
        of: find.byType(GuestHomeScreen),
        matching: find.byTooltip(l10n.guestNavProfile),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.byType(GuestProfilePlaceholder), findsOneWidget);

    await tester.tap(find.text(l10n.signOut));
    await tester.pumpAndSettle();
    expect(find.byType(AuthScreen), findsOneWidget);
  });

  testWidgets('sends a host to the host placeholder', (tester) async {
    final config = createTestConfig();
    final container = _container(
      () => FakeAuthController(initialUser: testHost),
    );
    addTearDown(container.dispose);

    await tester.pumpWidget(_wrap(container, config: config));
    await tester.pumpAndSettle();

    expect(find.byType(HostHomePlaceholder), findsOneWidget);
    expect(find.text(l10n.hostHomePlaceholderTitle), findsOneWidget);
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
    expect(find.byType(HostHomePlaceholder), findsNothing);
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

    expect(find.byType(HostHomePlaceholder), findsOneWidget);
    expect(find.byType(GuestProfilePlaceholder), findsNothing);
    expect(find.byType(NavigationBar), findsNothing);
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
