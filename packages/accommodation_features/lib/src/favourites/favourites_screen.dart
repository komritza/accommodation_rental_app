import 'package:accommodation_core/accommodation_core.dart';
import 'package:accommodation_ui/accommodation_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'favourites_providers.dart';
import 'widgets/favourite_listing_card.dart';

class FavouritesScreen extends ConsumerWidget {
  const FavouritesScreen({super.key, required this.onListingPressed});

  final ValueChanged<String> onListingPressed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final favourites = ref.watch(favouritesProvider);

    return Scaffold(
      appBar: AppBar(centerTitle: false, title: Text(l10n.favouritesTitle)),
      body: switch (favourites) {
        AsyncValue(:final value?) => _FavouritesList(
          listings: value,
          onListingPressed: onListingPressed,
        ),
        AsyncValue(:final error?, isLoading: false) => _CenteredStatus(
          child: AppStatusView(
            icon: Icons.cloud_off_outlined,
            title: l10n.favouritesLoadError,
            message: _localizedLoadError(l10n, error),
            action: FilledButton(
              onPressed: () => ref.invalidate(favouritesProvider),
              child: Text(l10n.retry),
            ),
          ),
        ),
        _ => const Center(child: CircularProgressIndicator()),
      },
    );
  }

  String _localizedLoadError(AppLocalizations l10n, Object error) {
    final failure = error is FavouritesLoadException ? error.failure : error;

    if (failure is ApiFailure && failure.type == ApiFailureType.network) {
      return l10n.listingsErrorNetwork;
    }

    return l10n.listingsErrorGeneric;
  }
}

class _FavouritesList extends ConsumerWidget {
  const _FavouritesList({
    required this.listings,
    required this.onListingPressed,
  });

  final List<Listing> listings;
  final ValueChanged<String> onListingPressed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;

    if (listings.isEmpty) {
      return _CenteredStatus(
        child: AppStatusView(
          icon: Icons.favorite_border,
          title: l10n.favouritesEmptyTitle,
          message: l10n.favouritesEmptyMessage,
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(AppSpacing.md),
      itemCount: listings.length,
      separatorBuilder: (context, index) =>
          const SizedBox(height: AppSpacing.md),
      itemBuilder: (context, index) {
        final listing = listings[index];

        return Center(
          key: ValueKey(listing.id),
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: AppLayoutTokens.contentMaxWidth,
            ),
            child: FavouriteListingCard(
              listing: listing,
              onTap: () => onListingPressed(listing.id),
              onRemove: () => _remove(context, ref, l10n, listing),
            ),
          ),
        );
      },
    );
  }

  Future<void> _remove(
    BuildContext context,
    WidgetRef ref,
    AppLocalizations l10n,
    Listing listing,
  ) async {
    final messenger = ScaffoldMessenger.of(context);

    try {
      await ref.read(favouritesProvider.notifier).toggle(listing);
    } on FavouritesUpdateException {
      messenger.showSnackBar(
        SnackBar(content: Text(l10n.favouritesUpdateError)),
      );
    }
  }
}

class _CenteredStatus extends StatelessWidget {
  const _CenteredStatus({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: child,
      ),
    );
  }
}
