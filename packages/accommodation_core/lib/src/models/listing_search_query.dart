import 'package:freezed_annotation/freezed_annotation.dart';

import 'stay_dates.dart';

part 'listing_search_query.freezed.dart';

@freezed
abstract class ListingSearchQuery with _$ListingSearchQuery {
  const ListingSearchQuery._();

  const factory ListingSearchQuery({
    String? city,
    int? guests,
    num? minPrice,
    num? maxPrice,
    StayDates? dates,
  }) = _ListingSearchQuery;

  bool get hasPriceRange => minPrice != null && maxPrice != null;

  bool get isEmpty =>
      city == null && guests == null && !hasPriceRange && dates == null;

  Map<String, Object> toQueryParameters() {
    return {
      'city': ?city,
      'guests': ?guests,
      'minPrice': ?minPrice,
      'maxPrice': ?maxPrice,
      'checkIn': ?dates?.checkInIso,
      'checkOut': ?dates?.checkOutIso,
    };
  }
}
