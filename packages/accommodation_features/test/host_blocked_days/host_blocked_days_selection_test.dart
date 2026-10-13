import 'package:accommodation_features/src/host_blocked_days/host_blocked_days_selection_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

DateTime _day(int day) => DateTime.utc(2026, 3, day);

void main() {
  group('HostBlockedDaysSelection', () {
    late ProviderContainer container;
    final provider = hostBlockedDaysSelectionProvider('lst_1');

    setUp(() {
      container = ProviderContainer();
      container.listen(provider, (_, _) {});
    });

    tearDown(() => container.dispose());

    HostBlockedDaysSelection notifier() => container.read(provider.notifier);

    test('starts a range on a free day and ends it on a later one', () {
      notifier().selectDay(DateTime(2026, 3, 4, 15), isBlocked: false);
      expect(container.read(provider), (start: _day(4), end: null));

      notifier().selectDay(DateTime(2026, 3, 6), isBlocked: false);
      expect(container.read(provider), (start: _day(4), end: _day(6)));
    });

    test('restarts the range on an earlier day', () {
      notifier()
        ..selectDay(_day(6), isBlocked: false)
        ..selectDay(_day(4), isBlocked: false);

      expect(container.read(provider), (start: _day(4), end: null));
    });

    test('selects a blocked day on its own, even mid-range', () {
      notifier()
        ..selectDay(_day(4), isBlocked: false)
        ..selectDay(_day(6), isBlocked: true);

      expect(container.read(provider), (start: _day(6), end: _day(6)));
    });

    test('starts over after a finished range', () {
      notifier()
        ..selectDay(_day(4), isBlocked: false)
        ..selectDay(_day(6), isBlocked: false)
        ..selectDay(_day(10), isBlocked: false);

      expect(container.read(provider), (start: _day(10), end: null));
    });
  });

  group('daysToBlock', () {
    test('covers the range inclusively and skips taken days', () {
      final taken = {_day(5), _day(7)};

      expect(
        daysToBlock(start: _day(4), end: _day(8), isTaken: taken.contains),
        [_day(4), _day(6), _day(8)],
      );
    });

    test('blocks the start alone when no end is chosen', () {
      expect(daysToBlock(start: _day(4), isTaken: (_) => false), [_day(4)]);
    });

    test('compares local and UTC days as the same calendar day', () {
      expect(
        daysToBlock(
          start: DateTime(2026, 3, 28, 23, 30),
          end: DateTime(2026, 3, 30),
          isTaken: (_) => false,
        ),
        [_day(28), _day(29), _day(30)],
      );
    });
  });
}
