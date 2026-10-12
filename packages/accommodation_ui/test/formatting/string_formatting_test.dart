import 'package:accommodation_ui/accommodation_ui.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('capitalizeFirst', () {
    test('capitalizes the first letter of a string', () {
      expect('hello'.capitalizeFirst(), 'Hello');
      expect('world'.capitalizeFirst(), 'World');
    });

    test('returns an empty string when input is empty', () {
      expect(''.capitalizeFirst(), '');
    });

    test(
      'returns the same string when the first letter is already capitalized',
      () {
        expect('Hello'.capitalizeFirst(), 'Hello');
      },
    );
  });

  group('humanized', () {
    test('turns a snake_case slug into capitalized words', () {
      expect('air_conditioning'.humanized, 'Air Conditioning');
      expect('wifi'.humanized, 'Wifi');
    });

    test('drops empty words from repeated separators', () {
      expect('_hot__tub_'.humanized, 'Hot Tub');
      expect(''.humanized, '');
    });
  });
}
