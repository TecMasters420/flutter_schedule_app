import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:schedulemanager/app/config/app_constants.dart';
import 'package:schedulemanager/app/config/constants.dart';
import 'package:schedulemanager/app/utils/responsive_util.dart';
import 'package:schedulemanager/data/models/event_model.dart';
import 'package:schedulemanager/widgets/custom_header_widget.dart';
import 'package:schedulemanager/widgets/custom_text_button_widget.dart';
import 'package:schedulemanager/widgets/responsive_container_widget.dart';

import '../../../app/utils/text_styles.dart';
import '../../../routes/app_routes.dart';
import '../../../widgets/reminder_container.dart';
import '../../../widgets/event_information.dart';
import '../../home/widgets/reminder_date_data.dart';

class FilteredEventsPage extends StatelessWidget {
  final String title;
  final List<EventModel> events;
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
              SizedBox(height: resp.hp(2.5)),
              ResponsiveContainerWidget(
                padding: const EdgeInsets.symmetric(
                  vertical: 30,
                  horizontal: 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Events List',
                            style: TextStyles.w700(20),
                          ),
                        ),
                        CustomTextButtonWidget(
                          title: 'Add Event',
                          onTap: () => Get.toNamed(AppRoutes.eventDetails),
                        )
                      ],
                    ),
                    SizedBox(height: resp.hp(2.5)),
                    ...events.map(
                      (e) {
                        final color =
                            colors[Random().nextInt(colors.length - 1)];
                        return ReminderContainer(
                          color: color,
                          leftWidget: ReminderDateData(
                            endDate: e.endDate,
                            timeRemaining: e.timeLeft(DateTime.now()),
                            dotColor: color,
                          ),
                          rightWidget: EventInforamtion(
                            event: e,
                          ),
                        );
                      },
                    ).toList(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
