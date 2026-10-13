import 'dart:async';

import 'package:accommodation_core/accommodation_core.dart';
import 'package:accommodation_core/testing.dart';
import 'package:accommodation_features/auth.dart';
import 'package:accommodation_features/favourites.dart';
import 'package:accommodation_features/testing.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

const _failure = ApiFailure(type: ApiFailureType.network);

final _listings = {
  for (final id in ['a', 'b', 'c']) id: createTestListing(id: id),
};

Listing _listing(String id) => _listings[id]!;

Set<String> _ids(ProviderContainer container) => {
  for (final listing in container.read(favouritesProvider).value!) listing.id,
};

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
    repository = FakeFavouritesRepository(favourites: [_listing('a')]);
  });

  test('loads the favourites of the signed-in user', () async {
    final container = createContainer();

    final listings = await container.read(favouritesProvider.future);

    expect(listings, [_listing('a')]);
    expect(repository.fetchRequests, 1);
  });

  test('stays empty without fetching while signed out', () async {
    final container = createContainer(user: null);

    final listings = await container.read(favouritesProvider.future);

    expect(listings, isEmpty);
    expect(repository.fetchRequests, 0);
  });

  test('drops the previous user\'s favourites after signing out', () async {
    final container = createContainer();
    expect(await container.read(favouritesProvider.future), [_listing('a')]);

    await container.read(authControllerProvider.notifier).logout();

    expect(await container.read(favouritesProvider.future), isEmpty);
  });

  test('exposes a load exception when fetching fails', () async {
    repository.fetchFailure = _failure;
    final container = createContainer();

    await expectLater(
      container.read(favouritesProvider.future),
      throwsA(isA<FavouritesLoadException>()),
    );
  });

  test('adds a favourite optimistically and keeps it on success', () async {
    final container = createContainer();
    await container.read(favouritesProvider.future);
    final pending = repository.pendingUpdates['b'] = Completer<void>();

    final toggle = container
        .read(favouritesProvider.notifier)
        .toggle(_listing('b'));

    expect(_ids(container), {'a', 'b'});

    pending.complete();
    await toggle;

    expect(_ids(container), {'a', 'b'});
    expect(repository.added, ['b']);
  });

  test('adds new favourites to the top of the list', () async {
    final container = createContainer();
    await container.read(favouritesProvider.future);

    await container.read(favouritesProvider.notifier).toggle(_listing('b'));

    expect(container.read(favouritesProvider).value, [
      _listing('b'),
      _listing('a'),
    ]);
  });

  test('restores a removed favourite in its original position', () async {
    repository.favourites = [_listing('a'), _listing('b'), _listing('c')];
    repository.updateFailures['b'] = _failure;
    final container = createContainer();
    await container.read(favouritesProvider.future);

    await expectLater(
      container.read(favouritesProvider.notifier).toggle(_listing('b')),
      throwsA(isA<FavouritesUpdateException>()),
    );

    expect(container.read(favouritesProvider).value, [
      _listing('a'),
      _listing('b'),
      _listing('c'),
    ]);
  });

  test('restores a removed favourite when the request fails', () async {
    final container = createContainer();
    await container.read(favouritesProvider.future);
    repository.updateFailures['a'] = _failure;

    await expectLater(
      container.read(favouritesProvider.notifier).toggle(_listing('a')),
      throwsA(isA<FavouritesUpdateException>()),
    );

    expect(_ids(container), {'a'});
    expect(repository.removed, ['a']);
  });

  test('rolls back only the listing whose request failed', () async {
    final container = createContainer();
    await container.read(favouritesProvider.future);
    final notifier = container.read(favouritesProvider.notifier);
    final failing = repository.pendingUpdates['b'] = Completer<void>();
    final succeeding = repository.pendingUpdates['c'] = Completer<void>();
    repository.updateFailures['b'] = _failure;

    final failingToggle = notifier.toggle(_listing('b'));
    final succeedingToggle = notifier.toggle(_listing('c'));
    expect(_ids(container), {'a', 'b', 'c'});

    succeeding.complete();
    await succeedingToggle;
    failing.complete();
    await expectLater(failingToggle, throwsA(isA<FavouritesUpdateException>()));

    expect(_ids(container), {'a', 'c'});
  });

  test('ignores a second toggle while the first is in flight', () async {
    final container = createContainer();
    await container.read(favouritesProvider.future);
    final notifier = container.read(favouritesProvider.notifier);
    final pending = repository.pendingUpdates['b'] = Completer<void>();

    final first = notifier.toggle(_listing('b'));
    await notifier.toggle(_listing('b'));

    pending.complete();
    await first;

    expect(repository.added, ['b']);
    expect(repository.removed, isEmpty);
    expect(_ids(container), {'a', 'b'});
  });
}
