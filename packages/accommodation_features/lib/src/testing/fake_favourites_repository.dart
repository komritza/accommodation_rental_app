import 'dart:async';

import 'package:accommodation_core/accommodation_core.dart';
import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';

class FakeFavouritesRepository extends FavouritesRepository {
  FakeFavouritesRepository({this.favourites = const [], this.fetchFailure})
    : super(FavouritesRemoteDataSource(Dio()));

  List<Listing> favourites;
  ApiFailure? fetchFailure;

  final updateFailures = <String, ApiFailure>{};

  final pendingUpdates = <String, Completer<void>>{};

  int fetchRequests = 0;
  final added = <String>[];
  final removed = <String>[];

  @override
  Future<Either<ApiFailure, List<Listing>>> fetchFavourites() async {
    fetchRequests += 1;
    final failure = fetchFailure;
    return failure == null ? Right(favourites) : Left(failure);
  }

  @override
  Future<Either<ApiFailure, void>> addFavourite({
    required String listingId,
  }) async {
    added.add(listingId);
    return _update(listingId);
  }

  @override
  Future<Either<ApiFailure, void>> removeFavourite({
    required String listingId,
  }) async {
    removed.add(listingId);
    return _update(listingId);
  }

  Future<Either<ApiFailure, void>> _update(String listingId) async {
    await pendingUpdates[listingId]?.future;
    final failure = updateFailures[listingId];
    return failure == null ? const Right(null) : Left(failure);
  }
}
