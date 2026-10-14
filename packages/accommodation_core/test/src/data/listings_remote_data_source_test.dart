import 'package:accommodation_core/accommodation_core.dart';
import 'package:accommodation_core/testing.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

void main() {
  late Dio dio;
  late DioAdapter adapter;
  late ListingsRemoteDataSource dataSource;

  final testListing = createTestListing();
  final testBooking = createTestBooking();
  final testFacets = createTestFacets();

  setUp(() {
    dio = Dio(BaseOptions(baseUrl: 'https://test.example.com'));
    adapter = DioAdapter(dio: dio);
    dio.httpClientAdapter = adapter;
    dataSource = ListingsRemoteDataSource(dio);
  });

  group('ListingsRemoteDataSource', () {
    group('fetchListings', () {
      test('fetches and parses listings with pagination metadata', () async {
        adapter.onGet(
          ApiPaths.listings,
          (server) => server.reply(
            200,
            [testListing.toJson()],
            headers: {
              Headers.contentTypeHeader: [Headers.jsonContentType],
              'x-total-count': ['1'],
              'x-next-cursor': ['cursor-2'],
            },
          ),
        );

        final result = await dataSource.fetchListings(
          query: ListingSearchQuery(),
          cursor: 'cursor-1',
          limit: 10,
        );

        expect(result.items, [testListing]);
        expect(result.totalCount, 1);
        expect(result.nextCursor, 'cursor-2');
      });

      test('returns an empty page when there are no listings', () async {
        adapter.onGet(ApiPaths.listings, (server) => server.reply(200, []));

        final result = await dataSource.fetchListings(
          query: ListingSearchQuery(),
        );

        expect(result.items, isEmpty);
        expect(result.nextCursor, isNull);
      });

      test('throws FormatException when response body is null', () async {
        adapter.onGet(ApiPaths.listings, (server) => server.reply(200, null));

        await expectLater(
          dataSource.fetchListings(query: ListingSearchQuery()),
          throwsA(isA<FormatException>()),
        );
      });
    });

    group('fetchListing', () {
      test('fetches listing details in the requested language', () async {
        adapter.onGet(
          ApiPaths.listingDetails(testListing.id),
          (server) => server.reply(200, testListing.toJson()),
          queryParameters: {'language': 'en'},
        );

        final result = await dataSource.fetchListing(
          id: testListing.id,
          language: 'en',
        );

        expect(result, testListing);
      });

      test('throws FormatException when response body is empty', () async {
        adapter.onGet(
          ApiPaths.listingDetails(testListing.id),
          (server) => server.reply(200, {}),
          queryParameters: {'language': 'en'},
        );

        await expectLater(
          dataSource.fetchListing(id: testListing.id, language: 'en'),
          throwsA(isA<FormatException>()),
        );
      });
    });

    group('fetchAvailability', () {
      test('fetches availability for the requested date range', () async {
        final from = DateTime.utc(2026, 3, 1);
        final to = DateTime.utc(2026, 3, 4);

        adapter.onGet(
          ApiPaths.listingDetailsAvailability(testListing.id),
          (server) => server.reply(
            200,
            {
              'listingId': testListing.id,
              'from': '2026-03-01',
              'to': '2026-03-04',
              'unavailable': [
                {'date': '2026-03-02', 'reason': 'booked'},
                {'date': '2026-03-03', 'reason': 'blocked'},
              ],
            },
            headers: {
              Headers.contentTypeHeader: [Headers.jsonContentType],
            },
          ),
          queryParameters: {'from': '2026-03-01', 'to': '2026-03-04'},
        );

        final result = await dataSource.fetchAvailability(
          id: testListing.id,
          from: from,
          to: to,
        );

        expect(result.listingId, testListing.id);
        expect(result.from, from);
        expect(result.to, to);
        expect(result.unavailable, hasLength(2));
        expect(result.isTaken(DateTime.utc(2026, 3, 2)), isTrue);
        expect(result.isTaken(DateTime.utc(2026, 3, 3)), isTrue);
        expect(result.isTaken(DateTime.utc(2026, 3, 1)), isFalse);
      });

      test('throws FormatException when response body is null', () async {
        adapter.onGet(
          ApiPaths.listingDetailsAvailability(testListing.id),
          (server) => server.reply(200, null),
          queryParameters: {'from': '2026-03-01', 'to': '2026-03-04'},
        );

        await expectLater(
          dataSource.fetchAvailability(
            id: testListing.id,
            from: DateTime.utc(2026, 3, 1),
            to: DateTime.utc(2026, 3, 4),
          ),
          throwsA(isA<FormatException>()),
        );
      });
    });

    group('fetchFacets', () {
      test('fetches and parses listing facets', () async {
        adapter.onGet(
          ApiPaths.listingsFacets,
          (server) => server.reply(200, testFacets.toJson()),
        );

        final result = await dataSource.fetchFacets();

        expect(result.cities, testFacets.cities);
        expect(result.propertyTypes, testFacets.propertyTypes);
        expect(result.amenities, testFacets.amenities);
        expect(result.priceMin, testFacets.priceMin);
        expect(result.priceMax, testFacets.priceMax);
        expect(result.maxGuests, testFacets.maxGuests);
        expect(result.currency, testFacets.currency);
      });

      test('throws FormatException when response body is null', () async {
        adapter.onGet(
          ApiPaths.listingsFacets,
          (server) => server.reply(200, null),
        );

        await expectLater(
          dataSource.fetchFacets(),
          throwsA(isA<FormatException>()),
        );
      });
    });

    group('fetchHostListings', () {
      test('fetches host listings with pagination metadata', () async {
        adapter.onGet(
          ApiPaths.hostListings,
          (server) => server.reply(
            200,
            [testListing.toJson()],
            headers: {
              Headers.contentTypeHeader: [Headers.jsonContentType],
              'x-total-count': ['1'],
              'x-next-cursor': ['cursor-2'],
            },
          ),
          queryParameters: {'limit': 10, 'nextCursor': 'cursor-1'},
        );

        final result = await dataSource.fetchHostListings(
          cursor: 'cursor-1',
          limit: 10,
        );

        expect(result.items, [testListing]);
        expect(result.totalCount, 1);
        expect(result.nextCursor, 'cursor-2');
      });

      test('throws FormatException when response body is null', () async {
        adapter.onGet(
          ApiPaths.hostListings,
          (server) => server.reply(200, null),
        );

        await expectLater(
          dataSource.fetchHostListings(),
          throwsA(isA<FormatException>()),
        );
      });
    });

    group('updateHostListing', () {
      test('updates a listing and parses the response', () async {
        final changes = {'title': 'Updated listing'};
        final updatedListing = createTestListing(title: 'Updated listing');

        adapter.onPatch(
          ApiPaths.hostListing(testListing.id),
          (server) => server.reply(200, updatedListing.toJson()),
          data: changes,
        );

        final result = await dataSource.updateHostListing(
          id: testListing.id,
          changes: changes,
        );

        expect(result.title, 'Updated listing');
      });

      test('throws FormatException when response body is null', () async {
        adapter.onPatch(
          ApiPaths.hostListing(testListing.id),
          (server) => server.reply(200, null),
          data: {'title': 'Updated listing'},
        );

        await expectLater(
          dataSource.updateHostListing(
            id: testListing.id,
            changes: {'title': 'Updated listing'},
          ),
          throwsA(isA<FormatException>()),
        );
      });
    });

    group('fetchHostBookings', () {
      test('fetches bookings with pagination metadata', () async {
        adapter.onGet(
          ApiPaths.hostListingBookings(testListing.id),
          (server) => server.reply(
            200,
            [testBooking.toJson()],
            headers: {
              Headers.contentTypeHeader: [Headers.jsonContentType],
              'x-total-count': ['1'],
              'x-next-cursor': ['null'],
            },
          ),
          queryParameters: {'limit': 10, 'nextCursor': 'cursor-1'},
        );

        final result = await dataSource.fetchHostBookings(
          listingId: testListing.id,
          cursor: 'cursor-1',
          limit: 10,
        );

        expect(result.items, [testBooking]);
        expect(result.totalCount, 1);
        expect(result.nextCursor, isNull);
      });

      test('throws FormatException when response body is null', () async {
        adapter.onGet(
          ApiPaths.hostListingBookings(testListing.id),
          (server) => server.reply(200, null),
        );

        await expectLater(
          dataSource.fetchHostBookings(listingId: testListing.id),
          throwsA(isA<FormatException>()),
        );
      });
    });

    group('fetchBlockedDays', () {
      test('returns an empty list when there are no blocked days', () async {
        adapter.onGet(
          ApiPaths.hostListingBlockedDays(testListing.id),
          (server) => server.reply(200, []),
        );

        final result = await dataSource.fetchBlockedDays(
          listingId: testListing.id,
        );

        expect(result, isEmpty);
      });

      test('throws FormatException when response body is null', () async {
        adapter.onGet(
          ApiPaths.hostListingBlockedDays(testListing.id),
          (server) => server.reply(200, null),
        );

        await expectLater(
          dataSource.fetchBlockedDays(listingId: testListing.id),
          throwsA(isA<FormatException>()),
        );
      });
    });

    group('blockDay', () {
      test('blocks a day and parses the response', () async {
        final date = DateTime.utc(2026, 3, 10);

        adapter.onPost(
          ApiPaths.hostListingBlockedDays(testListing.id),
          (server) => server.reply(201, {
            'listingId': testListing.id,
            'date': '2026-03-10',
          }),
          data: {'date': '2026-03-10'},
        );

        final result = await dataSource.blockDay(
          listingId: testListing.id,
          date: date,
        );

        expect(result, isA<BlockedDay>());
      });

      test('throws FormatException when response body is empty', () async {
        adapter.onPost(
          ApiPaths.hostListingBlockedDays(testListing.id),
          (server) => server.reply(201, {}),
          data: {'date': '2026-03-10'},
        );

        await expectLater(
          dataSource.blockDay(
            listingId: testListing.id,
            date: DateTime.utc(2026, 3, 10),
          ),
          throwsA(isA<FormatException>()),
        );
      });
    });

    group('unblockDay', () {
      test('unblocks a day', () async {
        adapter.onDelete(
          ApiPaths.hostListingBlockedDay(testListing.id, '2026-03-10'),
          (server) => server.reply(204, null),
        );

        await expectLater(
          dataSource.unblockDay(
            listingId: testListing.id,
            date: DateTime.utc(2026, 3, 10),
          ),
          completes,
        );
      });
    });
  });
}
