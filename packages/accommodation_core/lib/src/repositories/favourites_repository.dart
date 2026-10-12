import 'package:fpdart/fpdart.dart';

import '../data/favourites_remote_data_source.dart';
import '../models/listing.dart';
import '../networking/api_call.dart';
import '../networking/api_failure.dart';

class FavouritesRepository {
  const FavouritesRepository(this._remoteDataSource);

  final FavouritesRemoteDataSource _remoteDataSource;

  Future<Either<ApiFailure, List<Listing>>> fetchFavourites() {
    return runApiCall(_remoteDataSource.fetchFavourites);
  }

  Future<Either<ApiFailure, void>> addFavourite({required String listingId}) {
    return runApiCall(
      () => _remoteDataSource.addFavourite(listingId: listingId),
    );
  }

  Future<Either<ApiFailure, void>> removeFavourite({
    required String listingId,
  }) {
    return runApiCall(
      () => _remoteDataSource.removeFavourite(listingId: listingId),
    );
  }
}
