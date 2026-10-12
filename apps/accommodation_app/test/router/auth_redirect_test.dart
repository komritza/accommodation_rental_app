import 'package:accommodation_app/router/app_router.dart';
import 'package:accommodation_core/accommodation_core.dart';
import 'package:accommodation_core/testing.dart';
import 'package:accommodation_features/auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('resolveAuthRedirect', () {
    test('keeps the splash route while session restoration is loading', () {
      expect(
        resolveAuthRedirect(
          auth: const AsyncLoading(),
          location: AppRoutePaths.splash,
        ),
        isNull,
      );
    });

    test('sends other locations to splash while restoration is loading', () {
      expect(
        resolveAuthRedirect(
          auth: const AsyncLoading(),
          location: AppRoutePaths.auth,
        ),
        AppRoutePaths.splash,
      );
      expect(
        resolveAuthRedirect(
          auth: const AsyncLoading(),
          location: AppRoutePaths.clientHome,
        ),
        AppRoutePaths.splash,
      );
    });

    test('does not treat a restore error as signed out', () {
      const error = AsyncError<AuthUser?>(
        AuthSessionRestoreException(ApiFailure(type: ApiFailureType.network)),
        StackTrace.empty,
      );

      expect(
        resolveAuthRedirect(auth: error, location: AppRoutePaths.auth),
        AppRoutePaths.sessionRestoreError,
      );
      expect(
        resolveAuthRedirect(
          auth: error,
          location: AppRoutePaths.sessionRestoreError,
        ),
        isNull,
      );
    });

    test('sends a signed-out user to the auth screen', () {
      expect(
        resolveAuthRedirect(
          auth: const AsyncData(null),
          location: AppRoutePaths.splash,
        ),
        AppRoutePaths.auth,
      );
      expect(
        resolveAuthRedirect(
          auth: const AsyncData(null),
          location: AppRoutePaths.clientHome,
        ),
        AppRoutePaths.auth,
      );
      expect(
        resolveAuthRedirect(
          auth: const AsyncData(null),
          location: AppRoutePaths.auth,
        ),
        isNull,
      );
    });

    test('sends clients and hosts to their destinations from auth', () {
      expect(
        resolveAuthRedirect(
          auth: const AsyncData(testClient),
          location: AppRoutePaths.auth,
        ),
        AppRoutePaths.clientHome,
      );
      expect(
        resolveAuthRedirect(
          auth: const AsyncData(testHost),
          location: AppRoutePaths.splash,
        ),
        AppRoutePaths.hostHome,
      );
    });

    test('lets each role move within its own area', () {
      expect(
        resolveAuthRedirect(
          auth: const AsyncData(testClient),
          location: AppRoutePaths.clientProfile,
        ),
        isNull,
      );
      expect(
        resolveAuthRedirect(
          auth: const AsyncData(testHost),
          location: AppRoutePaths.hostHome,
        ),
        isNull,
      );
    });

    test('keeps a host out of every guest route', () {
      for (final location in [
        AppRoutePaths.clientHome,
        AppRoutePaths.clientSaved,
        AppRoutePaths.clientProfile,
      ]) {
        expect(
          resolveAuthRedirect(
            auth: const AsyncData(testHost),
            location: location,
          ),
          AppRoutePaths.hostHome,
          reason: location,
        );
      }
    });

    test('does not treat a lookalike path as part of an area', () {
      expect(
        resolveAuthRedirect(
          auth: const AsyncData(testHost),
          location: '/clients',
        ),
        isNull,
      );
    });

    test('keeps a user off the other role destination', () {
      expect(
        resolveAuthRedirect(
          auth: const AsyncData(testClient),
          location: AppRoutePaths.hostHome,
        ),
        AppRoutePaths.clientHome,
      );
      expect(
        resolveAuthRedirect(
          auth: const AsyncData(testHost),
          location: AppRoutePaths.clientHome,
        ),
        AppRoutePaths.hostHome,
      );
    });
  });
}
