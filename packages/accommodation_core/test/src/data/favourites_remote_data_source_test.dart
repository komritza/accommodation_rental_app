import 'package:accommodation_core/accommodation_core.dart';
import 'package:accommodation_core/testing.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

void main() {
  late Dio dio;
  late DioAdapter adapter;
  late FavouritesRemoteDataSource dataSource;

  final testListing = createTestListing();

  setUp(() {
    dio = Dio(BaseOptions(baseUrl: 'https://test.example.com'));
    adapter = DioAdapter(dio: dio);
    dio.httpClientAdapter = adapter;
    dataSource = FavouritesRemoteDataSource(dio);
  });

  group('FavouritesRemoteDataSource', () {
    group('fetchFavourites', () {
      test('fetches and parses favourite listings', () async {
        adapter.onGet(
          ApiPaths.favourites,
          (server) => server.reply(200, [testListing.toJson()]),
        );

        final favourites = await dataSource.fetchFavourites();

        expect(favourites, [testListing]);
      });

      test('returns an empty list when there are no favourites', () async {
        adapter.onGet(ApiPaths.favourites, (server) => server.reply(200, []));

        final favourites = await dataSource.fetchFavourites();

        expect(favourites, isEmpty);
      });

      test('throws FormatException when the response body is empty', () async {
        adapter.onGet(ApiPaths.favourites, (server) => server.reply(200, null));

        await expectLater(
          dataSource.fetchFavourites(),
          throwsA(isA<FormatException>()),
        );
      });
    });

    group('addFavourite', () {
      test('adds a listing to favourites', () async {
        adapter.onPost(
          ApiPaths.favourites,
          (server) => server.reply(201, {}),
          data: {'listingId': testListing.id},
        );

        await expectLater(
          dataSource.addFavourite(listingId: testListing.id),
          completes,
        );
      });
    });

    group('removeFavourite', () {
      test('removes a listing from favourites', () async {
        adapter.onDelete(
          ApiPaths.favourite(testListing.id),
          (server) => server.reply(204, null),
        );

        await expectLater(
          dataSource.removeFavourite(listingId: testListing.id),
          completes,
        );
      });
    });
  });
}
