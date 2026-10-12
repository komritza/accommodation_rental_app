import 'package:accommodation_core/accommodation_core.dart';
import 'package:accommodation_ui/accommodation_ui.dart';
import 'package:flutter/material.dart';

import '../guest_filter_labels.dart';

class ListingCard extends StatelessWidget {
  const ListingCard({super.key, required this.listing, this.onTap});

  final Listing listing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colors = context.accommodationColors;
    final textTheme = Theme.of(context).textTheme;
    final locale = Localizations.localeOf(context).toLanguageTag();
    final muted = textTheme.bodyMedium?.copyWith(color: colors.textMuted);

    return MergeSemantics(
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ExcludeSemantics(
                child: AppCoverImage(
                  url: listing.images.firstOrNull,
                  semanticLabel: listing.title,
                  propertyTypeLabel: listing.propertyType,
                ),
              ),
              const SizedBox(height: AppSpacing.xs),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: Text(
                      listing.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: textTheme.titleMedium,
                    ),
                  ),
                  if (listing.reviewsCount > 0)
                    Row(
                      children: [
                        const Icon(Icons.star_rate, size: AppIconSizes.sm),
                        const SizedBox(width: AppSpacing.xxs),
                        Text(
                          listing.rating.toStringAsFixed(2),
                          style: textTheme.bodyMedium,
                        ),
                        Text(
                          ' (${listing.reviewsCount})',
                          style: textTheme.bodyMedium,
                        ),
                      ],
                    )
                  else
                    AppBadge(
                      label: l10n.chipNoRatingText,
                      backgroundColor: colors.surfaceAction,
                      foregroundColor: colors.textOnAction,
                    ),
                ],
              ),
              Text(listing.city, style: muted),
              Wrap(
                spacing: AppSpacing.xxs,
                runSpacing: AppSpacing.xxs,
                children: [
                  if (listing.maxGuests > 0)
                    _ListingAttribute(
                      icon: Icons.people_alt_outlined,
                      label: l10n.guestCount(listing.maxGuests),
                    ),
                  if (listing.bedrooms > 0)
                    _ListingAttribute(
                      icon: Icons.meeting_room,
                      label: l10n.listingBedrooms(listing.bedrooms),
                    ),
                  if (listing.beds > 0)
                    _ListingAttribute(
                      icon: Icons.bed_outlined,
                      label: l10n.listingBeds(listing.beds),
                    ),
                  if (listing.bathrooms > 0)
                    _ListingAttribute(
                      icon: Icons.bathtub_outlined,
                      label: l10n.listingBathrooms(listing.bathrooms),
                    ),
                ],
              ),
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
              const SizedBox(height: AppSpacing.xxs),
              if (listing.cleaningFee > 0)
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: '+ ',
                        style: TextStyle(color: colors.textMuted),
                      ),
                      TextSpan(
                        text: formatGuestPrice(
                          listing.cleaningFee,
                          currencyCode: listing.currency,
                          locale: locale,
                        ),
                        style: muted,
                      ),
                      TextSpan(
                        text: ' ${l10n.cleaningFee.toLowerCase()}',
                        style: TextStyle(color: colors.textMuted),
                      ),
                    ],
                  ),
                  style: textTheme.bodyLarge,
                ),
            ],
          ),
          Positioned.fill(
            child: Material(
              type: MaterialType.transparency,
              child: InkWell(onTap: onTap, borderRadius: AppRadii.mdBorder),
            ),
          ),
        ],
      ),
    );
  }
}

class _ListingAttribute extends StatelessWidget {
  const _ListingAttribute({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    final colors = context.accommodationColors;
    final textTheme = Theme.of(context).textTheme;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: AppIconSizes.sm, color: colors.textMuted),
        const SizedBox(width: AppSpacing.xxs),
        Text(
          label,
          style: textTheme.bodyMedium?.copyWith(color: colors.textMuted),
        ),
      ],
    );
  }
}
