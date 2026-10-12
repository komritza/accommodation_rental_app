import 'package:accommodation_core/accommodation_core.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

Map<String, dynamic> _listingJson(String id) {
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
    'longitude': 8.0,
    'propertyType': 'apartment',
    'maxGuests': 2,
    'bedrooms': 1,
    'beds': 1,
    'bathrooms': 1,
    'pricePerNight': 173,
    'cleaningFee': 0,
    'currency': 'CHF',
    'amenities': ['wifi'],
    'rating': 4.62,
    'reviewsCount': 98,
    'images': ['https://picsum.photos/seed/a/1200/800'],
    'createdAt': '2026-01-01T10:00:00.000Z',
  };
}

void main() {
  late DioAdapter adapter;
  late FavouritesRepository repository;

  setUp(() {
    final dio = Dio(BaseOptions(baseUrl: 'https://test.example.com'));
    adapter = DioAdapter(dio: dio);
    dio.httpClientAdapter = adapter;
    repository = FavouritesRepository(FavouritesRemoteDataSource(dio));
  });

  test('parses the favourite listings', () async {
    adapter.onGet(
      '/favourites',
      (server) => server.reply(200, [_listingJson('a'), _listingJson('b')]),
    );

    final result = await repository.fetchFavourites();

    result.match(
      (failure) => fail('Unexpected failure: ${failure.type}'),
      (listings) => expect(listings.map((listing) => listing.id), ['a', 'b']),
    );
  });

  test('adds a favourite by listing id', () async {
    adapter.onPost(
      '/favourites',
      (server) => server.reply(201, {'listingId': 'a'}),
      data: {'listingId': 'a'},
    );

    final result = await repository.addFavourite(listingId: 'a');

    expect(result.isRight(), isTrue);
  });

  test('removes a favourite by listing id', () async {
    adapter.onDelete('/favourites/a', (server) => server.reply(204, null));

    final result = await repository.removeFavourite(listingId: 'a');

    expect(result.isRight(), isTrue);
  });

  test('maps an HTTP error to a failure', () async {
    adapter.onPost(
      '/favourites',
      (server) => server.reply(401, {'message': 'Unauthorized'}),
      data: {'listingId': 'a'},
    );

    final result = await repository.addFavourite(listingId: 'a');

    result.match((failure) {
      expect(failure.type, ApiFailureType.http);
      expect(failure.statusCode, 401);
    }, (_) => fail('Expected an HTTP failure'));
  });
}
