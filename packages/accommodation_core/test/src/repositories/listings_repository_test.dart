import 'package:accommodation_core/accommodation_core.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

Map<String, dynamic> _listingJson({
  String id = 'lst_00001',
  Object rating = 4.62,
}) {
  return {
    'id': id,
    'tenantId': 'alpine',
    'hostId': 'host-alpine-1',
    'title': 'Sunlit Quarters in Lucerne',
    'description': 'A sunlit apartment.',
    'city': 'Lucerne',
    'country': 'CH',
    'address': 'Bahnhofstrasse 153',
    'latitude': 47.045569,
    'longitude': 8,
    'propertyType': 'apartment',
    'maxGuests': 2,
    'bedrooms': 1,
    'beds': 1,
    'bathrooms': 1,
    'pricePerNight': 173,
    'cleaningFee': 0,
    'currency': 'CHF',
    'amenities': ['wifi', 'unknown_amenity'],
    'rating': rating,
    'reviewsCount': 98,
    'images': ['https://picsum.photos/seed/a/1200/800'],
    'createdAt': '2026-01-01T10:00:00.000Z',
  };
}

Map<String, List<String>> _pageHeaders({
  required String total,
  required String next,
}) {
  return {
    Headers.contentTypeHeader: [Headers.jsonContentType],
    'x-total-count': [total],
    'x-next-cursor': [next],
    'x-prev-cursor': ['null'],
  };
}

