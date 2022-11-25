import 'dart:math';

import 'package:flutter/material.dart';
import '../../../constants/constants.dart';
import '../../../models/reminder_model.dart';
import '../../../utils/responsive_util.dart';

import '../../../widgets/reminder_container.dart';
import '../../../widgets/reminder_information.dart';
import 'reminder_hour.dart';

class RemindersListPerDay extends StatefulWidget {
  final void Function(ReminderModel reminder) onLongPressCallback;
  final List<ReminderModel> reminders;
  const RemindersListPerDay({
    super.key,
    required this.reminders,
    required this.onLongPressCallback,
  });

  @override
  State<RemindersListPerDay> createState() => _RemindersListPerDayState();
}

class _RemindersListPerDayState extends State<RemindersListPerDay> {
  late int remindersQuantity;
  late Color color;
  @override
  void initState() {
    super.initState();
    color = Colors.transparent;
  }

  @override
  Widget build(BuildContext context) {
    final ResponsiveUtil resp = ResponsiveUtil.of(context);

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      color = colors[Random().nextInt(colors.length - 1)];
    });

    return Column(
      children: List.generate(
        widget.reminders.length,
        (x) {
          return InkWell(
            onLongPress: () => widget.onLongPressCallback(widget.reminders[x]),
            borderRadius: BorderRadius.circular(10),
            splashColor: color.withOpacity(0.25),
            highlightColor: lightGrey.withOpacity(0.15),
            child: ReminderContainer(
              color: color,
              leftWidget: ReminderHour(
                hours: const ['09:00', '09:30'],
                fontSize: resp.sp14,
              ),
              rightWidget: ReminderInformation(
                reminder: widget.reminders[x],
              ),
            ),
          );
        },
      ),
    );
  }
}
