import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedulemanager/modules/home/widgets/all_reminders_redirection_button.dart';
import 'package:schedulemanager/modules/home/widgets/no_events_widget.dart';
import '../../../data/models/reminder_model.dart';
import 'reminder_date_data.dart';
import '../../../app/utils/responsive_util.dart';

import '../../../app/config/constants.dart';
import '../../../app/utils/text_styles.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/reminder_container.dart';
import '../../../widgets/reminder_information.dart';

class EventsListPerType extends StatelessWidget {
  final List<ReminderModel> data;
  final int maxEventsToShow;
  const EventsListPerType({
    super.key,
    required this.data,
    required this.maxEventsToShow,
  });

  @override
  Widget build(BuildContext context) {
    final ResponsiveUtil resp = ResponsiveUtil.of(context);
    return Column(
      children: [
        SizedBox(height: resp.hp(2.5)),
        if (data.isNotEmpty) ...[
          Row(
            children: [
              Text(
                '${data.length} Events',
                style: TextStyles.w700(16),
              ),
              const Spacer(),
              TextButton(
                child: Text(
                  'See all',
                  style: TextStyles.w700(16, accent),
                ),
                onPressed: () => Get.toNamed('remindersPage'),
              )
            ],
          ),
          SizedBox(height: resp.hp(2.5)),
          ...List.generate(
            data.length > maxEventsToShow ? maxEventsToShow + 2 : data.length,
            (index) {
              if (index > maxEventsToShow) const AllEventsRedirectionButton();
              final color = colors[Random().nextInt(colors.length - 1)];
              return ReminderContainer(
                color: color,
                leftWidget: ReminderDateData(
                  endDate: data[index].endDate!,
                  timeRemaining: data[index].timeLeft(DateTime.now()),
                  dotColor: color,
                ),
                rightWidget: ReminderInformation(
                  reminder: data[index],
                ),
              );
            },
          )
        ] else
          const NoEventsWidget()
      ],
    );
  }
}
