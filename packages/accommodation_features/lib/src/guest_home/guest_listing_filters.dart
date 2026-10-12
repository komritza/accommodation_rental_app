import 'package:accommodation_core/accommodation_core.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'guest_listing_filters.g.dart';

@riverpod
class GuestListingFilters extends _$GuestListingFilters {
  @override
  ListingSearchQuery build() => const ListingSearchQuery();

  void apply(ListingSearchQuery filters) => state = filters;

  void clearDates() => state = state.copyWith(dates: null);

  void clearCity() => state = state.copyWith(city: null);

  void clearGuests() => state = state.copyWith(guests: null);

  void clearPriceRange() {
    state = state.copyWith(minPrice: null, maxPrice: null);
  }

  void clearAll() => state = const ListingSearchQuery();
}
