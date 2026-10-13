import 'package:accommodation_core/accommodation_core.dart';
import 'package:accommodation_ui/accommodation_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../common/dependencies.dart';
import '../favourites/favourites_providers.dart';
import 'listing_detail_error_mapper.dart';
import 'listing_detail_labels.dart';
import 'listing_detail_providers.dart';
import 'widgets/listing_availability_section.dart';
import 'widgets/listing_detail_image_carousel.dart';

class ListingDetailScreen extends ConsumerWidget {
  const ListingDetailScreen({super.key, required this.listingId});

  final String listingId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final textTheme = Theme.of(context).textTheme;
    final language = Localizations.localeOf(context).languageCode;
    final provider = listingDetailProvider(listingId, language: language);
    final listing = ref.watch(provider);
    final loaded = listing.value;
    final favouritesEnabled = ref.watch(
      runtimeConfigProvider.select(
        (config) => config.value?.permissions.favourites ?? false,
      ),
    );

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          loaded == null
              ? l10n.listingDetailStays
              : l10n.listingDetailAppBarTitle(loaded.city, loaded.country),
          style: textTheme.bodyLarge,
        ),
        actions: [
          if (favouritesEnabled && loaded != null)
            _FavouriteButton(listing: loaded),
        ],
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(AppBorderWidths.regular),
          child: Divider(),
        ),
      ),
      body: listing.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: AppStatusView(
              icon: Icons.cloud_off_outlined,
              title: localizedListingDetailErrorTitle(l10n, error),
              message: localizedListingDetailError(l10n, error),
              action: isListingNotFound(error)
                  ? null
                  : FilledButton(
                      onPressed: () => ref.invalidate(provider),
                      child: Text(l10n.retry),
                    ),
            ),
          ),
        ),
        data: (listing) => _ListingDetailContent(listing: listing),
      ),
    );
  }
}

class _FavouriteButton extends ConsumerWidget {
  const _FavouriteButton({required this.listing});

  final Listing listing;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final colors = context.accommodationColors;
    final favourites = ref.watch(favouritesProvider);
    final isFavourite =
        favourites.value?.any((item) => item.id == listing.id) ?? false;
    final isLoadingFirstTime = favourites.isLoading && !favourites.hasValue;

    return Padding(
      padding: const EdgeInsets.only(right: AppSpacing.xs),
      child: IconButton(
        tooltip: isFavourite ? l10n.favouriteRemove : l10n.favouriteAdd,
        onPressed: isLoadingFirstTime
            ? null
            : () => _onPressed(context, ref, l10n, favourites),
        icon: Icon(
          isFavourite ? Icons.favorite : Icons.favorite_border,
          color: isFavourite ? colors.stateFavourite : colors.iconAction,
        ),
      ),
    );
  }

  Future<void> _onPressed(
    BuildContext context,
    WidgetRef ref,
    AppLocalizations l10n,
    AsyncValue<List<Listing>> favourites,
  ) async {
    final messenger = ScaffoldMessenger.of(context);

    if (!favourites.hasValue) {
      ref.invalidate(favouritesProvider);
      messenger.showSnackBar(SnackBar(content: Text(l10n.favouritesLoadError)));
      return;
    }

    try {
      await ref.read(favouritesProvider.notifier).toggle(listing);
    } on FavouritesUpdateException {
      messenger.showSnackBar(
        SnackBar(content: Text(l10n.favouritesUpdateError)),
      );
    }
  }
}

class _ListingDetailContent extends StatelessWidget {
  const _ListingDetailContent({required this.listing});

  final Listing listing;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colors = context.accommodationColors;
    final textTheme = Theme.of(context).textTheme;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: AppLayoutTokens.contentMaxWidth,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListingDetailImageCarousel(listing: listing),
              const SizedBox(height: AppSpacing.md),
              AppBadge(
                label: listing.propertyType.capitalizeFirst(),
                backgroundColor: colors.surfaceSecondary,
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(listing.title, style: textTheme.headlineMedium),
              const SizedBox(height: AppSpacing.xs),
              _ListingRatingAndLocation(listing: listing),
              const SizedBox(height: AppSpacing.xs),
              Text(
                listingFactsSummary(l10n, listing),
                style: textTheme.bodyMedium,
              ),
              const _SectionDivider(),
              _ListingDetailDescription(listing: listing),
              if (listing.amenities.isNotEmpty) ...[
                const _SectionDivider(),
                _ListingDetailAmenities(listing: listing),
              ],
              const _SectionDivider(),
              ListingAvailabilitySection(listingId: listing.id),
            ],
          ),
        ),
      ),
    );
  }
}

class _ListingRatingAndLocation extends StatelessWidget {
  const _ListingRatingAndLocation({required this.listing});

  final Listing listing;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colors = context.accommodationColors;

    return DefaultTextStyle.merge(
      style: Theme.of(context).textTheme.bodyLarge,
      child: Wrap(
        spacing: AppSpacing.xxs,
        runSpacing: AppSpacing.xxs,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          if (listing.reviewsCount > 0) ...[
            const Icon(Icons.star_rate, size: AppIconSizes.md),
            Text(listing.rating.toStringAsFixed(2)),
            const Text('·'),
            Text(l10n.listingDetailReviews(listing.reviewsCount)),
          ] else
            AppBadge(
              label: l10n.chipNoRatingText,
              backgroundColor: colors.surfaceAction,
              foregroundColor: colors.textOnAction,
            ),
          const Text('·'),
          Text(l10n.listingLocation(listing.city, listing.country)),
        ],
      ),
    );
  }
}

class _SectionDivider extends StatelessWidget {
  const _SectionDivider();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: AppSpacing.md),
      child: Divider(),
    );
  }
}

class _ListingDetailDescription extends StatelessWidget {
  const _ListingDetailDescription({required this.listing});

  final Listing listing;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(l10n.listingDetailAboutThisPlace, style: textTheme.titleLarge),
        const SizedBox(height: AppSpacing.md),
        Text(listing.description, style: textTheme.bodyMedium),
      ],
    );
  }
}

class _ListingDetailAmenities extends StatelessWidget {
  const _ListingDetailAmenities({required this.listing});

  final Listing listing;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colors = context.accommodationColors;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.listingDetailWhatThisPlaceOffers,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: AppSpacing.md),
        Wrap(
          spacing: AppSpacing.xs,
          runSpacing: AppSpacing.xs,
          children: [
            for (final amenity in listing.amenities)
              AppBadge(
                label: amenityLabel(l10n, amenity),
                backgroundColor: colors.surfaceSecondary,
              ),
          ],
        ),
      ],
    );
  }
}
