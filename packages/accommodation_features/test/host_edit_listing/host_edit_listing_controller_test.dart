import 'dart:async';

import 'package:accommodation_core/accommodation_core.dart';
import 'package:accommodation_core/testing.dart';
import 'package:accommodation_features/src/host_edit_listing/host_edit_listing_providers.dart';
import 'package:accommodation_features/src/host_home/host_listings_controller.dart';
import 'package:accommodation_features/src/listing_detail/listing_detail_providers.dart';
import 'package:accommodation_features/src/listings/listings_providers.dart';
import 'package:accommodation_features/testing.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

const _listingId = 'lst_1';

void main() {
  late FakeListingsRepository repository;
  late ProviderContainer container;
  final provider = hostEditListingControllerProvider(
    _listingId,
    language: 'en',
  );

  setUp(() {
    final listings = [
      createTestListing(id: 'lst_0', title: 'Stay 0'),
      createTestListing(id: _listingId, title: 'Stay 1'),
    ];
    repository = FakeListingsRepository(
      listings: listings,
      hostListings: listings,
    );
    container = ProviderContainer(
      retry: (_, _) => null,
      overrides: [listingsRepositoryProvider.overrideWithValue(repository)],
    );
    container.listen(provider, (_, _) {});
  });

  tearDown(() => container.dispose());

  HostEditListingController notifier() => container.read(provider.notifier);

  test('starts from the listing with nothing to save', () async {
    final state = await container.read(provider.future);

    expect(state.title, 'Stay 1');
    expect(state.hasChanges, isFalse);
    expect(await notifier().save(), isFalse);
    expect(repository.updateRequests, isEmpty);
  });

  test('saves only the changed fields', () async {
    await container.read(provider.future);

    notifier()
      ..updatePricePerNight(210)
      ..toggleAmenity('sauna')
      ..toggleAmenity('wifi');

    expect(await notifier().save(), isTrue);
    final request = repository.updateRequests.single;
    expect(request.id, _listingId);
    expect(request.changes, {
      'pricePerNight': 210,
      'amenities': ['sauna'],
    });

    final saved = container.read(provider).requireValue;
    expect(saved.originalListing.pricePerNight, 210);
    expect(saved.hasChanges, isFalse);
  });

  test('updates the host list and refreshes the listing detail', () async {
    container.listen(hostListingsControllerProvider, (_, _) {});
    container.listen(
      listingDetailProvider(_listingId, language: 'en'),
      (_, _) {},
    );
    await container.read(hostListingsControllerProvider.future);
    await container.read(
      listingDetailProvider(_listingId, language: 'en').future,
    );
    await container.read(provider.future);
    final detailRequests = repository.listingRequests.length;

    notifier().updateTitle('Renamed stay');
    await notifier().save();
    await container.read(
      listingDetailProvider(_listingId, language: 'en').future,
    );

    final hostListings = container
        .read(hostListingsControllerProvider)
        .requireValue
        .listings;
    expect(hostListings.map((listing) => listing.title), [
      'Stay 0',
      'Renamed stay',
    ]);
    expect(repository.hostListingsRequests, hasLength(1));
    expect(repository.listingRequests.length, detailRequests + 1);
  });

  test('keeps the edits and the failure when saving fails', () async {
    await container.read(provider.future);
    repository.updateFailure = const ApiFailure(
      type: ApiFailureType.http,
      statusCode: 400,
      messageCode: 'error.badRequest',
    );

    notifier().updateMaxGuests(6);
    expect(await notifier().save(), isFalse);

    final failed = container.read(provider).requireValue;
    expect(failed.maxGuests, 6);
    expect(failed.isSaving, isFalse);
    expect(failed.saveFailure?.messageCode, 'error.badRequest');

    notifier().updateMaxGuests(5);
    expect(container.read(provider).requireValue.saveFailure, isNull);
  });

  test('ignores edits and a second save while saving', () async {
    await container.read(provider.future);
    repository.pendingMutation = Completer<void>();

    notifier().updateBeds(3);
    final firstSave = notifier().save();
    notifier().updateBeds(9);
    final secondSave = notifier().save();

    expect(container.read(provider).requireValue.isSaving, isTrue);
    repository.pendingMutation!.complete();

    expect(await firstSave, isTrue);
    expect(await secondSave, isFalse);
    expect(repository.updateRequests.single.changes, {'beds': 3});
  });
}
