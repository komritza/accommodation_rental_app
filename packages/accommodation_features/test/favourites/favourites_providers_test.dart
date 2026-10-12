import 'dart:async';

import 'package:accommodation_core/accommodation_core.dart';
import 'package:accommodation_core/testing.dart';
import 'package:accommodation_features/auth.dart';
import 'package:accommodation_features/favourites.dart';
import 'package:accommodation_features/testing.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

const _failure = ApiFailure(type: ApiFailureType.network);

void main() {
  late FakeFavouritesRepository repository;

  ProviderContainer createContainer({AuthUser? user = testClient}) {
    final container = ProviderContainer(
      retry: (_, _) => null,
      overrides: [
        authControllerProvider.overrideWith(
          () => FakeAuthController(initialUser: user),
        ),
        favouritesRepositoryProvider.overrideWithValue(repository),
      ],
    );
    addTearDown(container.dispose);
    return container;
  }

  setUp(() {
    repository = FakeFavouritesRepository(
      favourites: [createTestListing(id: 'a')],
    );
  });

  test('loads the favourite ids of the signed-in user', () async {
    final container = createContainer();

    final ids = await container.read(favouriteListingIdsProvider.future);

    expect(ids, {'a'});
    expect(repository.fetchRequests, 1);
  });

  test('stays empty without fetching while signed out', () async {
    final container = createContainer(user: null);

    final ids = await container.read(favouriteListingIdsProvider.future);

    expect(ids, isEmpty);
    expect(repository.fetchRequests, 0);
  });

  test('drops the previous user\'s favourites after signing out', () async {
    final container = createContainer();
    expect(await container.read(favouriteListingIdsProvider.future), {'a'});

    await container.read(authControllerProvider.notifier).logout();

    expect(await container.read(favouriteListingIdsProvider.future), isEmpty);
  });

  test('exposes a load exception when fetching fails', () async {
    repository.fetchFailure = _failure;
    final container = createContainer();

    await expectLater(
      container.read(favouriteListingIdsProvider.future),
      throwsA(isA<FavouritesLoadException>()),
    );
  });

  test('adds a favourite optimistically and keeps it on success', () async {
    final container = createContainer();
    await container.read(favouriteListingIdsProvider.future);
    final pending = repository.pendingUpdates['b'] = Completer<void>();

    final toggle = container
        .read(favouriteListingIdsProvider.notifier)
        .toggle('b');

    expect(container.read(favouriteListingIdsProvider).value, {'a', 'b'});

    pending.complete();
    await toggle;

    expect(container.read(favouriteListingIdsProvider).value, {'a', 'b'});
    expect(repository.added, ['b']);
  });

  test('restores a removed favourite when the request fails', () async {
    final container = createContainer();
    await container.read(favouriteListingIdsProvider.future);
    repository.updateFailures['a'] = _failure;

    await expectLater(
      container.read(favouriteListingIdsProvider.notifier).toggle('a'),
      throwsA(isA<FavouritesUpdateException>()),
    );

    expect(container.read(favouriteListingIdsProvider).value, {'a'});
    expect(repository.removed, ['a']);
  });

  test('rolls back only the listing whose request failed', () async {
    final container = createContainer();
    await container.read(favouriteListingIdsProvider.future);
    final notifier = container.read(favouriteListingIdsProvider.notifier);
    final failing = repository.pendingUpdates['b'] = Completer<void>();
    final succeeding = repository.pendingUpdates['c'] = Completer<void>();
    repository.updateFailures['b'] = _failure;

    final failingToggle = notifier.toggle('b');
    final succeedingToggle = notifier.toggle('c');
    expect(container.read(favouriteListingIdsProvider).value, {'a', 'b', 'c'});

    succeeding.complete();
    await succeedingToggle;
    failing.complete();
    await expectLater(failingToggle, throwsA(isA<FavouritesUpdateException>()));

    expect(container.read(favouriteListingIdsProvider).value, {'a', 'c'});
  });

  test('ignores a second toggle while the first is in flight', () async {
    final container = createContainer();
    await container.read(favouriteListingIdsProvider.future);
    final notifier = container.read(favouriteListingIdsProvider.notifier);
    final pending = repository.pendingUpdates['b'] = Completer<void>();

    final first = notifier.toggle('b');
    await notifier.toggle('b');

    pending.complete();
    await first;

    expect(repository.added, ['b']);
    expect(repository.removed, isEmpty);
    expect(container.read(favouriteListingIdsProvider).value, {'a', 'b'});
  });
}
