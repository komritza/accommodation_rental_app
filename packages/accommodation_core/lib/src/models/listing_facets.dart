import 'package:freezed_annotation/freezed_annotation.dart';

part 'listing_facets.freezed.dart';
part 'listing_facets.g.dart';

@freezed
abstract class ListingFacets with _$ListingFacets {
  const factory ListingFacets({
    required List<String> cities,
    required List<String> propertyTypes,
    required List<String> amenities,
    required num priceMin,
    required num priceMax,
    required int maxGuests,
    required String currency,
  }) = _ListingFacets;

  factory ListingFacets.fromJson(Map<String, dynamic> json) =>
      _$ListingFacetsFromJson(json);
}
