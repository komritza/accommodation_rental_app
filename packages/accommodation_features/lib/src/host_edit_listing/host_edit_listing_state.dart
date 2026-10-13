import 'package:accommodation_core/accommodation_core.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'host_edit_listing_state.freezed.dart';

@freezed
abstract class HostEditListingState with _$HostEditListingState {
  const factory HostEditListingState({
    required Listing originalListing,
    required String title,
    required String description,
    required num pricePerNight,
    required num cleaningFee,
    required int maxGuests,
    required int bedrooms,
    required int beds,
    required int bathrooms,
    required String propertyType,
    required List<String> amenities,
    @Default(false) bool isSaving,
    ApiFailure? saveFailure,
  }) = _HostEditListingState;

  const HostEditListingState._();

  factory HostEditListingState.fromListing(Listing listing) {
    return HostEditListingState(
      originalListing: listing,
      title: listing.title,
      description: listing.description,
      pricePerNight: listing.pricePerNight,
      cleaningFee: listing.cleaningFee,
      maxGuests: listing.maxGuests,
      bedrooms: listing.bedrooms,
      beds: listing.beds,
      bathrooms: listing.bathrooms,
      propertyType: listing.propertyType,
      amenities: listing.amenities,
    );
  }

  bool get hasChanges => changes.isNotEmpty;

  /// Only the fields that differ from [originalListing], as the PATCH body.
  /// Text is compared trimmed, since the API trims it before storing.
  Map<String, dynamic> get changes {
    final original = originalListing;

    return {
      if (title.trim() != original.title) 'title': title.trim(),
      if (description.trim() != original.description)
        'description': description.trim(),
      if (pricePerNight != original.pricePerNight)
        'pricePerNight': pricePerNight,
      if (cleaningFee != original.cleaningFee) 'cleaningFee': cleaningFee,
      if (maxGuests != original.maxGuests) 'maxGuests': maxGuests,
      if (bedrooms != original.bedrooms) 'bedrooms': bedrooms,
      if (beds != original.beds) 'beds': beds,
      if (bathrooms != original.bathrooms) 'bathrooms': bathrooms,
      if (propertyType != original.propertyType) 'propertyType': propertyType,
      if (!listEquals(amenities, original.amenities)) 'amenities': amenities,
    };
  }
}
