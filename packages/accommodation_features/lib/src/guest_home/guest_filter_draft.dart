import 'dart:math' as math;

import 'package:accommodation_core/accommodation_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'
    show ProviderListenableSelect;
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../listings/listings_providers.dart';
import 'guest_listing_filters.dart';

part 'guest_filter_draft.freezed.dart';
part 'guest_filter_draft.g.dart';

const guestFilterCountDebounce = Duration(milliseconds: 300);

const guestCalendarMonthsAhead = 12;

typedef PriceBounds = ({int min, int max});

PriceBounds priceBoundsOf(ListingFacets facets) {
  final min = facets.priceMin.floor();
  return (min: min, max: math.max(min, facets.priceMax.ceil()));
}

@riverpod
DateTime guestCalendarToday(Ref ref) => StayDates.calendarDate(DateTime.now());

@freezed
abstract class GuestFilterDraftState with _$GuestFilterDraftState {
  const factory GuestFilterDraftState({
    required ListingSearchQuery filters,

    DateTime? pendingCheckIn,
  }) = _GuestFilterDraftState;
}

@riverpod
class GuestFilterDraft extends _$GuestFilterDraft {
  @override
  GuestFilterDraftState build() =>
      GuestFilterDraftState(filters: ref.watch(guestListingFiltersProvider));

  ListingSearchQuery get _filters => state.filters;

  void _update(ListingSearchQuery filters) =>
      state = state.copyWith(filters: filters);

  void selectCity(String? city) => _update(_filters.copyWith(city: city));

  void selectDay(DateTime day) {
    final checkIn = state.pendingCheckIn;
    if (checkIn != null &&
        StayDates.isValidLength(StayDates.nightsBetween(checkIn, day))) {
      state = GuestFilterDraftState(
        filters: _filters.copyWith(
          dates: StayDates(checkIn: checkIn, checkOut: day),
        ),
      );
      return;
    }

    state = GuestFilterDraftState(
      filters: _filters.copyWith(dates: null),
      pendingCheckIn: StayDates.calendarDate(day),
    );
  }

  void incrementGuests({required int maxGuests}) {
    final guests = _filters.guests ?? 1;
    if (guests >= maxGuests) return;

    _update(_filters.copyWith(guests: guests + 1));
  }

  void decrementGuests() {
    final guests = _filters.guests ?? 1;
    if (guests <= 1) return;

    _update(_filters.copyWith(guests: guests - 1 <= 1 ? null : guests - 1));
  }

  void setPriceRange({
    required num min,
    required num max,
    required PriceBounds bounds,
  }) {
    final coversEverything = min <= bounds.min && max >= bounds.max;
    _update(
      coversEverything
          ? _filters.copyWith(minPrice: null, maxPrice: null)
          : _filters.copyWith(minPrice: min, maxPrice: max),
    );
  }

  void clear() =>
      state = const GuestFilterDraftState(filters: ListingSearchQuery());
}

@riverpod
Future<int> guestFilterResultCount(Ref ref) async {
  final filters = ref.watch(
    guestFilterDraftProvider.select((draft) => draft.filters),
  );

  await Future<void>.delayed(guestFilterCountDebounce);
  if (!ref.mounted) return 0;

  final result = await ref
      .read(listingsRepositoryProvider)
      .fetchListings(query: filters, limit: 1);

  return result.match(
    (failure) => throw ListingsLoadException(failure),
    (page) => page.totalCount ?? page.items.length,
  );
}
