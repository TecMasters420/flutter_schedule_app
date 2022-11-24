import 'dart:math';

import 'package:flutter/material.dart';
import '../../../constants/constants.dart';
import '../../../models/reminder_model.dart';
import '../../../utils/responsive_util.dart';

import '../../../widgets/reminder_container.dart';
import '../../../widgets/reminder_information.dart';
import 'reminder_hour.dart';

class RemindersListPerDay extends StatefulWidget {
  final List<ReminderModel> reminders;
  const RemindersListPerDay({
    super.key,
    required this.reminders,
  });

  @override
  State<RemindersListPerDay> createState() => _RemindersListPerDayState();
}

class _RemindersListPerDayState extends State<RemindersListPerDay> {
  late int remindersQuantity;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ResponsiveUtil resp = ResponsiveUtil.of(context);

    return Column(
      children: List.generate(
        widget.reminders.length,
        (x) {
          return ReminderContainer(
            color: colors[Random().nextInt(colors.length - 1)],
            leftWidget: ReminderHour(
              hours: const ['09:00', '09:30'],
              fontSize: resp.sp14,
            ),
            rightWidget: ReminderInformation(
              reminder: widget.reminders[x],
            ),
          );
        },
      ),
    );
  }
}
