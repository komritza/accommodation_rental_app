import 'package:accommodation_app/router/app_routes.dart';
import 'package:accommodation_app/router/auth_redirect.dart';
import 'package:accommodation_app/router/guest_tabs.dart';
import 'package:accommodation_app/screens/guest/guest_shell.dart';
import 'package:accommodation_app/screens/loading_screen.dart';
import 'package:accommodation_app/screens/route_not_found_screen.dart';
import 'package:accommodation_app/screens/session_restore_error_screen.dart';
import 'package:accommodation_core/accommodation_core.dart';
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
import 'package:accommodation_features/profile.dart';
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

  final permissions = ref.watch(
    runtimeConfigProvider.select((config) => config.value?.permissions),
  );

  final guestTabs = permissions == null
      ? const [GuestTab.explore, GuestTab.profile]
      : guestTabsFor(permissions);

  return GoRouter(
    initialLocation: AppRoutePaths.splash,
    refreshListenable: refresh,
    redirect: (context, state) {
      return resolveAuthRedirect(
        auth: ref.read(authControllerProvider),
        location: state.matchedLocation,
      );
    },
    errorBuilder: (context, state) => const RouteNotFoundScreen(),
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
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            GuestShell(navigationShell: navigationShell, tabs: guestTabs),
        branches: [
          for (final tab in guestTabs)
            StatefulShellBranch(routes: [_guestTabRoute(tab)]),
        ],
      ),
      GoRoute(
        name: AppRouteNames.hostHome,
        path: AppRoutePaths.hostHome,
        builder: (context, state) => HostHomeScreen(
          onProfilePressed: () => context.pushNamed(AppRouteNames.hostProfile),
          onListingPressed: (listingId) => context.pushNamed(
            AppRouteNames.hostListingDetail,
            pathParameters: {'listingId': listingId},
          ),
        ),
      ),
      GoRoute(
        name: AppRouteNames.hostProfile,
        path: AppRoutePaths.hostProfile,
        builder: (context, state) => const ProfileScreen(),
      ),
      GoRoute(
        name: AppRouteNames.sessionRestoreError,
        path: AppRoutePaths.sessionRestoreError,
        builder: (context, state) => const SessionRestoreErrorScreen(),
      ),
      GoRoute(
        name: AppRouteNames.guestListingDetail,
        path: AppRoutePaths.guestListingDetail(':listingId'),
        builder: (context, state) =>
            ListingDetailScreen(listingId: state.pathParameters['listingId']!),
      ),
      GoRoute(
        name: AppRouteNames.hostListingDetail,
        path: AppRoutePaths.hostListingDetail(':listingId'),
        builder: (context, state) {
          final listingId = state.pathParameters['listingId']!;

          return HostListingDetailScreen(
            listingId: listingId,
            onEditPressed: () => context.pushNamed(
              AppRouteNames.hostListingDetailEdit,
              pathParameters: {'listingId': listingId},
            ),
            onManageBlockedDaysPressed: () => context.pushNamed(
              AppRouteNames.hostBlockedDays,
              pathParameters: {'listingId': listingId},
            ),
            onBookingsPressed: () => context.pushNamed(
              AppRouteNames.hostBookings,
              pathParameters: {'listingId': listingId},
            ),
          );
        },
      ),
      GoRoute(
        name: AppRouteNames.hostBookings,
        path: AppRoutePaths.hostBookings(':listingId'),
        builder: (context, state) =>
            HostBookingsScreen(listingId: state.pathParameters['listingId']!),
      ),
      GoRoute(
        name: AppRouteNames.hostListingDetailEdit,
        path: AppRoutePaths.hostListingDetailEdit(':listingId'),
        builder: (context, state) => HostEditListingScreen(
          listingId: state.pathParameters['listingId']!,
          onSaved: () => context.pop(),
        ),
      ),
      if (permissions?.blockedDays ?? false)
        GoRoute(
          name: AppRouteNames.hostBlockedDays,
          path: AppRoutePaths.hostBlockedDays(':listingId'),
          builder: (context, state) => HostBlockedDaysScreen(
            listingId: state.pathParameters['listingId']!,
          ),
        ),
    ],
  );
});

GoRoute _guestTabRoute(GuestTab tab) {
  return switch (tab) {
    GuestTab.explore => GoRoute(
      name: AppRouteNames.clientHome,
      path: AppRoutePaths.clientHome,
      builder: (context, state) => GuestHomeScreen(
        onProfilePressed: () => context.goNamed(AppRouteNames.clientProfile),
        onListingPressed: (listingId) => context.pushNamed(
          AppRouteNames.guestListingDetail,
          pathParameters: {'listingId': listingId},
        ),
      ),
    ),
    GuestTab.saved => GoRoute(
      name: AppRouteNames.clientSaved,
      path: AppRoutePaths.clientSaved,
      builder: (context, state) => FavouritesScreen(
        onListingPressed: (listingId) => context.pushNamed(
          AppRouteNames.guestListingDetail,
          pathParameters: {'listingId': listingId},
        ),
      ),
    ),
    GuestTab.profile => GoRoute(
      name: AppRouteNames.clientProfile,
      path: AppRoutePaths.clientProfile,
      builder: (context, state) => const ProfileScreen(),
    ),
  };
}
