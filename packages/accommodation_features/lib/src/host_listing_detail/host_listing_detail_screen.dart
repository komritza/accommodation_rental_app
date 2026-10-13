import 'package:accommodation_core/accommodation_core.dart';
import 'package:accommodation_features/dependencies.dart';
import 'package:accommodation_ui/accommodation_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../guest_home/guest_filter_labels.dart';
import '../listing_detail/listing_detail_providers.dart';
import '../listing_detail/widgets/listing_detail_image_carousel.dart';

class HostListingDetailScreen extends ConsumerWidget {
  const HostListingDetailScreen({
    super.key,
    required this.listingId,
    required this.onEditPressed,
    required this.onManageBlockedDaysPressed,
  });

  final String listingId;
  final VoidCallback onEditPressed;
  final VoidCallback onManageBlockedDaysPressed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final language = Localizations.localeOf(context).languageCode;

    final runtimeConfig = ref.watch(runtimeConfigProvider);
    final canManageBlockedDays = runtimeConfig.when(
      data: (config) => config.permissions.blockedDays,
      loading: () => false,
      error: (_, _) => false,
    );

    final provider = listingDetailProvider(listingId, language: language);
    final listing = ref.watch(provider);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.hostListingDetailTitle),
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
              title: l10n.hostListingDetailLoadErrorTitle,
              message: l10n.hostListingDetailLoadErrorMessage,
              action: FilledButton(
                onPressed: () => ref.invalidate(provider),
                child: Text(l10n.retry),
              ),
            ),
          ),
        ),
        data: (listing) => _HostListingDetailContent(
          listing: listing,
          onEditPressed: onEditPressed,
          canManageBlockedDays: canManageBlockedDays,
          onManageBlockedDaysPressed: onManageBlockedDaysPressed,
        ),
      ),
    );
  }
}

class _HostListingDetailContent extends StatelessWidget {
  const _HostListingDetailContent({
    required this.listing,
    required this.onEditPressed,
    required this.canManageBlockedDays,
    required this.onManageBlockedDaysPressed,
  });

  final Listing listing;
  final VoidCallback onEditPressed;
  final bool canManageBlockedDays;
  final VoidCallback onManageBlockedDaysPressed;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colors = context.accommodationColors;
    final textTheme = Theme.of(context).textTheme;
    final locale = Localizations.localeOf(context).toLanguageTag();

    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
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
                    const SizedBox(height: AppSpacing.lg),
                    Text(listing.title, style: textTheme.headlineMedium),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      l10n.listingLocation(listing.city, listing.country),
                      style: textTheme.bodyLarge?.copyWith(
                        color: colors.textMuted,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    const Divider(),
                    const SizedBox(height: AppSpacing.md),
                    Text(
                      l10n.hostListingDetailPropertyInfo,
                      style: textTheme.titleLarge,
                    ),
                    const SizedBox(height: AppSpacing.md),
                    _DetailRow(
                      icon: Icons.home_outlined,
                      label: l10n.hostListingDetailPropertyType,
                      value: listing.propertyType.capitalizeFirst(),
                    ),
                    _DetailRow(
                      icon: Icons.people_outline,
                      label: l10n.hostListingDetailMaxGuests,
                      value: '${listing.maxGuests}',
                    ),
                    _DetailRow(
                      icon: Icons.bedroom_parent_outlined,
                      label: l10n.hostListingDetailBedrooms,
                      value: '${listing.bedrooms}',
                    ),
                    _DetailRow(
                      icon: Icons.bed_outlined,
                      label: l10n.hostListingDetailBeds,
                      value: '${listing.beds}',
                    ),
                    _DetailRow(
                      icon: Icons.bathroom_outlined,
                      label: l10n.hostListingDetailBathrooms,
                      value: '${listing.bathrooms}',
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    Text(
                      l10n.hostListingDetailPricing,
                      style: textTheme.titleLarge,
                    ),
                    const SizedBox(height: AppSpacing.md),
                    _DetailRow(
                      icon: Icons.money_outlined,
                      label: l10n.hostListingDetailPricePerNight,
                      value: formatGuestPrice(
                        listing.pricePerNight,
                        currencyCode: listing.currency,
                        locale: locale,
                      ),
                    ),
                    _DetailRow(
                      icon: Icons.cleaning_services,
                      label: l10n.hostListingDetailCleaningFee,
                      value: formatGuestPrice(
                        listing.cleaningFee,
                        currencyCode: listing.currency,
                        locale: locale,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    Text(
                      l10n.hostListingDetailDescription,
                      style: textTheme.titleLarge,
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(listing.description, style: textTheme.bodyMedium),
                    const SizedBox(height: AppSpacing.md),
                  ],
                ),
              ),
            ),
          ),
        ),
        SafeArea(
          top: false,
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: AppLayoutTokens.contentMaxWidth,
              ),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  border: Border(
                    top: BorderSide(color: Theme.of(context).dividerColor),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (canManageBlockedDays) ...[
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton.icon(
                          onPressed: onManageBlockedDaysPressed,
                          icon: const Icon(Icons.calendar_month_outlined),
                          label: Text(l10n.hostBlockedDaysManageButton),
                        ),
                      ),
                      const SizedBox(height: AppSpacing.md),
                    ],
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton.icon(
                        onPressed: onEditPressed,
                        icon: const Icon(Icons.edit_outlined),
                        label: Text(l10n.hostListingDetailEditButton),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({required this.label, required this.value, this.icon});

  final String label;
  final String value;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final colors = context.accommodationColors;
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (icon != null) ...[
            Icon(icon, size: AppIconSizes.md, color: colors.textMuted),
            const SizedBox(width: AppSpacing.md),
          ],
          Expanded(
            child: Text(
              label,
              style: textTheme.bodyMedium?.copyWith(color: colors.textMuted),
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}
