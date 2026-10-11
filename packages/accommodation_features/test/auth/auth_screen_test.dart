import 'package:accommodation_core/accommodation_core.dart';
import 'package:accommodation_core/testing.dart';
import 'package:accommodation_features/src/auth/auth_providers.dart';
import 'package:accommodation_features/src/auth/auth_screen.dart';
import 'package:accommodation_features/src/common/dependencies.dart';
import 'package:accommodation_features/testing.dart';
import 'package:accommodation_ui/accommodation_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';

Widget _wrap({
  required AuthController Function() createController,
  Brightness brightness = Brightness.light,
  Locale locale = const Locale('en'),
}) {
  final config = createTestConfig();
  final palette = brightness == Brightness.light
      ? config.theme.light
      : config.theme.dark;

  return ProviderScope(
    retry: (_, _) => null,
    overrides: [
      tenantSlugProvider.overrideWith((ref) => TenantSlug.alpine),
      runtimeConfigProvider.overrideWith((ref) => config),
      authControllerProvider.overrideWith(createController),
    ],
    child: MaterialApp(
      locale: locale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: buildTenantTheme(palette, brightness: brightness),
      home: const AuthScreen(),
    ),
  );
}

Future<void> _fillSignIn(WidgetTester tester) async {
  final fields = find.byType(TextFormField);
  await tester.enterText(fields.at(0), 'client@example.com');
  await tester.enterText(fields.at(1), 'Password1!');
}

void main() {
  final l10n = AppLocalizationsEn();

  testWidgets('shows email and password in sign-in mode', (tester) async {
    await tester.pumpWidget(_wrap(createController: FakeAuthController.new));
    await tester.pumpAndSettle();

    expect(find.text(l10n.authWelcomeBack), findsOneWidget);
    expect(find.text(l10n.authFirstName), findsNothing);
    expect(find.text(l10n.authLastName), findsNothing);
    expect(find.byType(TextFormField), findsNWidgets(2));
  });

  testWidgets('switches to registration fields on the same page', (
    tester,
  ) async {
    await tester.pumpWidget(_wrap(createController: FakeAuthController.new));
    await tester.pumpAndSettle();

    await tester.tap(find.text(l10n.authCreateAnAccount));
    await tester.pumpAndSettle();

    expect(find.text(l10n.authCreateAccountTitle), findsOneWidget);
    expect(find.text(l10n.authFirstName), findsOneWidget);
    expect(find.text(l10n.authLastName), findsOneWidget);
    expect(find.byType(TextFormField), findsNWidgets(4));
  });

  testWidgets('keeps email and password when switching modes', (tester) async {
    await tester.pumpWidget(_wrap(createController: FakeAuthController.new));
    await tester.pumpAndSettle();

    await _fillSignIn(tester);
    await tester.tap(find.text(l10n.authCreateAnAccount));
    await tester.pumpAndSettle();

    expect(find.text('client@example.com'), findsOneWidget);
    expect(find.text('Password1!'), findsOneWidget);
  });

  testWidgets('validates required fields before calling the controller', (
    tester,
  ) async {
    final controller = FakeAuthController();

    await tester.pumpWidget(_wrap(createController: () => controller));
    await tester.pumpAndSettle();

    await tester.tap(find.widgetWithText(FilledButton, l10n.authSignIn));
    await tester.pumpAndSettle();

    expect(find.text(l10n.authEmailRequired), findsOneWidget);
    expect(find.text(l10n.authPasswordRequired), findsOneWidget);
    expect(controller.loginCalls, 0);
  });

  testWidgets('invokes login with trimmed email, password and language', (
    tester,
  ) async {
    final controller = FakeAuthController();

    await tester.pumpWidget(_wrap(createController: () => controller));
    await tester.pumpAndSettle();

    await _fillSignIn(tester);
    await tester.tap(find.widgetWithText(FilledButton, l10n.authSignIn));
    await tester.pumpAndSettle();

    expect(controller.loginCalls, 1);
    expect(controller.lastEmail, 'client@example.com');
    expect(controller.lastPassword, 'Password1!');
    expect(controller.lastLanguage, 'en');
  });

  testWidgets('invokes register with the four form values', (tester) async {
    final controller = FakeAuthController();

    await tester.pumpWidget(_wrap(createController: () => controller));
    await tester.pumpAndSettle();

    await tester.tap(find.text(l10n.authCreateAnAccount));
    await tester.pumpAndSettle();

    final fields = find.byType(TextFormField);
    await tester.enterText(fields.at(0), ' Alex ');
    await tester.enterText(fields.at(1), ' Smith ');
    await tester.enterText(fields.at(2), 'new@example.com');
    await tester.enterText(fields.at(3), 'Password1!');
    final registerButton = find.widgetWithText(FilledButton, l10n.authRegister);
    await tester.ensureVisible(registerButton);
    await tester.pumpAndSettle();
    await tester.tap(registerButton);
    await tester.pumpAndSettle();

    expect(controller.registerCalls, 1);
    expect(controller.lastFirstName, 'Alex');
    expect(controller.lastLastName, 'Smith');
    expect(controller.lastEmail, 'new@example.com');
    expect(controller.lastPassword, 'Password1!');
    expect(controller.lastLanguage, 'en');
  });

  testWidgets('shows a localized error and blocks a second in-flight submit', (
    tester,
  ) async {
    final controller = FakeAuthController(
      loginResult: const Left(ApiFailure(type: ApiFailureType.network)),
      delay: const Duration(milliseconds: 50),
    );

    await tester.pumpWidget(_wrap(createController: () => controller));
    await tester.pumpAndSettle();

    await _fillSignIn(tester);
    await tester.tap(find.widgetWithText(FilledButton, l10n.authSignIn));
    await tester.pump();
    await tester.tap(find.widgetWithText(FilledButton, l10n.authPleaseWait));
    await tester.pumpAndSettle();

    expect(controller.loginCalls, 1);
    expect(find.text(l10n.authErrorNetwork), findsOneWidget);
  });

  testWidgets('uses tenant semantic colors in dark mode', (tester) async {
    await tester.pumpWidget(
      _wrap(
        createController: FakeAuthController.new,
        brightness: Brightness.dark,
      ),
    );
    await tester.pumpAndSettle();

    final scaffoldMaterial = tester.widget<Material>(
      find
          .descendant(
            of: find.byType(Scaffold),
            matching: find.byType(Material),
          )
          .first,
    );
    expect(scaffoldMaterial.color, const Color(0xFF111111));
  });

  testWidgets('disables the mode switch while submitting', (tester) async {
    final controller = FakeAuthController(
      delay: const Duration(milliseconds: 50),
    );

    await tester.pumpWidget(_wrap(createController: () => controller));
    await tester.pumpAndSettle();

    await _fillSignIn(tester);
    await tester.tap(find.widgetWithText(FilledButton, l10n.authSignIn));
    await tester.pump();

    final modeSwitch = tester.widget<TextButton>(
      find.widgetWithText(TextButton, l10n.authCreateAnAccount),
    );
    expect(modeSwitch.onPressed, isNull);

    await tester.pumpAndSettle();
  });
}
