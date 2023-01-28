import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedulemanager/modules/filtered_events/pages/filtered_events_page.dart';
import 'package:schedulemanager/modules/home/models/events_type_model.dart';
import 'package:schedulemanager/widgets/custom_button.dart';
import '../../../widgets/custom_text_button_widget.dart';
import 'no_events_widget.dart';
import 'reminder_date_data.dart';
import '../../../app/utils/responsive_util.dart';

import '../../../app/config/constants.dart';
import '../../../app/utils/text_styles.dart';
import '../../../widgets/reminder_container.dart';
import '../../../widgets/event_information.dart';

class EventsListPerType extends StatelessWidget {
  final EventsTypeModel eventsType;
  final int maxEventsToShow;
  const EventsListPerType({
    super.key,
    required this.maxEventsToShow,
    required this.eventsType,
  });

  @override
  Widget build(BuildContext context) {
    final ResponsiveUtil resp = ResponsiveUtil.of(context);
    final styles = TextStyles.of(context);
    final lenght = eventsType.events.length;
    final isEmpty = eventsType.events.isEmpty;
    return Column(
      children: [
        SizedBox(height: resp.hp(2.5)),
        if (!isEmpty) ...[
          Row(
            children: [
              Text(
                '$lenght Events',
                style: styles.w700(16),
              ),
              const Spacer(),
              CustomTextButtonWidget(
                title: 'Show all',
                customFontSize: 16,
                onTap: () => Get.to(
                  () => FilteredEventsPage(
                    events: eventsType.events,
                    title: eventsType.label,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: resp.hp(2.5)),
          ...List.generate(
            lenght > maxEventsToShow ? maxEventsToShow + 1 : lenght,
            (index) {
              if (index >= maxEventsToShow) {
                return GestureDetector(
                  child: CustomButton(
                    padding: const EdgeInsets.symmetric(vertical: 30),
                    text: 'Press to see all events',
                    color: darkAccent,
                    expand: true,
                    onTap: () {
                      Get.to(
                        () => FilteredEventsPage(
                          events: eventsType.events,
                          title: eventsType.label,
                        ),
                      );
                    },
                    style: styles.w700(
                      18,
                      Colors.white,
                    ),
                  ),
                );
              }
              return ReminderContainer(
                color: eventsType.color,
                leftWidget: ReminderDateData(
                  endDate: eventsType.events[index].endDate,
                  timeRemaining: eventsType.events[index].timeLeft(
                    DateTime.now(),
                  ),
                  dotColor: eventsType.color,
                ),
                rightWidget: EventInforamtion(
                  event: eventsType.events[index],
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
