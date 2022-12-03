import 'package:flutter/material.dart';

class CustomDateTimePicker {
  final BuildContext context;
  final void Function(DateTime date) onAcceptCallback;
  final DateTime startDate;
  final DateTime endDate;
  late final DateTime? firstDate;

  CustomDateTimePicker({
    required this.context,
    required this.startDate,
    required this.endDate,
    required this.onAcceptCallback,
    this.firstDate,
  }) {
    _show();
  }

  void _show() async {
    final DateTime? date = await showDatePicker(
      context: context,
      initialDate: startDate,
      initialDatePickerMode: DatePickerMode.day,
      firstDate: firstDate ?? DateTime.now(),
      lastDate: endDate,
      keyboardType: TextInputType.number,
    );
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(
        hour: startDate.hour,
        minute: startDate.minute,
      ),
    );
    final datePicked = date ?? DateTime.now();
    final timePicked = time ?? const TimeOfDay(hour: 0, minute: 0);
    final DateTime dateTime = DateTime(
      datePicked.year,
      datePicked.month,
      datePicked.day,
      timePicked.hour,
      timePicked.minute,
    );
    onAcceptCallback(dateTime);
  }
}
