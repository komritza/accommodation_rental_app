import 'package:accommodation_core/accommodation_core.dart';
import 'package:dio/dio.dart';

class ListingsRemoteDataSource {
  const ListingsRemoteDataSource(this._dio);

  final Dio _dio;

  Future<CursorPage<Listing>> fetchListings({
    required ListingSearchQuery query,
    String? cursor,
    int? limit,
  }) async {
    final response = await _dio.get<List<dynamic>>(
      ApiPaths.listings,
      queryParameters: {
        ...query.toQueryParameters(),
        'limit': ?limit,
        'nextCursor': ?cursor,
      },
    );

    return _listingsPage(response);
  }

  Future<Listing> fetchListing({
    required String id,
    required String language,
  }) async {
    final response = await _dio.get<Map<String, dynamic>>(
      ApiPaths.listingDetails(id),
      queryParameters: {'language': language},
    );

    final data = response.data;
    if (data == null || data.isEmpty) {
      throw const FormatException(
        'Expected a non-empty JSON object in the API response.',
      );
    }

    return Listing.fromJson(data);
  }

  Future<ListingAvailability> fetchAvailability({
    required String id,
    required DateTime from,
    required DateTime to,
  }) async {
    final response = await _dio.get<Map<String, dynamic>>(
      ApiPaths.listingDetailsAvailability(id),
      queryParameters: {
        'from': StayDates.isoDate(from),
        'to': StayDates.isoDate(to),
      },
    );

    final data = response.data;
    if (data == null) {
      throw const FormatException(
        'Expected a JSON object in the API response.',
      );
    }

    return ListingAvailability.fromJson(data);
  }

  Future<ListingFacets> fetchFacets() async {
    final response = await _dio.get<Map<String, dynamic>>(
      ApiPaths.listingsFacets,
    );

    final data = response.data;
    if (data == null) {
      throw const FormatException(
        'Expected a JSON object in the API response.',
      );
    }

    return ListingFacets.fromJson(data);
  }

  Future<CursorPage<Listing>> fetchHostListings({
    String? cursor,
    int? limit,
  }) async {
    final response = await _dio.get<List<dynamic>>(
      ApiPaths.hostListings,
      queryParameters: {'limit': ?limit, 'nextCursor': ?cursor},
    );

    return _listingsPage(response);
  }

  Future<Listing> updateHostListing({
    required String id,
    required Map<String, dynamic> changes,
  }) async {
    final response = await _dio.patch<Map<String, dynamic>>(
      ApiPaths.hostListing(id),
      data: changes,
    );

    final data = response.data;
    if (data == null) {
      throw const FormatException(
        'Expected a JSON object in the API response.',
      );
    }

    return Listing.fromJson(data);
  }

  Future<CursorPage<Booking>> fetchHostBookings({
    required String listingId,
    String? cursor,
    int? limit,
  }) async {
    final response = await _dio.get<List<dynamic>>(
      ApiPaths.hostListingBookings(listingId),
      queryParameters: {'limit': ?limit, 'nextCursor': ?cursor},
    );

    return _page(response, Booking.fromJson);
  }

  Future<List<BlockedDay>> fetchBlockedDays({required String listingId}) async {
    final response = await _dio.get<List<dynamic>>(
      ApiPaths.hostListingBlockedDays(listingId),
    );

    final data = response.data;
    if (data == null) {
      throw const FormatException('Expected a JSON array in the API response.');
    }

    return data
        .map((item) => BlockedDay.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  Future<BlockedDay> blockDay({
    required String listingId,
    required DateTime date,
  }) async {
    final response = await _dio.post<Map<String, dynamic>>(
      ApiPaths.hostListingBlockedDays(listingId),
      data: {'date': StayDates.isoDate(date)},
    );

    final data = response.data;
    if (data == null || data.isEmpty) {
      throw const FormatException(
        'Expected a JSON object in the API response.',
      );
    }

    return BlockedDay.fromJson(data);
  }

  Future<void> unblockDay({
    required String listingId,
    required DateTime date,
  }) async {
    await _dio.delete<void>(
      ApiPaths.hostListingBlockedDay(listingId, StayDates.isoDate(date)),
    );
  }
}

CursorPage<Listing> _listingsPage(Response<List<dynamic>> response) {
  return _page(response, Listing.fromJson);
}

CursorPage<T> _page<T>(
  Response<List<dynamic>> response,
  T Function(Map<String, dynamic> json) fromJson,
) {
  final data = response.data;
  if (data == null) {
    throw const FormatException('Expected a JSON array in the API response.');
  }

  return CursorPage(
    items: data.map((item) => fromJson(item as Map<String, dynamic>)).toList(),
    totalCount: int.tryParse(response.headers.value('x-total-count') ?? ''),
    nextCursor: _parseCursor(response.headers.value('x-next-cursor')),
  );
}

/// The API marks the end of the list with the string `"null"`.
String? _parseCursor(String? value) {
  if (value == null || value.isEmpty || value == 'null') {
    return null;
  }

  return value;
}
