import 'dart:math';

import 'package:flutter/material.dart';
import 'package:schedulemanager/app/config/app_constants.dart';
import 'package:schedulemanager/app/config/constants.dart';
import 'package:schedulemanager/app/utils/responsive_util.dart';
import 'package:schedulemanager/data/models/reminder_model.dart';
import 'package:schedulemanager/widgets/custom_header_widget.dart';
import 'package:schedulemanager/widgets/responsive_container_widget.dart';

import '../../../app/utils/text_styles.dart';
import '../../../widgets/reminder_container.dart';
import '../../../widgets/reminder_information.dart';
import '../../home/widgets/reminder_date_data.dart';

class FilteredEventsPage extends StatelessWidget {
  final String title;
  final List<ReminderModel> events;
  const FilteredEventsPage({
    super.key,
    required this.events,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final ResponsiveUtil resp = ResponsiveUtil.of(context);
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: AppConstants.bodyPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomHeaderWidget(title: '$title Events'),
              SizedBox(height: resp.hp(5)),
              Text(
                'Events List',
                style: TextStyles.w700(20),
              ),
              SizedBox(height: resp.hp(2.5)),
              ResponsiveContainerWidget(
                child: Column(
                  children: events.map((e) {
                    final color = colors[Random().nextInt(colors.length - 1)];
                    return ReminderContainer(
                      color: color,
                      leftWidget: ReminderDateData(
                        endDate: e.endDate!,
                        timeRemaining: e.timeLeft(DateTime.now()),
                        dotColor: color,
                      ),
                      rightWidget: ReminderInformation(
                        event: e,
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
