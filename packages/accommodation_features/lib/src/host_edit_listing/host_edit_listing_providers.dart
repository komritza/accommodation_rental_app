import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../host_home/host_listings_controller.dart';
import '../listing_detail/listing_detail_providers.dart';
import '../listings/listings_providers.dart';
import 'host_edit_listing_state.dart';

part 'host_edit_listing_providers.g.dart';

@riverpod
class HostEditListingController extends _$HostEditListingController {
  @override
  Future<HostEditListingState> build(
    String listingId, {
    required String language,
  }) async {
    final result = await ref
        .watch(listingsRepositoryProvider)
        .fetchListing(id: listingId, language: language);

    return result.match(
      (failure) => throw ListingsLoadException(failure),
      HostEditListingState.fromListing,
    );
  }

  void updateTitle(String value) => _update((s) => s.copyWith(title: value));

  void updateDescription(String value) =>
      _update((s) => s.copyWith(description: value));

  void updatePricePerNight(num value) =>
      _update((s) => s.copyWith(pricePerNight: value));

  void updateCleaningFee(num value) =>
      _update((s) => s.copyWith(cleaningFee: value));

  void updateMaxGuests(int value) =>
      _update((s) => s.copyWith(maxGuests: value));

  void updateBedrooms(int value) => _update((s) => s.copyWith(bedrooms: value));

  void updateBeds(int value) => _update((s) => s.copyWith(beds: value));

  void updateBathrooms(int value) =>
      _update((s) => s.copyWith(bathrooms: value));

  void updatePropertyType(String value) =>
      _update((s) => s.copyWith(propertyType: value));

  void toggleAmenity(String amenity) => _update(
    (s) => s.copyWith(
      amenities: s.amenities.contains(amenity)
          ? [
              for (final current in s.amenities)
                if (current != amenity) current,
            ]
          : [...s.amenities, amenity],
    ),
  );

  void _update(HostEditListingState Function(HostEditListingState) transform) {
    final current = state.value;
    if (current == null || current.isSaving) return;

    state = AsyncData(transform(current).copyWith(saveFailure: null));
  }

  /// Sends only the changed fields. On success the listing detail and the
  /// host's list pick up the saved listing.
  Future<bool> save() async {
    final current = state.value;
    if (current == null || current.isSaving || !current.hasChanges) {
      return false;
    }

    state = AsyncData(current.copyWith(isSaving: true, saveFailure: null));

    final result = await ref
        .read(listingsRepositoryProvider)
        .updateHostListing(id: listingId, changes: current.changes);

    if (!ref.mounted) return false;

    return result.match(
      (failure) {
        state = AsyncData(
          current.copyWith(isSaving: false, saveFailure: failure),
        );
        return false;
      },
      (updated) {
        state = AsyncData(HostEditListingState.fromListing(updated));
        ref.invalidate(listingDetailProvider(listingId, language: language));
        if (ref.exists(hostListingsControllerProvider)) {
          ref
              .read(hostListingsControllerProvider.notifier)
              .replaceListing(updated);
        }
        return true;
      },
    );
  }
}
