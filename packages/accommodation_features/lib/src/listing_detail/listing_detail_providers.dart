import 'package:accommodation_core/accommodation_core.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../common/guest_calendar.dart';
import '../listings/listings_providers.dart';

part 'listing_detail_providers.g.dart';

@riverpod
Future<Listing> listingDetail(
  Ref ref,
  String listingId, {
  required String language,
}) async {
  final result = await ref
      .watch(listingsRepositoryProvider)
      .fetchListing(id: listingId, language: language);

  return result.match(
    (failure) => throw ListingsLoadException(failure),
    (listing) => listing,
  );
}

({DateTime from, DateTime to}) listingAvailabilityWindow(DateTime today) {
  return (
    from: today,
    to: today.add(const Duration(days: StayDates.maxNights)),
  );
}

@riverpod
Future<ListingAvailability> listingAvailability(
  Ref ref,
  String listingId,
) async {
  final window = listingAvailabilityWindow(
    ref.watch(guestCalendarTodayProvider),
  );
  final result = await ref
      .watch(listingsRepositoryProvider)
      .fetchAvailability(id: listingId, from: window.from, to: window.to);

  return result.match(
    (failure) => throw ListingsLoadException(failure),
    (availability) => availability,
  );
}
