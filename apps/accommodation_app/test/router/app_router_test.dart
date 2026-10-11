import 'package:accommodation_app/l10n/app_localizations.dart';
import 'package:accommodation_app/l10n/app_localizations_en.dart';
import 'package:accommodation_app/providers/auth_providers.dart';
import 'package:accommodation_app/providers/runtime_config_providers.dart';
import 'package:accommodation_app/router/app_router.dart';
import 'package:accommodation_app/screens/auth/auth_screen.dart';
import 'package:accommodation_app/screens/loading_screen.dart';
import 'package:accommodation_app/screens/placeholders/role_home_placeholder.dart';
import 'package:accommodation_app/screens/session_restore_error_screen.dart';
import 'package:accommodation_app/theme/tenant_theme.dart';
import 'package:accommodation_core/accommodation_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/fake_auth_controller.dart';
import '../helpers/test_data.dart';

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

ProviderContainer _container(AuthController Function() createController) {
  final config = createTestConfig();

  return ProviderContainer(
    retry: (_, _) => null,
    overrides: [
      tenantSlugProvider.overrideWith((ref) => TenantSlug.alpine),
      runtimeConfigProvider.overrideWith((ref) => config),
      authControllerProvider.overrideWith(createController),
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

  testWidgets('sends a client to the client placeholder', (tester) async {
    final config = createTestConfig();
    final container = _container(
      () => FakeAuthController(initialUser: testClient),
    );
    addTearDown(container.dispose);

    await tester.pumpWidget(_wrap(container, config: config));
    await tester.pumpAndSettle();

    expect(find.byType(ClientHomePlaceholder), findsOneWidget);
    expect(find.text(l10n.clientHomePlaceholderTitle), findsOneWidget);
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

    expect(find.byType(ClientHomePlaceholder), findsOneWidget);
    expect(find.byType(HostHomePlaceholder), findsNothing);
  });
}
