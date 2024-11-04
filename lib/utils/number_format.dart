import 'package:intl/intl.dart';

String formatWithComma(int number) {
  final formatter = NumberFormat('#,###');
  return formatter.format(number);
}
