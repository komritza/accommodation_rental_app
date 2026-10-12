import 'package:fpdart/fpdart.dart';

import '../data/listings_remote_data_source.dart';
import '../models/listing.dart';
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

  Future<Either<ApiFailure, ListingFacets>> fetchFacets() {
    return runApiCall(_remoteDataSource.fetchFacets);
  }
}
