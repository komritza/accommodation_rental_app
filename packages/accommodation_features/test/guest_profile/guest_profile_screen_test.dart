import 'package:accommodation_core/accommodation_core.dart';
import 'package:accommodation_core/testing.dart';
import 'package:accommodation_features/auth.dart';
import 'package:accommodation_features/profile.dart';
import 'package:accommodation_features/testing.dart';
import 'package:accommodation_ui/accommodation_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';

class _TrackingAuthController extends FakeAuthController {
  _TrackingAuthController({required super.initialUser});

  bool logoutCalled = false;

  @override
  Future<Either<ApiFailure, bool>> logout() async {
    logoutCalled = true;
    return Right(true);
  }
}

Future<_TrackingAuthController> _pumpScreen(WidgetTester tester) async {
  final authController = _TrackingAuthController(initialUser: testClient);
  final config = createTestConfig();

  await tester.pumpWidget(
    ProviderScope(
      retry: (_, _) => null,
      overrides: [authControllerProvider.overrideWith(() => authController)],
      child: MaterialApp(
        locale: const Locale('en'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        theme: buildTenantTheme(
          config.theme.light,
          brightness: Brightness.light,
        ),
        home: const GuestProfileScreen(),
      ),
    ),
  );

  await tester.pumpAndSettle();

  return authController;
}

void main() {
  final l10n = AppLocalizationsEn();

  testWidgets('shows the user name and email', (tester) async {
    await _pumpScreen(tester);

    final displayName = '${testClient.firstName} ${testClient.lastName}'.trim();

    expect(find.text(l10n.profileTitle), findsOneWidget);
    expect(find.text(displayName), findsOneWidget);
    expect(find.text(testClient.email), findsOneWidget);
  });

  testWidgets('logs out when the sign out button is pressed', (tester) async {
    final authController = await _pumpScreen(tester);

    await tester.tap(find.text(l10n.signOut));
    await tester.pump();

    expect(authController.logoutCalled, isTrue);
  });
}
