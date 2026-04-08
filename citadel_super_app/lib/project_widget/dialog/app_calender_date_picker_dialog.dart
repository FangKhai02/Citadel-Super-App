import 'package:flutter/material.dart';

import '../../app_folder/app_color.dart';

Future<DateTime?> showCalendarDatePickerDialog(
  BuildContext context, {
  DateTime? initialDate,
  DateTime? firstDate,
  DateTime? lastDate,
}) {
  return showDialog(
    context: context,
    builder: (_) => _CalendarDatePicker(
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
    ),
  );
}

class _CalendarDatePicker extends StatefulWidget {
  final DateTime? initialDate;
  final DateTime? firstDate;
  final DateTime? lastDate;

  const _CalendarDatePicker({this.initialDate, this.firstDate, this.lastDate});

  @override
  State<_CalendarDatePicker> createState() => _CalendarDatePickerState();
}

class _CalendarDatePickerState extends State<_CalendarDatePicker> {
  final int years = 100;
  final int days = 365;
  DateTime? dateTime;
  String errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColor.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CalendarDatePicker(
            initialDate: widget.initialDate,
            firstDate: widget.firstDate ??
                DateTime.now().subtract(Duration(days: days * years)),
            lastDate: widget.lastDate ?? DateTime.now(),
            onDateChanged: (DateTime value) {
              dateTime = value;
            },
          ),
          Visibility(
            visible: errorMessage.isNotEmpty,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child:
                  Text(errorMessage, style: const TextStyle(color: Colors.red)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16).copyWith(
              bottom: 16,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    if (dateTime == null) {
                      setState(() {
                        errorMessage = 'Please select a date';
                      });
                      return;
                    }
                    Navigator.pop(context, dateTime);
                  },
                  child: const Text('OK'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
