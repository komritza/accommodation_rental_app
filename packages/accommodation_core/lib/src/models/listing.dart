import 'package:freezed_annotation/freezed_annotation.dart';

part 'listing.freezed.dart';
part 'listing.g.dart';

@freezed
abstract class Listing with _$Listing {
  const factory Listing({
    required String id,
    required String tenantId,
    required String hostId,
    required String title,
    required String description,
    required String city,
    required String country,
    required String address,
    required double latitude,
    required double longitude,
    required String propertyType,
    required int maxGuests,
    required int bedrooms,
    required int beds,
    required int bathrooms,
    required num pricePerNight,
    required num cleaningFee,
    required String currency,
    required List<String> amenities,
    required double rating,
    required int reviewsCount,
    required List<String> images,
    required DateTime createdAt,
  }) = _Listing;

  factory Listing.fromJson(Map<String, dynamic> json) =>
      _$ListingFromJson(json);
}
