import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:schedulemanager/modules/home/widgets/no_events_widget.dart';
import 'package:schedulemanager/modules/reminders_page/widgets/short_event_data_widget.dart';
import 'package:schedulemanager/widgets/custom_header_widget.dart';
import 'package:schedulemanager/widgets/custom_timeline_reminder_object_widget.dart';
import 'package:schedulemanager/widgets/loading_widget.dart';
import '../../app/config/app_colors.dart';
import '../../data/models/reminder_model.dart';
import 'controllers/events_page_controller.dart';

import '../../widgets/custom_circular_progress.dart';
import '../../widgets/custom_alert_dialog.dart';
import '../reminder_details/reminders_details_page.dart';
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
          floatingActionButton: events.isLoading.value
              ? null
              : FloatingActionButton(
                  backgroundColor: accent,
                  child: const Icon(Icons.add),
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ReminderDetailsPage(
                        reminder: ReminderModel.empty(),
                      ),
                    ),
                  ),
                ),
          body: Padding(
            padding: const EdgeInsets.only(
              left: 32,
              right: 32,
              top: 70,
              bottom: 20,
            ),
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
                          SizedBox(height: resp.hp(2.5)),
                          ScrolleableCalendar(
                            initialDay: events.days.first,
                            days: events.days,
                            initialMonth:
                                events.months.isEmpty ? 0 : events.months.first,
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
                        ],
                        SizedBox(height: resp.hp(3)),
                        // if (events.gettingEventsList.value)
                        //   const CustomCircularProgress(color: AppColors.accent)
                        // else if (events.hasEvents) ...[
                        //   EventsListPerDay(
                        //     reminders: events.remindersInDate,
                        //     onLongPressCallback: (reminder) {
                        //       CustomAlertDialog(
                        //         resp: resp,
                        //         context: context,
                        //         title:
                        //             'Are you sure you want to delete the reminder?',
                        //         onAcceptCallback: () async {
                        //           CustomAlertDialog(
                        //             resp: resp,
                        //             context: context,
                        //             title: 'Wait a minute...',
                        //             dismissible: false,
                        //             showButtons: false,
                        //             onAcceptCallback: () {},
                        //             customBody: Column(
                        //               mainAxisSize: MainAxisSize.min,
                        //               children: [
                        //                 const CustomCircularProgress(
                        //                     color: accent),
                        //                 SizedBox(height: resp.hp(2)),
                        //                 Text('Is being removed!',
                        //                     style: TextStyles.w500(16))
                        //               ],
                        //             ),
                        //           );
                        //         },
                        //       );
                        //     },
                        //   )
                        // ] else
                        //   const Center(
                        //     child: NoEventsWidget(),
                        //   ),
                        // SizedBox(height: resp.hp(10)),
                        if (events.gettingEventsList.value)
                          Column(
                            children: [
                              SizedBox(height: resp.hp(15)),
                              const LoadingWidget(),
                            ],
                          )
                        else if (!events.hasEvents)
                          Column(
                            children: [
                              SizedBox(height: resp.hp(15)),
                              const NoEventsWidget(),
                            ],
                          )
                        else ...[
                          Text('Timeline', style: TextStyles.w700(20)),
                          Text(
                            '${events.eventsInDate.length} ${events.eventsInDate.length == 1 ? 'Event' : 'Events'} in this day',
                            style: TextStyles.w500(14, grey),
                          ),
                          SizedBox(height: resp.hp(2.5)),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: List.generate(
                              24,
                              (h) {
                                final hour = h + 1;
                                final tempHour = DateTime(0, 0, 0, hour);
                                final time =
                                    DateFormat('hh a').format(tempHour);
                                final eventsInHour = events.eventsInDate
                                    .where((e) =>
                                        e.endDate != null &&
                                        e.endDate!.hour + 1 == hour)
                                    .toList();
                                return CustomTimeLineReminderObjectWidget(
                                  title: time,
                                  titleStyle: eventsInHour.isNotEmpty
                                      ? TextStyles.w700(14)
                                      : TextStyles.w500(14, lightGrey),
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
                                                  padding: EdgeInsets.only(
                                                    right: !isFinalElement
                                                        ? 20
                                                        : 0,
                                                  ),
                                                  child: ShortEventDataWidget(
                                                    event: eventsInHour[x],
                                                    color:
                                                        colors[Random().nextInt(
                                                      colors.length - 1,
                                                    )],
                                                    onLongPressCallback:
                                                        (event) {
                                                      print('asasdasd');
                                                    },
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
          ),
        );
      },
    );
  }
}
