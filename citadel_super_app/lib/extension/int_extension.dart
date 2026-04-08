import 'package:intl/intl.dart';

extension IntExtension on int? {
  String get toDDMMYYY => this == null ? '-' : toDateFormat('dd-MM-yyyy');

  String get toDDMMMYYYhhmm =>
      this == null ? '-' : toDateFormat('dd-MMM-yyyy hh:mm a');

  String get toDDMMMYYYhhmmWithSpace =>
      this == null ? '-' : toDateFormat('dd MMM yyyy, hh:mm a');

  String toDateFormat(String dateFormat) {
    if (this == null) return '-';
    return DateFormat(dateFormat)
        .format(DateTime.fromMillisecondsSinceEpoch(this!));
  }

  String formatCountdown() {
    final minutes = (this! ~/ 60).toString().padLeft(2, '0');
    final remainingSeconds = (this! % 60).toString().padLeft(2, '0');
    return '$minutes:$remainingSeconds';
  }

  String thousandSeparator() {
    var formatter = NumberFormat('###,###,###,###,###,###,##0.00');
    return formatter.format(this);
  }

  String commaFormatter() {
    var formatter = NumberFormat("###,###,###,###,###,###");
    return formatter.format(this);
  }

  String get getYearFromMonth {
    return (this! / 12).floor().toString();
  }
}
