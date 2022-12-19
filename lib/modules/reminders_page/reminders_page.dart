import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:schedulemanager/app/config/app_colors.dart';
import 'package:schedulemanager/data/models/reminder_model.dart';
import 'package:schedulemanager/modules/reminders_page/controllers/events_page_controller.dart';

import 'package:schedulemanager/widgets/custom_circular_progress.dart';
import '../../widgets/custom_alert_dialog.dart';
import '../auth/controllers/auth_controller.dart';
import '../reminder_details/reminders_details_page.dart';
import '../../app/utils/responsive_util.dart';
import '../../widgets/custom_back_button.dart';
import '../../widgets/user_profile_picture.dart';

import '../../app/config/constants.dart';
import '../../app/utils/text_styles.dart';
import 'widgets/widgets.dart';

class RemindersPage extends StatelessWidget {
  const RemindersPage({
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

    final AuthController auth = Get.find();
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
              top: 50,
            ),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const CustomBackButton(),
                      const Spacer(),
                      UserProfilePicture(
                        height: resp.hp(5),
                        width: resp.wp(10),
                        userImage: auth.currentUser!.imageUrl ?? '',
                      )
                    ],
                  ),
                  SizedBox(height: resp.hp(2.5)),
                  Text(
                    'Today is',
                    style: TextStyles.w400(resp.sp20, lightGrey),
                  ),
                  SizedBox(height: resp.hp(0.5)),
                  Text(
                    _getFormattedDate(DateTime.now()),
                    style: TextStyles.w700(resp.sp30, black),
                  ),
                  SizedBox(height: resp.hp(5)),
                  if (events.isLoading.value)
                    const CustomCircularProgress(color: AppColors.accent)
                  else
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
                        final DateTime current =
                            events.selectedDate.value ?? DateTime.now();
                        events.setDate(DateTime(
                          current.year,
                          current.month,
                          newDay,
                        ));
                      },
                    ),
                  SizedBox(height: resp.hp(4)),
                  Text(
                    '${events.remindersInDate.length} ${events.remindersInDate.length == 1 ? 'Reminder' : 'Reminders'} in this day',
                    style: TextStyles.w700(resp.sp16),
                  ),
                  SizedBox(height: resp.hp(3)),
                  if (events.hasReminders) ...[
                    events.gettingEventsList.value
                        ? const CustomCircularProgress(color: AppColors.accent)
                        : RemindersListPerDay(
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
                                            style: TextStyles.w500(resp.sp16))
                                      ],
                                    ),
                                  );
                                  // await reminderService
                                  //     .deleteData(reminder.toMap())
                                  //     .whenComplete(() => Navigator.pop(context));
                                },
                              );
                            },
                          )
                  ] else
                    Center(
                      child: Text(
                        'No reminders',
                        style: TextStyles.w500(resp.sp20, lightGrey),
                      ),
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
