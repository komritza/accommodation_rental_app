import 'package:accommodation_core/accommodation_core.dart';
import 'package:accommodation_ui/accommodation_ui.dart';
import 'package:flutter/material.dart';

import '../../listings/widgets/listing_summary.dart';
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
                  ListingRating(listing: listing),
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
              ListingNightlyPrice(
                listing: listing,
                style: textTheme.bodyLarge!,
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
