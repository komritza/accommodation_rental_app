import 'package:intl/intl.dart';

String formatCurrencyAmount(
  num amount, {
  required String currencyCode,
  required String locale,
}) {
  final format = NumberFormat.simpleCurrency(
    locale: locale,
    name: currencyCode,
    decimalDigits: amount == amount.roundToDouble() ? 0 : 2,
  );
  final formatted = format.format(amount);
  final symbol = format.currencySymbol;

  final isAlphabetic = RegExp(r'^[A-Za-z]+$').hasMatch(symbol);
  if (isAlphabetic &&
      formatted.startsWith(symbol) &&
      !formatted.startsWith('$symbol\u00A0') &&
      !formatted.startsWith('$symbol ')) {
    return '$symbol\u00A0${formatted.substring(symbol.length)}';
  }

  return formatted;
}
