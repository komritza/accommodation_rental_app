import 'package:dio/dio.dart';

import '../models/listing.dart';
import '../models/listing_facets.dart';
import '../models/listing_search_query.dart';
import '../networking/cursor_page.dart';

class ListingsRemoteDataSource {
  const ListingsRemoteDataSource(this._dio);

  final Dio _dio;

  Future<CursorPage<Listing>> fetchListings({
    required ListingSearchQuery query,
    String? cursor,
    int? limit,
  }) async {
    final response = await _dio.get<List<dynamic>>(
      '/listings',
      queryParameters: {
        ...query.toQueryParameters(),
        'limit': ?limit,
        'nextCursor': ?cursor,
      },
    );

    final data = response.data;
    if (data == null) {
      throw const FormatException('Expected a JSON array in the API response.');
    }

    return CursorPage(
      items: data
          .map((item) => Listing.fromJson(item as Map<String, dynamic>))
          .toList(),
      totalCount: int.tryParse(response.headers.value('x-total-count') ?? ''),
      nextCursor: _parseCursor(response.headers.value('x-next-cursor')),
    );
  }

  Future<ListingFacets> fetchFacets() async {
    final response = await _dio.get<Map<String, dynamic>>('/listings/facets');

    final data = response.data;
    if (data == null) {
      throw const FormatException(
        'Expected a JSON object in the API response.',
      );
    }

    return ListingFacets.fromJson(data);
  }
}

/// The API marks the end of the list with the string `"null"`.
String? _parseCursor(String? value) {
  if (value == null || value.isEmpty || value == 'null') {
    return null;
  }

  return value;
}
