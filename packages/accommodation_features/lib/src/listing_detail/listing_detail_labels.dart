import 'package:accommodation_core/accommodation_core.dart';
import 'package:accommodation_ui/accommodation_ui.dart';

String amenityLabel(AppLocalizations l10n, String slug) {
  return switch (slug) {
    'wifi' => l10n.amenityWifi,
    'kitchen' => l10n.amenityKitchen,
    'parking' => l10n.amenityParking,
    'washer' => l10n.amenityWasher,
    'dryer' => l10n.amenityDryer,
    'air_conditioning' => l10n.amenityAirConditioning,
    'heating' => l10n.amenityHeating,
    'tv' => l10n.amenityTv,
    'pool' => l10n.amenityPool,
    'hot_tub' => l10n.amenityHotTub,
    'fireplace' => l10n.amenityFireplace,
    'balcony' => l10n.amenityBalcony,
    'sea_view' => l10n.amenitySeaView,
    'mountain_view' => l10n.amenityMountainView,
    'ski_storage' => l10n.amenitySkiStorage,
    'pets_allowed' => l10n.amenityPetsAllowed,
    'workspace' => l10n.amenityWorkspace,
    'elevator' => l10n.amenityElevator,
    'bbq' => l10n.amenityBbq,
    'sauna' => l10n.amenitySauna,
    _ => slug.humanized,
  };
}

String listingFactsSummary(AppLocalizations l10n, Listing listing) {
  return [
    if (listing.maxGuests > 0) l10n.guestCount(listing.maxGuests),
    if (listing.bedrooms > 0) l10n.listingBedrooms(listing.bedrooms),
    if (listing.beds > 0) l10n.listingBeds(listing.beds),
    if (listing.bathrooms > 0) l10n.listingBathrooms(listing.bathrooms),
  ].join(' · ');
}
