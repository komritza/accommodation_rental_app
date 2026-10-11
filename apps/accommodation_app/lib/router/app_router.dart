import 'package:accommodation_app/router/app_routes.dart';
import 'package:accommodation_app/router/auth_redirect.dart';
import 'package:accommodation_app/screens/loading_screen.dart';
import 'package:accommodation_app/screens/placeholders/role_home_placeholder.dart';
import 'package:accommodation_app/screens/session_restore_error_screen.dart';
import 'package:accommodation_core/accommodation_core.dart';
import 'package:accommodation_features/auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

export 'package:accommodation_app/router/app_routes.dart';
export 'package:accommodation_app/router/auth_redirect.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  final refresh = ValueNotifier<int>(0);

  ref.listen<AsyncValue<AuthUser?>>(authControllerProvider, (previous, next) {
    refresh.value++;
  });

  ref.onDispose(refresh.dispose);

  return GoRouter(
    initialLocation: AppRoutePaths.splash,
    refreshListenable: refresh,
    redirect: (context, state) {
      return resolveAuthRedirect(
        auth: ref.read(authControllerProvider),
        location: state.matchedLocation,
      );
    },
    routes: [
      GoRoute(
        name: AppRouteNames.splash,
        path: AppRoutePaths.splash,
        builder: (context, state) => const LoadingScreen(),
      ),
      GoRoute(
        name: AppRouteNames.auth,
        path: AppRoutePaths.auth,
        builder: (context, state) => const AuthScreen(),
      ),
      GoRoute(
        name: AppRouteNames.clientHome,
        path: AppRoutePaths.clientHome,
        builder: (context, state) => const ClientHomePlaceholder(),
      ),
      GoRoute(
        name: AppRouteNames.hostHome,
        path: AppRoutePaths.hostHome,
        builder: (context, state) => const HostHomePlaceholder(),
      ),
      GoRoute(
        name: AppRouteNames.sessionRestoreError,
        path: AppRoutePaths.sessionRestoreError,
        builder: (context, state) => const SessionRestoreErrorScreen(),
      ),
    ],
  );
});
