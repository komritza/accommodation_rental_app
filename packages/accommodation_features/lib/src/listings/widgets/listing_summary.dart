import 'package:accommodation_core/accommodation_core.dart';
import 'package:accommodation_ui/accommodation_ui.dart';
import 'package:flutter/material.dart';

import '../../guest_home/guest_filter_labels.dart';

class ListingRating extends StatelessWidget {
  const ListingRating({super.key, required this.listing});

  final Listing listing;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colors = context.accommodationColors;
    final textTheme = Theme.of(context).textTheme;

    if (listing.reviewsCount == 0) {
      return AppBadge(
        label: l10n.chipNoRatingText,
        backgroundColor: colors.surfaceAction,
        foregroundColor: colors.textOnAction,
      );
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.star_rate, size: AppIconSizes.sm),
        const SizedBox(width: AppSpacing.xxs),
        Text(listing.rating.toStringAsFixed(2), style: textTheme.bodyMedium),
        Text(' (${listing.reviewsCount})', style: textTheme.bodyMedium),
      ],
    );
  }
}

class ListingNightlyPrice extends StatelessWidget {
  const ListingNightlyPrice({
    super.key,
    required this.listing,
    required this.style,
  });

  final Listing listing;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colors = context.accommodationColors;
    final locale = Localizations.localeOf(context).toLanguageTag();

    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: formatGuestPrice(
              listing.pricePerNight,
              currencyCode: listing.currency,
              locale: locale,
            ),
            style: const TextStyle(fontWeight: AppTypography.weightExtraBold),
          ),
          TextSpan(
            text: l10n.listingPerNight,
            style: TextStyle(color: colors.textMuted),
          ),
        ],
      ),
      style: style,
    );
  }
}
