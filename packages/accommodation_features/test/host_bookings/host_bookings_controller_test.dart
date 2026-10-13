import 'package:accommodation_core/accommodation_core.dart';
import 'package:accommodation_core/testing.dart';
import 'package:accommodation_features/src/host_bookings/host_bookings_controller.dart';
import 'package:accommodation_features/src/listings/listings_providers.dart';
import 'package:accommodation_features/testing.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

void main() {
  late FakeListingsRepository repository;
  late ProviderContainer container;

  final provider = hostBookingsControllerProvider('lst_1');

  setUp(() {
    repository = FakeListingsRepository(
      hostBookings: {
        'lst_1': [
          for (var i = 0; i < 3; i++)
            createTestBooking(id: 'bkg_$i', listingId: 'lst_1'),
        ],
      },
      pageSize: 2,
    );
    container = ProviderContainer(
      retry: (_, _) => null,
      overrides: [listingsRepositoryProvider.overrideWithValue(repository)],
    );
    container.listen(provider, (_, _) {});
  });

  tearDown(() => container.dispose());

  test('loads the bookings of the listing page by page', () async {
    final first = await container.read(provider.future);
    expect(first.bookings, hasLength(2));
    expect(first.totalCount, 3);
    expect(first.hasMore, isTrue);

    await container.read(provider.notifier).loadMore();

    final state = container.read(provider).requireValue;
    expect(state.bookings.map((booking) => booking.id), [
      'bkg_0',
      'bkg_1',
      'bkg_2',
    ]);
    expect(state.hasMore, isFalse);
    expect(repository.hostBookingsRequests, [
      (listingId: 'lst_1', cursor: null),
      (listingId: 'lst_1', cursor: '2'),
    ]);
  });

  test('keeps loaded bookings when the next page fails', () async {
    await container.read(provider.future);
    repository.hostBookingsFailure = const ApiFailure(
      type: ApiFailureType.network,
    );

    await container.read(provider.notifier).loadMore();

    var state = container.read(provider).requireValue;
    expect(state.bookings, hasLength(2));
    expect(state.loadMoreFailure?.type, ApiFailureType.network);

    repository.hostBookingsFailure = null;
    await container.read(provider.notifier).loadMore();

    state = container.read(provider).requireValue;
    expect(state.bookings, hasLength(3));
    expect(state.loadMoreFailure, isNull);
  });

  test('fails the first load with the API failure', () async {
    repository.hostBookingsFailure = const ApiFailure(
      type: ApiFailureType.network,
    );
    container.invalidate(provider);

    await expectLater(
      container.read(provider.future),
      throwsA(isA<ListingsLoadException>()),
    );
  });
}
