import 'package:intl/intl.dart';

String formatCurrency(int amountCents, String currency) {
  final formatter = NumberFormat.currency(
    locale: 'it_IT',
    symbol: currency,
    decimalDigits: 2,
  );
  return formatter.format(amountCents / 100);
}
