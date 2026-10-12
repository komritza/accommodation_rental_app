import 'package:fpdart/fpdart.dart';

import '../data/listings_remote_data_source.dart';
import '../models/listing.dart';
import '../models/listing_availability.dart';
import '../models/listing_facets.dart';
import '../models/listing_search_query.dart';
import '../networking/api_call.dart';
import '../networking/api_failure.dart';
import '../networking/cursor_page.dart';

class ListingsRepository {
  const ListingsRepository(this._remoteDataSource);

  final ListingsRemoteDataSource _remoteDataSource;

  Future<Either<ApiFailure, CursorPage<Listing>>> fetchListings({
    ListingSearchQuery query = const ListingSearchQuery(),
    String? cursor,
    int? limit,
  }) {
    return runApiCall(
      () => _remoteDataSource.fetchListings(
        query: query,
        cursor: cursor,
        limit: limit,
      ),
    );
  }

  Future<Either<ApiFailure, Listing>> fetchListing({
    required String id,
    required String language,
  }) {
    return runApiCall(
      () => _remoteDataSource.fetchListing(id: id, language: language),
    );
  }

  Future<Either<ApiFailure, ListingAvailability>> fetchAvailability({
    required String id,
    required DateTime from,
    required DateTime to,
  }) {
    return runApiCall(
      () => _remoteDataSource.fetchAvailability(id: id, from: from, to: to),
    );
  }

  Future<Either<ApiFailure, ListingFacets>> fetchFacets() {
    return runApiCall(_remoteDataSource.fetchFacets);
  }
}
