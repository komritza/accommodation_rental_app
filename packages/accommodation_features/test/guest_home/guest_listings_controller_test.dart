import 'dart:async';

import 'package:accommodation_core/accommodation_core.dart';
import 'package:accommodation_core/testing.dart';
import 'package:accommodation_features/src/guest_home/guest_listing_filters.dart';
import 'package:accommodation_features/src/guest_home/guest_listings_controller.dart';
import 'package:accommodation_features/src/listings/listings_providers.dart';
import 'package:accommodation_features/testing.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

List<Listing> _listings(int count, {String city = 'Lucerne'}) {
  return [
    for (var i = 0; i < count; i++)
      createTestListing(id: 'lst_${city}_$i', title: 'Stay $i', city: city),
  ];
}

void main() {
  late FakeListingsRepository repository;
  late ProviderContainer container;

  setUp(() {
    repository = FakeListingsRepository(listings: _listings(5), pageSize: 2);
    container = ProviderContainer(
      retry: (_, _) => null,
      overrides: [listingsRepositoryProvider.overrideWithValue(repository)],
    );
    container.listen(guestListingsControllerProvider, (_, _) {});
  });

  tearDown(() => container.dispose());

  GuestListingsController notifier() {
    return container.read(guestListingsControllerProvider.notifier);
  }

  test('loads the first page with the total from the API', () async {
    final state = await container.read(guestListingsControllerProvider.future);

    expect(state.listings, hasLength(2));
    expect(state.totalCount, 5);
    expect(state.hasMore, isTrue);
    expect(repository.requests.single.cursor, isNull);
  });

  test('appends pages until the end of the list', () async {
    await container.read(guestListingsControllerProvider.future);

    await notifier().loadNextPage();
    await notifier().loadNextPage();
    await notifier().loadNextPage();

    final state = container.read(guestListingsControllerProvider).requireValue;
    expect(state.listings.map((listing) => listing.id), [
      for (var i = 0; i < 5; i++) 'lst_Lucerne_$i',
    ]);
    expect(state.hasMore, isFalse);
    expect(repository.requests.map((request) => request.cursor), [
      null,
      '2',
      '4',
    ]);
  });

  test('ignores a second request while a page is loading', () async {
    await container.read(guestListingsControllerProvider.future);
    repository.pendingResponse = Completer<void>();

    final first = notifier().loadNextPage();
    final second = notifier().loadNextPage();
    expect(
      container
          .read(guestListingsControllerProvider)
          .requireValue
          .isLoadingMore,
      isTrue,
    );

    repository.pendingResponse!.complete();
    await Future.wait([first, second]);

    expect(repository.requests, hasLength(2));
  });

  test('keeps loaded listings when the next page fails', () async {
    await container.read(guestListingsControllerProvider.future);
    repository.listingsFailure = const ApiFailure(type: ApiFailureType.network);

    await notifier().loadNextPage();

    final failed = container.read(guestListingsControllerProvider).requireValue;
    expect(failed.listings, hasLength(2));
    expect(failed.loadMoreFailure?.type, ApiFailureType.network);

    await notifier().loadNextPage();
    expect(repository.requests, hasLength(2));

    repository.listingsFailure = null;
    await notifier().retryNextPage();

    final recovered = container
        .read(guestListingsControllerProvider)
        .requireValue;
    expect(recovered.listings, hasLength(4));
    expect(recovered.loadMoreFailure, isNull);
  });

  test('restarts from the first page when the filters change', () async {
    repository.listings = [..._listings(3), ..._listings(1, city: 'Zermatt')];
    await container.read(guestListingsControllerProvider.future);
    await notifier().loadNextPage();

    container
        .read(guestListingFiltersProvider.notifier)
        .apply(const ListingSearchQuery(city: 'Zermatt'));
    final state = await container.read(guestListingsControllerProvider.future);

    expect(state.listings.single.city, 'Zermatt');
    expect(state.totalCount, 1);
    expect(repository.requests.last.query.city, 'Zermatt');
    expect(repository.requests.last.cursor, isNull);
  });

  test('drops a page that arrives after the filters changed', () async {
    repository.listings = [..._listings(3), ..._listings(1, city: 'Zermatt')];
    await container.read(guestListingsControllerProvider.future);

    repository.pendingResponse = Completer<void>();
    final staleLoad = notifier().loadNextPage();
    container
        .read(guestListingFiltersProvider.notifier)
        .apply(const ListingSearchQuery(city: 'Zermatt'));
    repository.pendingResponse!.complete();
    await staleLoad;
    final state = await container.read(guestListingsControllerProvider.future);

    expect(state.listings.map((listing) => listing.city), ['Zermatt']);
  });

  test('surfaces a first-page failure as an error state', () async {
    repository.listingsFailure = const ApiFailure(
      type: ApiFailureType.http,
      statusCode: 500,
    );
    container.invalidate(guestListingsControllerProvider);

    await expectLater(
      container.read(guestListingsControllerProvider.future),
      throwsA(isA<ListingsLoadException>()),
    );
  });
}
