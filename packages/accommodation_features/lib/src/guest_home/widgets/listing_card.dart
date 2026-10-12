import 'package:accommodation_core/accommodation_core.dart';
import 'package:accommodation_ui/accommodation_ui.dart';
import 'package:flutter/material.dart';

import '../guest_filter_labels.dart';

class ListingCard extends StatelessWidget {
  const ListingCard({super.key, required this.listing});

  final Listing listing;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colors = context.accommodationColors;
    final textTheme = Theme.of(context).textTheme;
    final locale = Localizations.localeOf(context).toLanguageTag();
    final muted = textTheme.bodyMedium?.copyWith(color: colors.textMuted);

    return MergeSemantics(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ExcludeSemantics(
            child: AppCoverImage(
              url: listing.images.firstOrNull,
              semanticLabel: listing.title,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            listing.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: textTheme.titleMedium,
          ),
          Text(listing.city, style: muted),
          Text(l10n.listingUpToGuests(listing.maxGuests), style: muted),
          const SizedBox(height: AppSpacing.xxs),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: formatGuestPrice(
                    listing.pricePerNight,
                    currencyCode: listing.currency,
                    locale: locale,
                  ),
                  style: const TextStyle(
                    fontWeight: AppTypography.weightExtraBold,
                  ),
                ),
                TextSpan(
                  text: l10n.listingPerNight,
                  style: TextStyle(color: colors.textMuted),
                ),
              ],
            ),
            style: textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }
}
