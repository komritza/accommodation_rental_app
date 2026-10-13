import 'package:accommodation_core/accommodation_core.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../listing_detail/listing_detail_providers.dart';
import '../listings/listings_providers.dart';

part 'host_blocked_days_providers.g.dart';

@riverpod
Future<List<BlockedDay>> hostBlockedDays(Ref ref, String listingId) async {
  final result = await ref
      .watch(listingsRepositoryProvider)
      .fetchBlockedDays(listingId: listingId);

  return result.match(
    (failure) => throw ListingsLoadException(failure),
    (days) => days,
  );
}

@riverpod
class HostBlockedDaysController extends _$HostBlockedDaysController {
  @override
  FutureOr<void> build(String listingId) {}

  /// Blocks [dates] one call at a time, as the API takes a single day per
  /// request. Stops at the first failure; the days before it stay blocked.
  Future<bool> blockDays(List<DateTime> dates) {
    return _mutate((repository) async {
      for (final date in dates) {
        final result = await repository.blockDay(
          listingId: listingId,
          date: StayDates.calendarDate(date),
        );
        result.match((failure) => throw ListingsLoadException(failure), (_) {});
      }
    });
  }

  Future<bool> unblockDay(DateTime date) {
    return _mutate((repository) async {
      final result = await repository.unblockDay(
        listingId: listingId,
        date: StayDates.calendarDate(date),
      );
      result.match((failure) => throw ListingsLoadException(failure), (_) {});
    });
  }

  Future<bool> _mutate(
    Future<void> Function(ListingsRepository repository) operation,
  ) async {
    if (state.isLoading) return false;

    final repository = ref.read(listingsRepositoryProvider);
    state = const AsyncLoading();
    final result = await AsyncValue.guard(() => operation(repository));
    if (!ref.mounted) return false;

    state = result;
    // Refreshed on failure too: a range can fail halfway through.
    ref.invalidate(hostBlockedDaysProvider(listingId));
    ref.invalidate(listingAvailabilityProvider(listingId));

    return !result.hasError;
  }
}
