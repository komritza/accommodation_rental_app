import 'dart:async';

import 'package:accommodation_core/accommodation_core.dart';
import 'package:accommodation_features/src/common/guest_calendar.dart';
import 'package:accommodation_features/src/host_blocked_days/host_blocked_days_providers.dart';
import 'package:accommodation_features/src/listing_detail/listing_detail_providers.dart';
import 'package:accommodation_features/src/listings/listings_providers.dart';
import 'package:accommodation_features/testing.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

const _listingId = 'lst_1';

DateTime _day(int day) => DateTime.utc(2026, 3, day);

void main() {
  late FakeListingsRepository repository;
  late ProviderContainer container;
  final controller = hostBlockedDaysControllerProvider(_listingId);
  final blockedDays = hostBlockedDaysProvider(_listingId);
  final availability = listingAvailabilityProvider(_listingId);

  setUp(() {
    repository = FakeListingsRepository(
      blockedDays: {
        _listingId: [_day(10)],
      },
    );
    container = ProviderContainer(
      retry: (_, _) => null,
      overrides: [
        guestCalendarTodayProvider.overrideWithValue(_day(1)),
        listingsRepositoryProvider.overrideWithValue(repository),
      ],
    );
    container
      ..listen(controller, (_, _) {})
      ..listen(blockedDays, (_, _) {})
      ..listen(availability, (_, _) {});
  });

  tearDown(() => container.dispose());

  HostBlockedDaysController notifier() => container.read(controller.notifier);

  Future<List<DateTime>> blockedDates() async {
    final days = await container.read(blockedDays.future);
    return [for (final day in days) day.date];
  }

  test('blocks every day and refreshes both calendars', () async {
    expect(await blockedDates(), [_day(10)]);

    expect(await notifier().blockDays([_day(4), _day(5)]), isTrue);

    expect(repository.blockRequests, [_day(4), _day(5)]);
    expect(await blockedDates(), [_day(4), _day(5), _day(10)]);
    final taken = await container.read(availability.future);
    expect(taken.isTaken(_day(4)), isTrue);
    expect(container.read(controller).hasError, isFalse);
  });

  test('unblocks a day', () async {
    expect(await notifier().unblockDay(_day(10)), isTrue);

    expect(repository.unblockRequests, [_day(10)]);
    expect(await blockedDates(), isEmpty);
  });

  test('reports a failed unblock and keeps the day blocked', () async {
    repository.unblockFailure = const ApiFailure(type: ApiFailureType.network);

    expect(await notifier().unblockDay(_day(10)), isFalse);

    expect(container.read(controller).hasError, isTrue);
    expect(await blockedDates(), [_day(10)]);
  });

  test('refreshes after a range fails halfway through', () async {
    await blockedDates();
    repository.failBlockOn = _day(5);

    expect(await notifier().blockDays([_day(4), _day(5), _day(6)]), isFalse);

    expect(repository.blockRequests, [_day(4), _day(5)]);
    expect(container.read(controller).hasError, isTrue);
    expect(await blockedDates(), [_day(4), _day(10)]);
  });

  test('refuses a second change while one is in flight', () async {
    repository.pendingMutation = Completer<void>();

    final first = notifier().blockDays([_day(4)]);
    expect(container.read(controller).isLoading, isTrue);
    expect(await notifier().unblockDay(_day(10)), isFalse);

    repository.pendingMutation!.complete();
    expect(await first, isTrue);
    expect(repository.unblockRequests, isEmpty);
  });
}
