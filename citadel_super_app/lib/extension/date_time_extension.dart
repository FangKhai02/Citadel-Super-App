import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  String toFormattedString() {
    return DateFormat('dd MMM yyyy').format(this);
  }

  String get toYYYYMMDD => DateFormat('yyyy MMMM dd').format(this);

  String get tommddyyyy => DateFormat('MM-dd-yyyy').format(this);
}
