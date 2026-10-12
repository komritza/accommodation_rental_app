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

  group('fetchListing', () {
    test('requests the listing in the given language', () async {
      adapter.onGet(
        '/listings/lst_00001',
        (server) => server.reply(200, _listingJson()),
        queryParameters: {'language': 'de'},
      );

      final result = await repository.fetchListing(
        id: 'lst_00001',
        language: 'de',
      );

      result.match((failure) => fail('Unexpected failure: ${failure.type}'), (
        listing,
      ) {
        expect(listing.id, 'lst_00001');
        expect(listing.amenities, ['wifi', 'unknown_amenity']);
      });
    });

    test('maps a missing listing to a 404 failure', () async {
      adapter.onGet(
        '/listings/missing',
        (server) => server.reply(404, {
          'statusCode': 404,
          'messageCode': 'error.notFound',
          'message': 'Not found',
        }),
        queryParameters: {'language': 'en'},
      );

      final result = await repository.fetchListing(
        id: 'missing',
        language: 'en',
      );

      result.match((failure) {
        expect(failure.type, ApiFailureType.http);
        expect(failure.statusCode, 404);
      }, (_) => fail('Expected an HTTP failure'));
    });

    test('rejects an empty response body', () async {
      adapter.onGet(
        '/listings/lst_00001',
        (server) => server.reply(200, <String, dynamic>{}),
        queryParameters: {'language': 'en'},
      );

      final result = await repository.fetchListing(
        id: 'lst_00001',
        language: 'en',
      );

      result.match(
        (failure) => expect(failure.type, ApiFailureType.invalidResponse),
        (_) => fail('Expected an invalid response failure'),
      );
    });
  });

  group('fetchAvailability', () {
    test('sends the window as calendar dates and parses taken days', () async {
      adapter.onGet(
        '/listings/lst_00001/availability',
        (server) => server.reply(200, {
          'listingId': 'lst_00001',
          'from': '2026-03-01',
          'to': '2027-03-02',
          'unavailable': [
            {'date': '2026-03-04', 'reason': 'booked'},
            {'date': '2026-03-05', 'reason': 'blocked'},
            {'date': '2026-03-06', 'reason': 'maintenance'},
          ],
        }),
        queryParameters: {'from': '2026-03-01', 'to': '2027-03-02'},
      );

      final result = await repository.fetchAvailability(
        id: 'lst_00001',
        from: DateTime(2026, 3, 1, 22, 30),
        to: DateTime.utc(2027, 3, 2),
      );

      result.match((failure) => fail('Unexpected failure: ${failure.type}'), (
        availability,
      ) {
        expect(availability.listingId, 'lst_00001');
        expect(availability.from, DateTime.utc(2026, 3, 1));
        expect(availability.to, DateTime.utc(2027, 3, 2));
        expect(availability.unavailable, [
          UnavailableDay(
            date: DateTime.utc(2026, 3, 4),
            reason: UnavailableReason.booked,
          ),
          UnavailableDay(
            date: DateTime.utc(2026, 3, 5),
            reason: UnavailableReason.blocked,
          ),
          UnavailableDay(
            date: DateTime.utc(2026, 3, 6),
            reason: UnavailableReason.booked,
          ),
        ]);
      });
    });

    test('maps a missing listing to a 404 failure', () async {
      adapter.onGet(
        '/listings/missing/availability',
        (server) => server.reply(404, {
          'statusCode': 404,
          'messageCode': 'listing.NotFoundException',
          'message': 'Not found',
        }),
        queryParameters: {'from': '2026-03-01', 'to': '2026-04-01'},
      );

      final result = await repository.fetchAvailability(
        id: 'missing',
        from: DateTime(2026, 3, 1),
        to: DateTime(2026, 4, 1),
      );

      result.match((failure) {
        expect(failure.type, ApiFailureType.http);
        expect(failure.statusCode, 404);
      }, (_) => fail('Expected an HTTP failure'));
    });

    test('maps a window the API refuses to a 400 failure', () async {
      adapter.onGet(
        '/listings/lst_00001/availability',
        (server) => server.reply(400, {
          'statusCode': 400,
          'messageCode': 'error.rangeTooLong',
          'message': 'Range too long',
        }),
        queryParameters: {'from': '2026-03-01', 'to': '2027-03-03'},
      );

      final result = await repository.fetchAvailability(
        id: 'lst_00001',
        from: DateTime(2026, 3, 1),
        to: DateTime(2027, 3, 3),
      );

      result.match((failure) {
        expect(failure.type, ApiFailureType.http);
        expect(failure.statusCode, 400);
      }, (_) => fail('Expected an HTTP failure'));
    });
  });

  group('ListingAvailability', () {
    ListingAvailability availability(List<DateTime> days) {
      return ListingAvailability(
        listingId: 'lst_00001',
        from: DateTime.utc(2026, 3, 1),
        to: DateTime.utc(2026, 4, 1),
        unavailable: [
          for (final day in days)
            UnavailableDay(date: day, reason: UnavailableReason.booked),
        ],
      );
    }

    test('matches taken days whatever the time zone or time of day', () {
      final taken = availability([DateTime.utc(2026, 3, 4)]);

      expect(taken.isTaken(DateTime(2026, 3, 4)), isTrue);
      expect(taken.isTaken(DateTime(2026, 3, 4, 23, 59)), isTrue);
      expect(taken.isTaken(DateTime.utc(2026, 3, 4)), isTrue);
      expect(taken.isTaken(DateTime(2026, 3, 3)), isFalse);
      expect(taken.isTaken(DateTime(2026, 3, 5)), isFalse);
    });

    test('round-trips through JSON as calendar dates', () {
      final taken = availability([DateTime.utc(2026, 3, 4)]);

      final json = taken.toJson();

      expect(json['from'], '2026-03-01');
      expect(
        ListingAvailability.fromJson(
          (json
            ..['unavailable'] = [
              for (final day in taken.unavailable) day.toJson(),
            ]),
        ),
        taken,
      );
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
