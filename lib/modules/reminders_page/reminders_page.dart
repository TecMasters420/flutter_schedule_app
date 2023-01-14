import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:schedulemanager/modules/home/widgets/no_events_widget.dart';
import 'package:schedulemanager/widgets/custom_header_widget.dart';
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

  String _getFormattedDate(final DateTime date) {
    return DateFormat(DateFormat.YEAR_MONTH_DAY, 'en_US').format(
      date.toUtc(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ResponsiveUtil resp = ResponsiveUtil.of(context);

    final EventsPageController events = Get.find();

    return Obx(
      () {
        return Scaffold(
          floatingActionButton: FloatingActionButton(
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CustomHeaderWidget(
                          title: 'Events Page',
                        ),
                        SizedBox(height: resp.hp(3)),
                        Text(
                          _getFormattedDate(DateTime.now()),
                          style: TextStyles.w700(30),
                        ),
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
                        SizedBox(height: resp.hp(4)),
                        Text(
                          '${events.remindersInDate.length} ${events.remindersInDate.length == 1 ? 'Event' : 'Events'} in this day',
                          style: TextStyles.w700(16),
                        ),
                        SizedBox(height: resp.hp(3)),
                        if (events.gettingEventsList.value)
                          const CustomCircularProgress(color: AppColors.accent)
                        else if (events.hasEvents) ...[
                          EventsListPerDay(
                            reminders: events.remindersInDate,
                            onLongPressCallback: (reminder) {
                              CustomAlertDialog(
                                resp: resp,
                                context: context,
                                title:
                                    'Are you sure you want to delete the reminder?',
                                onAcceptCallback: () async {
                                  CustomAlertDialog(
                                    resp: resp,
                                    context: context,
                                    title: 'Wait a minute...',
                                    dismissible: false,
                                    showButtons: false,
                                    onAcceptCallback: () {},
                                    customBody: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const CustomCircularProgress(
                                            color: accent),
                                        SizedBox(height: resp.hp(2)),
                                        Text('Is being removed!',
                                            style: TextStyles.w500(16))
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                          )
                        ] else
                          const Center(
                            child: NoEventsWidget(),
                          ),
                        SizedBox(height: resp.hp(10)),
                      ],
                    ),
                  ),
          ),
        );
      },
    );
  }
}
