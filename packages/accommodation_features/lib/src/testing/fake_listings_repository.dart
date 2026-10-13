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
    this.listingFailure,
    this.availabilityFailure,
    this.bookings = const {},
    Map<String, List<DateTime>>? blockedDays,
    this.hostListings = const [],
    this.hostListingsFailure,
    this.updateFailure,
    this.blockedDaysFailure,
    this.blockFailure,
    this.unblockFailure,
  }) : facets = facets ?? createTestFacets(),
       blockedDays = {
         for (final entry in (blockedDays ?? const {}).entries)
           entry.key: [...entry.value],
       },
       super(ListingsRemoteDataSource(Dio()));

  List<Listing> listings;
  List<Listing> hostListings;

  Map<String, List<StayDates>> bookings;

  /// Days a host took off sale, keyed by listing id.
  Map<String, List<DateTime>> blockedDays;
  ListingFacets facets;
  int pageSize;
  ApiFailure? listingsFailure;
  ApiFailure? facetsFailure;
  ApiFailure? listingFailure;
  ApiFailure? availabilityFailure;
  ApiFailure? hostListingsFailure;
  ApiFailure? updateFailure;
  ApiFailure? blockedDaysFailure;
  ApiFailure? blockFailure;
  ApiFailure? unblockFailure;

  /// Fails a block request for this day only, to leave a range half done.
  DateTime? failBlockOn;

  Completer<void>? pendingResponse;
  Completer<void>? pendingMutation;

  final hostListingsRequests = <({String? cursor, int? limit})>[];
  final updateRequests = <({String id, Map<String, dynamic> changes})>[];
  final blockRequests = <DateTime>[];
  final unblockRequests = <DateTime>[];
  Completer<void>? pendingAvailability;

  final requests = <ListingsRequest>[];

  final listingRequests = <({String id, String language})>[];

  final availabilityRequests = <({String id, DateTime from, DateTime to})>[];

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
  Future<Either<ApiFailure, Listing>> fetchListing({
    required String id,
    required String language,
  }) async {
    listingRequests.add((id: id, language: language));
    await pendingResponse?.future;

    final failure = listingFailure;
    if (failure != null) return Left(failure);

    final listing = listings.where((listing) => listing.id == id).firstOrNull;
    return listing == null
        ? const Left(ApiFailure(type: ApiFailureType.http, statusCode: 404))
        : Right(listing);
  }

  @override
  Future<Either<ApiFailure, ListingAvailability>> fetchAvailability({
    required String id,
    required DateTime from,
    required DateTime to,
  }) async {
    availabilityRequests.add((id: id, from: from, to: to));
    await pendingAvailability?.future;

    final failure = availabilityFailure;
    if (failure != null) return Left(failure);

    final start = StayDates.calendarDate(from);
    final end = StayDates.calendarDate(to);
    bool inWindow(DateTime day) => !day.isBefore(start) && day.isBefore(end);

    final reasons = <DateTime, UnavailableReason>{
      for (final day in blockedDays[id] ?? const <DateTime>[])
        StayDates.calendarDate(day): UnavailableReason.blocked,
    };
    for (final booking in bookings[id] ?? const <StayDates>[]) {
      for (
        var night = booking.checkIn;
        night.isBefore(booking.checkOut);
        night = night.add(const Duration(days: 1))
      ) {
        reasons[night] = UnavailableReason.booked;
      }
    }

    final days = reasons.keys.where(inWindow).toList()..sort();
    return Right(
      ListingAvailability(
        listingId: id,
        from: start,
        to: end,
        unavailable: [
          for (final day in days)
            UnavailableDay(date: day, reason: reasons[day]!),
        ],
      ),
    );
  }

  @override
  Future<Either<ApiFailure, ListingFacets>> fetchFacets() async {
    facetsRequests += 1;
    final failure = facetsFailure;
    return failure == null ? Right(facets) : Left(failure);
  }

  @override
  Future<Either<ApiFailure, CursorPage<Listing>>> fetchHostListings({
    String? cursor,
    int? limit,
  }) async {
    hostListingsRequests.add((cursor: cursor, limit: limit));
    await pendingResponse?.future;

    final failure = hostListingsFailure;
    if (failure != null) return Left(failure);

    final offset = cursor == null ? 0 : int.parse(cursor);
    final end = math.min(offset + (limit ?? pageSize), hostListings.length);

    return Right(
      CursorPage(
        items: hostListings.sublist(offset, end),
        totalCount: hostListings.length,
        nextCursor: end < hostListings.length ? '$end' : null,
      ),
    );
  }

  @override
  Future<Either<ApiFailure, Listing>> updateHostListing({
    required String id,
    required Map<String, dynamic> changes,
  }) async {
    updateRequests.add((id: id, changes: changes));
    await pendingMutation?.future;

    final failure = updateFailure;
    if (failure != null) return Left(failure);

    final listing = [
      ...hostListings,
      ...listings,
    ].where((listing) => listing.id == id).firstOrNull;
    if (listing == null) {
      return const Left(
        ApiFailure(
          type: ApiFailureType.http,
          statusCode: 404,
          messageCode: 'listing.NotFoundException',
        ),
      );
    }

    final json = listing.toJson()..addAll(changes);
    return Right(Listing.fromJson(json));
  }

  @override
  Future<Either<ApiFailure, List<BlockedDay>>> fetchBlockedDays({
    required String listingId,
  }) async {
    final failure = blockedDaysFailure;
    if (failure != null) return Left(failure);

    final days = {
      for (final day in blockedDays[listingId] ?? const <DateTime>[])
        StayDates.calendarDate(day),
    }.toList()..sort();

    return Right([
      for (final day in days) BlockedDay(listingId: listingId, date: day),
    ]);
  }

  @override
  Future<Either<ApiFailure, BlockedDay>> blockDay({
    required String listingId,
    required DateTime date,
  }) async {
    blockRequests.add(date);
    await pendingMutation?.future;

    final failure = blockFailure;
    if (failure != null) return Left(failure);
    if (failBlockOn == date) {
      return const Left(ApiFailure(type: ApiFailureType.network));
    }

    (blockedDays[listingId] ??= []).add(date);
    return Right(BlockedDay(listingId: listingId, date: date));
  }

  @override
  Future<Either<ApiFailure, void>> unblockDay({
    required String listingId,
    required DateTime date,
  }) async {
    unblockRequests.add(date);
    await pendingMutation?.future;

    final failure = unblockFailure;
    if (failure != null) return Left(failure);

    blockedDays[listingId]?.removeWhere(
      (day) => StayDates.calendarDate(day) == date,
    );
    return const Right(null);
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
