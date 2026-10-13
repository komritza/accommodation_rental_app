import 'package:accommodation_core/accommodation_core.dart';
import 'package:accommodation_ui/accommodation_ui.dart';
import 'package:flutter/material.dart';

import '../../listings/widgets/listing_summary.dart';

class FavouriteListingCard extends StatelessWidget {
  const FavouriteListingCard({
    super.key,
    required this.listing,
    required this.onRemove,
    this.onTap,
  });

  final Listing listing;
  final VoidCallback onRemove;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colors = context.accommodationColors;
    final textTheme = Theme.of(context).textTheme;

    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppRadii.sm),
          border: Border.all(
            width: AppBorderWidths.regular,
            color: colors.borderPrimary,
          ),
        ),
        clipBehavior: Clip.antiAlias,
        child: Row(
          children: [
            SizedBox(
              width: AppSizedBoxTokens.contentWidth,
              height: AppSizedBoxTokens.contentHeight,
              child: Image.network(
                listing.images.first,
                fit: BoxFit.cover,
                semanticLabel: listing.title,
                errorBuilder: (context, error, stackTrace) => Center(
                  child: Icon(
                    Icons.image_outlined,
                    size: AppIconSizes.lg,
                    color: colors.textMuted,
                  ),
                ),
              ),
            ),
            SizedBox(width: AppSpacing.xs),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    listing.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.bodyMedium,
                  ),
                  Text(
                    l10n.listingLocation(listing.city, listing.country),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.bodyMedium?.copyWith(
                      color: colors.textMuted,
                    ),
                  ),
                  ListingRating(listing: listing),
                  ListingNightlyPrice(
                    listing: listing,
                    style: textTheme.bodyMedium!,
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: onRemove,
              tooltip: l10n.favouriteRemove,
              icon: const Icon(Icons.favorite),
              style: IconButton.styleFrom(
                backgroundColor: colors.surfacePrimary,
                foregroundColor: colors.stateFavourite,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
