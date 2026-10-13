import 'package:accommodation_core/accommodation_core.dart';
import 'package:accommodation_core/testing.dart';
import 'package:accommodation_features/src/host_home/host_listings_controller.dart';
import 'package:accommodation_features/src/listings/listings_providers.dart';
import 'package:accommodation_features/testing.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

void main() {
  late FakeListingsRepository repository;
  late ProviderContainer container;

  setUp(() {
    repository = FakeListingsRepository(
      hostListings: [
        for (var i = 0; i < 3; i++)
          createTestListing(id: 'lst_$i', title: 'Stay $i'),
      ],
      pageSize: 2,
    );
    container = ProviderContainer(
      retry: (_, _) => null,
      overrides: [listingsRepositoryProvider.overrideWithValue(repository)],
    );
    container.listen(hostListingsControllerProvider, (_, _) {});
  });

  tearDown(() => container.dispose());

  HostListingsController notifier() {
    return container.read(hostListingsControllerProvider.notifier);
  }

  test('loads the host listings page by page', () async {
    final first = await container.read(hostListingsControllerProvider.future);
    expect(first.listings, hasLength(2));
    expect(first.totalCount, 3);

    await notifier().loadNextPage();

    final state = container.read(hostListingsControllerProvider).requireValue;
    expect(state.listings.map((listing) => listing.id), [
      'lst_0',
      'lst_1',
      'lst_2',
    ]);
    expect(state.hasMore, isFalse);
    expect(repository.hostListingsRequests.map((request) => request.cursor), [
      null,
      '2',
    ]);
  });

  test('keeps loaded listings when the next page fails', () async {
    await container.read(hostListingsControllerProvider.future);
    repository.hostListingsFailure = const ApiFailure(
      type: ApiFailureType.network,
    );

    await notifier().loadNextPage();

    final state = container.read(hostListingsControllerProvider).requireValue;
    expect(state.listings, hasLength(2));
    expect(state.loadMoreFailure?.type, ApiFailureType.network);
  });

  test('swaps in an edited listing without reloading', () async {
    await container.read(hostListingsControllerProvider.future);
    await notifier().loadNextPage();

    notifier().replaceListing(
      createTestListing(id: 'lst_1', title: 'Renamed stay'),
    );

    final state = container.read(hostListingsControllerProvider).requireValue;
    expect(state.listings.map((listing) => listing.title), [
      'Stay 0',
      'Renamed stay',
      'Stay 2',
    ]);
    expect(state.hasMore, isFalse);
    expect(repository.hostListingsRequests, hasLength(2));
  });
}
