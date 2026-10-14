import 'package:dio/dio.dart';

import '../models/listing.dart';
import '../networking/api_paths.dart';

class FavouritesRemoteDataSource {
  const FavouritesRemoteDataSource(this._dio);

  final Dio _dio;

  Future<List<Listing>> fetchFavourites() async {
    final response = await _dio.get<List<dynamic>>(ApiPaths.favourites);

    final data = response.data;
    if (data == null) {
      throw const FormatException(
        'Expected a JSON array in the favourites response.',
      );
    }

    return data
        .map((item) => Listing.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  Future<void> addFavourite({required String listingId}) async {
    await _dio.post<Map<String, dynamic>>(
      ApiPaths.favourites,
      data: {'listingId': listingId},
    );
  }

  Future<void> removeFavourite({required String listingId}) async {
    await _dio.delete<void>(ApiPaths.favourite(listingId));
  }
}
