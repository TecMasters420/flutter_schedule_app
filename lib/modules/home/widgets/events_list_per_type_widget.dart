import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedulemanager/modules/filtered_events/pages/filtered_events_page.dart';
import 'package:schedulemanager/widgets/responsive_container_widget.dart';
import '../../../widgets/custom_text_button_widget.dart';
import 'no_events_widget.dart';
import '../../../data/models/reminder_model.dart';
import 'reminder_date_data.dart';
import '../../../app/utils/responsive_util.dart';

import '../../../app/config/constants.dart';
import '../../../app/utils/text_styles.dart';
import '../../../widgets/reminder_container.dart';
import '../../../widgets/event_information.dart';

class EventsListPerType extends StatelessWidget {
  final List<EventModel> data;
  final int maxEventsToShow;
  final String type;
  const EventsListPerType({
    super.key,
    required this.data,
    required this.maxEventsToShow,
    required this.type,
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
              CustomTextButtonWidget(
                title: 'See all',
                customFontSize: 16,
                onTap: () => Get.to(
                  () => FilteredEventsPage(events: data, title: type),
                ),
              ),
            ],
          ),
          SizedBox(height: resp.hp(2.5)),
          ...List.generate(
            data.length > maxEventsToShow ? maxEventsToShow + 1 : data.length,
            (index) {
              if (index >= maxEventsToShow) {
                return GestureDetector(
                  onTap: () => Get.to(
                    () => FilteredEventsPage(events: data, title: type),
                  ),
                  child: ResponsiveContainerWidget(
                    customColor: lightBlue,
                    padding: const EdgeInsets.symmetric(vertical: 30),
                    child: Center(
                      child: Text(
                        'Press to see all events',
                        textAlign: TextAlign.center,
                        style: TextStyles.w700(
                          18,
                          accent,
                        ),
                      ),
                    ),
                  ),
                );
              }
              final color = colors[Random().nextInt(colors.length - 1)];
              return ReminderContainer(
                color: color,
                leftWidget: ReminderDateData(
                  endDate: data[index].endDate!,
                  timeRemaining: data[index].timeLeft(DateTime.now()),
                  dotColor: color,
                ),
                rightWidget: EventInforamtion(
                  event: data[index],
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
