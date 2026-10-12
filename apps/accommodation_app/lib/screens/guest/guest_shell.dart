import 'package:accommodation_app/router/guest_tabs.dart';
import 'package:accommodation_ui/accommodation_ui.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class GuestShell extends StatelessWidget {
  const GuestShell({
    super.key,
    required this.navigationShell,
    required this.tabs,
  });

  final StatefulNavigationShell navigationShell;
  final List<GuestTab> tabs;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Divider(),
          NavigationBar(
            selectedIndex: navigationShell.currentIndex,
            onDestinationSelected: (index) => navigationShell.goBranch(
              index,
              initialLocation: index == navigationShell.currentIndex,
            ),
            destinations: [
              for (final tab in tabs)
                switch (tab) {
                  GuestTab.explore => NavigationDestination(
                    icon: const Icon(Icons.search),
                    label: l10n.guestNavExplore,
                  ),
                  GuestTab.saved => NavigationDestination(
                    icon: const Icon(Icons.favorite_border),
                    selectedIcon: const Icon(Icons.favorite),
                    label: l10n.guestNavSaved,
                  ),
                  GuestTab.profile => NavigationDestination(
                    icon: const Icon(Icons.person_outline),
                    selectedIcon: const Icon(Icons.person),
                    label: l10n.guestNavProfile,
                  ),
                },
            ],
          ),
        ],
      ),
    );
  }
}
