import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:schedulemanager/app/config/app_constants.dart';
import 'package:schedulemanager/modules/home/widgets/no_events_widget.dart';
import 'package:schedulemanager/modules/events_page/widgets/short_event_data_widget.dart';
import 'package:schedulemanager/routes/app_routes.dart';
import 'package:schedulemanager/widgets/custom_header_widget.dart';
import 'package:schedulemanager/widgets/custom_nav_bar_widget.dart';
import 'package:schedulemanager/widgets/custom_text_button_widget.dart';
import 'package:schedulemanager/widgets/custom_timeline_reminder_object_widget.dart';
import 'package:schedulemanager/widgets/loading_widget.dart';
import 'package:schedulemanager/widgets/responsive_container_widget.dart';
import 'controllers/events_page_controller.dart';
import '../../app/utils/responsive_util.dart';
import '../../app/config/constants.dart';
import '../../app/utils/text_styles.dart';
import 'widgets/widgets.dart';

class EventsPage extends StatelessWidget {
  const EventsPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final ResponsiveUtil resp = ResponsiveUtil.of(context);

    final EventsPageController events = Get.find();

    return Obx(
      () {
        return Scaffold(
          bottomNavigationBar: const CustomNavBarWidget(),
          body: Padding(
            padding: AppConstants.bodyPadding,
            child: events.isLoading.value
                ? const LoadingWidget()
                : SingleChildScrollView(
                    clipBehavior: Clip.none,
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CustomHeaderWidget(
                          title: 'Events Page',
                        ),
                        SizedBox(height: resp.hp(3)),
                        if (!events.isLoading.value) ...[
                          ResponsiveContainerWidget(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 20,
                            ),
                            child: ScrolleableCalendar(
                              initialDay:
                                  events.days.isEmpty ? 0 : events.days.first,
                              days: events.days,
                              initialMonth: events.months.isEmpty
                                  ? 0
                                  : events.months.first,
                              months: events.months,
                              onSelectedNewMonth: (selectedMonth) {
                                final DateTime current =
                                    events.selectedDate.value ?? DateTime.now();
                                events.setDate(
                                  DateTime(
                                    current.year,
                                    selectedMonth,
                                  ),
                                  genDay: true,
                                );
                              },
                              onSelectedNewDay: (newDay) {
                                final current =
                                    events.selectedDate.value ?? DateTime.now();
                                events.setDate(
                                  DateTime(
                                    current.year,
                                    current.month,
                                    newDay,
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                        SizedBox(height: resp.hp(3)),
                        ResponsiveContainerWidget(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 20,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (events.gettingEventsList.value ||
                                  !events.hasEvents)
                                AnimatedSwitcher(
                                  duration: const Duration(milliseconds: 250),
                                  transitionBuilder: (child, animation) {
                                    return ScaleTransition(
                                      scale: animation,
                                      child: child,
                                    );
                                  },
                                  child: events.gettingEventsList.value
                                      ? SizedBox(
                                          height: resp.hp(28.5),
                                          child: Center(
                                            child: LoadingWidget(
                                              key: Key(true.toString()),
                                            ),
                                          ),
                                        )
                                      : NoEventsWidget(
                                          key: Key(false.toString()),
                                        ),
                                )
                              else ...[
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Timeline',
                                            style: TextStyles.w700(20),
                                          ),
                                          Text(
                                            '${events.eventsInDate.length} ${events.eventsInDate.length == 1 ? 'Event' : 'Events'} in this day',
                                            style: TextStyles.w500(14, grey),
                                          ),
                                        ],
                                      ),
                                    ),
                                    CustomTextButtonWidget(
                                      title: 'Add event',
                                      onTap: () =>
                                          Get.toNamed(AppRoutes.eventDetails),
                                    )
                                  ],
                                ),
                                SizedBox(height: resp.hp(2.5)),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: List.generate(
                                    24,
                                    (h) {
                                      final tempHour = DateTime(0, 0, 0, h);
                                      final time =
                                          DateFormat('hh a').format(tempHour);
                                      final eventsInHour = events.eventsInDate
                                          .where((e) => e.endDate.hour == h)
                                          .toList();
                                      return CustomTimeLineReminderObjectWidget(
                                        title: time,
                                        titleStyle: eventsInHour.isNotEmpty
                                            ? TextStyles.w700(14)
                                            : TextStyles.w500(14, grey),
                                        suffixWidget: eventsInHour.isEmpty
                                            ? null
                                            : Row(
                                                children: [
                                                  ...List.generate(
                                                    eventsInHour.length,
                                                    (x) {
                                                      final isFinalElement =
                                                          x == 5 - 1;
                                                      return Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                          right: !isFinalElement
                                                              ? 20
                                                              : 0,
                                                        ),
                                                        child:
                                                            ShortEventDataWidget(
                                                          event:
                                                              eventsInHour[x],
                                                          color: colors[
                                                              Random().nextInt(
                                                            colors.length - 1,
                                                          )],
                                                          onLongPressCallback:
                                                              (event) {},
                                                        ),
                                                      );
                                                    },
                                                  )
                                                ],
                                              ),
                                      );
                                    },
                                  ),
                                )
                              ]
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
          ),
        );
      },
    );
  }
}
