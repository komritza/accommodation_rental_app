import 'dart:async';
import 'dart:math' as math;

import 'package:accommodation_core/accommodation_core.dart';
import 'package:accommodation_core/testing.dart';
import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';

typedef ListingsRequest = ({
  ListingSearchQuery query,
  String? cursor,
  int? limit,
});

class FakeListingsRepository extends ListingsRepository {
  FakeListingsRepository({
    this.listings = const [],
    ListingFacets? facets,
    this.pageSize = 20,
    this.listingsFailure,
    this.facetsFailure,
    this.bookings = const {},
  }) : facets = facets ?? createTestFacets(),
       super(ListingsRemoteDataSource(Dio()));

  List<Listing> listings;

  Map<String, List<StayDates>> bookings;
  ListingFacets facets;
  int pageSize;
  ApiFailure? listingsFailure;
  ApiFailure? facetsFailure;

  Completer<void>? pendingResponse;

  final requests = <ListingsRequest>[];

  int facetsRequests = 0;

  @override
  Future<Either<ApiFailure, CursorPage<Listing>>> fetchListings({
    ListingSearchQuery query = const ListingSearchQuery(),
    String? cursor,
    int? limit,
  }) async {
    requests.add((query: query, cursor: cursor, limit: limit));
    await pendingResponse?.future;

    final failure = listingsFailure;
    if (failure != null) return Left(failure);

    final matching = listings.where((listing) => _matches(listing, query));
    final offset = cursor == null ? 0 : int.parse(cursor);
    final end = math.min(offset + (limit ?? pageSize), matching.length);

    return Right(
      CursorPage(
        items: matching.toList().sublist(offset, end),
        totalCount: matching.length,
        nextCursor: end < matching.length ? '$end' : null,
      ),
    );
  }

  @override
  Future<Either<ApiFailure, ListingFacets>> fetchFacets() async {
    facetsRequests += 1;
    final failure = facetsFailure;
    return failure == null ? Right(facets) : Left(failure);
  }

  bool _matches(Listing listing, ListingSearchQuery query) {
    final city = query.city;
    final guests = query.guests;
    final minPrice = query.minPrice;
    final maxPrice = query.maxPrice;
    final stay = query.dates;

    return (city == null || listing.city == city) &&
        (guests == null || listing.maxGuests >= guests) &&
        (minPrice == null || listing.pricePerNight >= minPrice) &&
        (maxPrice == null || listing.pricePerNight <= maxPrice) &&
        (stay == null || _isFree(listing.id, stay));
  }

  bool _isFree(String listingId, StayDates stay) {
    return !(bookings[listingId] ?? const []).any(
      (booking) =>
          stay.checkIn.isBefore(booking.checkOut) &&
          booking.checkIn.isBefore(stay.checkOut),
    );
  }
}
