import 'package:accommodation_app/router/app_routes.dart';
import 'package:accommodation_ui/accommodation_ui.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RouteNotFoundScreen extends StatelessWidget {
  const RouteNotFoundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: AppStatusView(
            icon: Icons.explore_off_outlined,
            title: l10n.routeNotFoundTitle,
            message: l10n.routeNotFoundMessage,
            action: FilledButton(
              onPressed: () => context.go(AppRoutePaths.splash),
              child: Text(l10n.routeNotFoundAction),
            ),
          ),
        ),
      ),
    );
  }
}
