import 'package:accommodation_core/accommodation_core.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../common/dependencies.dart';

part 'listings_providers.g.dart';

@Riverpod(keepAlive: true)
ListingsRemoteDataSource listingsRemoteDataSource(Ref ref) {
  return ListingsRemoteDataSource(ref.watch(apiClientProvider));
}

@Riverpod(keepAlive: true)
ListingsRepository listingsRepository(Ref ref) {
  return ListingsRepository(ref.watch(listingsRemoteDataSourceProvider));
}

@riverpod
Future<ListingFacets> listingFacets(Ref ref) async {
  final result = await ref.watch(listingsRepositoryProvider).fetchFacets();

  return result.match(
    (failure) => throw ListingsLoadException(failure),
    (facets) => facets,
  );
}

class ListingsLoadException implements Exception {
  const ListingsLoadException(this.failure);

  final ApiFailure failure;

  @override
  String toString() {
    return failure.message ?? 'Unable to load listings.';
  }
}
