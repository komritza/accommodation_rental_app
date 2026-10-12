import 'package:accommodation_ui/accommodation_ui.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('formatCurrencyAmount', () {
    test('formats whole amounts without decimals', () {
      expect(
        formatCurrencyAmount(249, currencyCode: 'EUR', locale: 'en'),
        '€249',
      );
      expect(
        formatCurrencyAmount(249, currencyCode: 'EUR', locale: 'de'),
        '249\u00A0€',
      );
    });

    test('separates a leading letter symbol from the amount', () {
      expect(
        formatCurrencyAmount(1237, currencyCode: 'CHF', locale: 'en'),
        'CHF\u00A01,237',
      );
      expect(
        formatCurrencyAmount(237, currencyCode: 'CHF', locale: 'de'),
        '237\u00A0CHF',
      );
    });

    test('keeps fractions when the amount has them', () {
      expect(
        formatCurrencyAmount(612.5, currencyCode: 'EUR', locale: 'en'),
        '€612.50',
      );
    });
  });
}
