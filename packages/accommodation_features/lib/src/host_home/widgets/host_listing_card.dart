import 'package:accommodation_core/accommodation_core.dart';
import 'package:accommodation_ui/accommodation_ui.dart';
import 'package:flutter/material.dart';

import '../../listings/widgets/listing_summary.dart';

class HostListingCard extends StatelessWidget {
  const HostListingCard({super.key, required this.listing, this.onTap});

  final Listing listing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.accommodationColors;
    final textTheme = Theme.of(context).textTheme;
    final l10n = AppLocalizations.of(context)!;
    final muted = textTheme.bodyMedium?.copyWith(color: colors.textMuted);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: AppRadii.mdBorder,
        child: Padding(
          padding: const EdgeInsets.only(bottom: AppSpacing.xs),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AppCoverImage(
                url: listing.images.firstOrNull,
                semanticLabel: listing.title,
                propertyTypeLabel: listing.propertyType,
              ),
              const SizedBox(height: AppSpacing.md),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      listing.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: textTheme.titleMedium,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Icon(Icons.chevron_right, color: colors.textMuted),
                ],
              ),
              const SizedBox(height: AppSpacing.xxs),
              Text(
                l10n.listingLocation(listing.city, listing.country),
                style: muted,
              ),
              const SizedBox(height: AppSpacing.xs),
              Wrap(
                spacing: AppSpacing.md,
                runSpacing: AppSpacing.xxs,
                children: [
                  _HostListingAttribute(
                    icon: Icons.people_alt_outlined,
                    label: l10n.guestCount(listing.maxGuests),
                  ),
                  _HostListingAttribute(
                    icon: Icons.bed_outlined,
                    label: l10n.listingBeds(listing.beds),
                  ),
                  _HostListingAttribute(
                    icon: Icons.bathtub_outlined,
                    label: l10n.listingBathrooms(listing.bathrooms),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.xs),
              ListingNightlyPrice(
                listing: listing,
                style: textTheme.bodyLarge!,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HostListingAttribute extends StatelessWidget {
  const _HostListingAttribute({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    final colors = context.accommodationColors;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: AppIconSizes.sm, color: colors.textMuted),
        const SizedBox(width: AppSpacing.xxs),
        Text(
          label,
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(color: colors.textMuted),
        ),
      ],
    );
  }
}