void main() {
  late Dio dio;
  late DioAdapter adapter;
  late ListingsRepository repository;

  setUp(() {
    dio = Dio(BaseOptions(baseUrl: 'https://test.example.com'));
    adapter = DioAdapter(dio: dio);
    dio.httpClientAdapter = adapter;
    repository = ListingsRepository(ListingsRemoteDataSource(dio));
  });

  group('fetchListings', () {
    test('sends only the filters that are set, plus the cursor', () async {
      adapter.onGet(
        '/listings',
        (server) => server.reply(200, [
          _listingJson(),
        ], headers: _pageHeaders(total: '41', next: 'cursor-2')),
        queryParameters: {
          'city': 'Lucerne',
          'guests': 3,
          'minPrice': 100,
          'maxPrice': 250,
          'limit': 20,
          'nextCursor': 'cursor-1',
        },
      );

      final result = await repository.fetchListings(
        query: const ListingSearchQuery(
          city: 'Lucerne',
          guests: 3,
          minPrice: 100,
          maxPrice: 250,
        ),
        cursor: 'cursor-1',
        limit: 20,
      );

      result.match((failure) => fail('Unexpected failure: ${failure.type}'), (
        page,
      ) {
        expect(page.items.single.id, 'lst_00001');
        expect(page.totalCount, 41);
        expect(page.nextCursor, 'cursor-2');
        expect(page.hasNextPage, isTrue);
      });
    });

    test(
      'sends the stay as an inclusive check-in and exclusive check-out',
      () async {
        adapter.onGet(
          '/listings',
          (server) => server.reply(200, [
            _listingJson(),
          ], headers: _pageHeaders(total: '1', next: 'null')),
          queryParameters: {'checkIn': '2026-03-01', 'checkOut': '2026-03-03'},
        );

        final result = await repository.fetchListings(
          query: ListingSearchQuery(
            dates: StayDates(
              checkIn: DateTime(2026, 3, 1),
              checkOut: DateTime(2026, 3, 3),
            ),
          ),
        );

        expect(result.isRight(), isTrue);
      },
    );

    test('treats the "null" cursor string as the end of the list', () async {
      adapter.onGet(
        '/listings',
        (server) => server.reply(200, [
          _listingJson(),
        ], headers: _pageHeaders(total: '1', next: 'null')),
        queryParameters: const <String, dynamic>{},
      );

      final result = await repository.fetchListings();

      result.match((failure) => fail('Unexpected failure: ${failure.type}'), (
        page,
      ) {
        expect(page.nextCursor, isNull);
        expect(page.hasNextPage, isFalse);
      });
    });

    test('decodes whole-number ratings and coordinates as doubles', () async {
      adapter.onGet(
        '/listings',
        (server) => server.reply(200, [
          _listingJson(rating: 5),
        ], headers: _pageHeaders(total: '1', next: 'null')),
        queryParameters: const <String, dynamic>{},
      );

      final result = await repository.fetchListings();

      result.match((failure) => fail('Unexpected failure: ${failure.type}'), (
        page,
      ) {
        expect(page.items.single.rating, 5.0);
        expect(page.items.single.longitude, 8.0);
      });
    });

    test('maps an HTTP error to a failure', () async {
      adapter.onGet(
        '/listings',
        (server) => server.reply(400, {
          'statusCode': 400,
          'messageCode': 'error.badRequest',
          'message': 'Bad request',
        }),
        queryParameters: const <String, dynamic>{},
      );

      final result = await repository.fetchListings();

      result.match((failure) {
        expect(failure.type, ApiFailureType.http);
        expect(failure.statusCode, 400);
      }, (_) => fail('Expected an HTTP failure'));
    });
  });

  group('fetchFacets', () {
    test('parses the filter vocabulary and bounds', () async {
      adapter.onGet(
        '/listings/facets',
        (server) => server.reply(200, {
          'cities': ['Lucerne', 'Zermatt'],
          'propertyTypes': ['apartment', 'chalet'],
          'amenities': ['wifi'],
          'priceMin': 85,
          'priceMax': 612.5,
          'maxGuests': 10,
          'currency': 'CHF',
        }),
      );

      final result = await repository.fetchFacets();

      result.match((failure) => fail('Unexpected failure: ${failure.type}'), (
        facets,
      ) {
        expect(facets.cities, ['Lucerne', 'Zermatt']);
        expect(facets.priceMin, 85);
        expect(facets.priceMax, 612.5);
        expect(facets.maxGuests, 10);
        expect(facets.currency, 'CHF');
      });
    });
  });

  group('ListingSearchQuery', () {
    test('reports whether any filter is set', () {
      expect(const ListingSearchQuery().isEmpty, isTrue);
      expect(const ListingSearchQuery(guests: 2).isEmpty, isFalse);
      expect(const ListingSearchQuery(minPrice: 10).hasPriceRange, isFalse);
      expect(
        ListingSearchQuery(
          dates: StayDates(
            checkIn: DateTime(2026, 3, 1),
            checkOut: DateTime(2026, 3, 2),
          ),
        ).isEmpty,
        isFalse,
      );
    });
  });

  group('StayDates', () {
    test('counts nights up to, but not including, check-out', () {
      final stay = StayDates(
        checkIn: DateTime(2026, 3, 1),
        checkOut: DateTime(2026, 3, 3),
      );

      expect(stay.nights, 2);
      expect(stay.checkInIso, '2026-03-01');
      expect(stay.checkOutIso, '2026-03-03');
    });

    test('ignores the time of day and daylight saving changes', () {
      final stay = StayDates(
        checkIn: DateTime(2026, 3, 28, 23, 30),
        checkOut: DateTime(2026, 3, 30, 0, 15),
      );

      expect(stay.nights, 2);
      expect(
        stay,
        StayDates(
          checkIn: DateTime.utc(2026, 3, 28),
          checkOut: DateTime.utc(2026, 3, 30),
        ),
      );
    });

    test('rejects stays the API would refuse', () {
      final day = DateTime(2026, 3, 1);

      expect(() => StayDates(checkIn: day, checkOut: day), throwsArgumentError);
      expect(
        () => StayDates(
          checkIn: day,
          checkOut: day.subtract(const Duration(days: 1)),
        ),
        throwsArgumentError,
      );
      expect(
        StayDates(checkIn: day, checkOut: DateTime(2027, 3, 2)).nights,
        StayDates.maxNights,
      );
      expect(
        () => StayDates(checkIn: day, checkOut: DateTime(2027, 3, 3)),
        throwsArgumentError,
      );
    });
  });
}
