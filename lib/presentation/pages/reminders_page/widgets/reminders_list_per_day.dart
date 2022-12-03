import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../app/config/constants.dart';
import '../../../../data/models/reminder_model.dart';
import '../../../../app/utils/responsive_util.dart';

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
          final ReminderModel remider = widget.reminders[x];
          final String startDate =
              DateFormat('MM-dd').format(remider.startDate.toDate());
          final String endDate =
              DateFormat('MM-dd').format(remider.endDate.toDate());

          return InkWell(
            onLongPress: () => widget.onLongPressCallback(remider),
            borderRadius: BorderRadius.circular(10),
            splashColor: color.withOpacity(0.25),
            highlightColor: lightGrey.withOpacity(0.05),
            child: ReminderContainer(
              color: color,
              leftWidget: ReminderHour(
                dates: [startDate, endDate],
                fontSize: resp.sp14,
              ),
              rightWidget: ReminderInformation(
                reminder: remider,
              ),
            ),
          );
        },
      ),
    );
  }
}
