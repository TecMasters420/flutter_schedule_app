import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:schedulemanager/data/models/reminder_model.dart';

import 'package:schedulemanager/presentation/controllers/auth_controller.dart';
import 'package:schedulemanager/presentation/widgets/custom_alert_dialog.dart';
import 'package:schedulemanager/presentation/widgets/custom_circular_progress.dart';
import '../../controllers/reminders_controller.dart';
import '../reminder_details_page/reminders_details_page.dart';
import '../../../app/utils/responsive_util.dart';
import '../../widgets/custom_back_button.dart';
import '../../widgets/user_profile_picture.dart';

import '../../../app/config/constants.dart';
import '../../../app/utils/text_styles.dart';
import 'widgets/widgets.dart';

class RemindersPage extends StatefulWidget {
  const RemindersPage({
    super.key,
  });

  @override
  State<RemindersPage> createState() => _RemindersPageState();
}

class _RemindersPageState extends State<RemindersPage> {
  late DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = null;
  }

  String _getFormattedDate(final DateTime date) {
    return DateFormat(DateFormat.YEAR_MONTH_DAY, 'en_US').format(
      date.toUtc(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ResponsiveUtil resp = ResponsiveUtil.of(context);

    final AuthController auth = Get.find();
    final RemindersController reminderService = Get.put(RemindersController());

    return Obx(
      () {
        final List<int> monthsWithReminders = [];
        for (final ReminderModel r in reminderService.reminders) {
          final int reminderEndMonth = r.endDate.month;
          if (!monthsWithReminders.contains(reminderEndMonth)) {
            monthsWithReminders.add(reminderEndMonth);
          }
        }
        monthsWithReminders.sort((a, b) => a.compareTo(b));
        if (_selectedDate == null ||
            !monthsWithReminders.contains(_selectedDate!.month) &&
                monthsWithReminders.isNotEmpty) {
          final month =
              monthsWithReminders.isEmpty ? 0 : monthsWithReminders[0];
          _selectedDate = DateTime(DateTime.now().year, month);
        }

        // Get reminders in current month
        final List<ReminderModel> remInMonth = monthsWithReminders.isEmpty
            ? []
            : reminderService.reminders
                .where((r) => r.endDate.month == _selectedDate!.month)
                .toList();

        // Reminders per month
        final Map<int, List<ReminderModel>> remindersInMonth = {};

        for (final ReminderModel r in remInMonth) {
          final int reminderDay = r.endDate.day;
          remindersInMonth.containsKey(reminderDay)
              ? remindersInMonth[reminderDay]!.add(r)
              : remindersInMonth.addAll({
                  reminderDay: [r]
                });
        }

        // Get list of days with reminders
        final List<int> daysWithReminders = remindersInMonth.keys.toList();
        daysWithReminders.sort((a, b) => a.compareTo(b));

        if (!daysWithReminders.contains(_selectedDate!.day) &&
            daysWithReminders.isNotEmpty) {
          _selectedDate = DateTime(
              _selectedDate!.year, _selectedDate!.month, daysWithReminders[0]);
        }

        final int currentDay = _selectedDate == null ||
                !daysWithReminders.contains(_selectedDate!.day)
            ? daysWithReminders.isEmpty
                ? 0
                : daysWithReminders[0]
            : _selectedDate!.day;

        // Check day
        if (_selectedDate != null && currentDay != _selectedDate!.day) {
          _selectedDate =
              DateTime(_selectedDate!.year, _selectedDate!.month, currentDay);
        }
        final List<ReminderModel> remindersInSelectedDay =
            remInMonth.isEmpty ? [] : remindersInMonth[currentDay]!.toList();
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
                        userImage: auth.userInformation.value!.imageURL ?? '',
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
                  ScrolleableCalendar(
                    initialDay:
                        daysWithReminders.isEmpty ? 0 : daysWithReminders[0],
                    days: daysWithReminders,
                    initialMonth: monthsWithReminders.isEmpty
                        ? 0
                        : monthsWithReminders[0],
                    months: monthsWithReminders,
                    onSelectedNewMonth: (selectedMonth) {
                      final DateTime current = _selectedDate ?? DateTime.now();
                      setState(() {
                        _selectedDate = DateTime(
                          current.year,
                          selectedMonth,
                        );
                      });
                    },
                    onSelectedNewDay: (newDay) {
                      final DateTime current = _selectedDate ?? DateTime.now();

                      setState(() {
                        _selectedDate = DateTime(
                          current.year,
                          current.month,
                          newDay,
                        );
                      });
                    },
                  ),
                  SizedBox(height: resp.hp(4)),
                  Text(
                    '${remindersInSelectedDay.length} ${remindersInSelectedDay.length == 1 ? 'Reminder' : 'Reminders'} in this day',
                    style: TextStyles.w700(resp.sp16),
                  ),
                  SizedBox(height: resp.hp(3)),
                  if (remindersInSelectedDay.isNotEmpty)
                    RemindersListPerDay(
                      reminders: remindersInSelectedDay,
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
                                  const CustomCircularProgress(color: accent),
                                  SizedBox(height: resp.hp(2)),
                                  Text('Is being removed!',
                                      style: TextStyles.w500(resp.sp16))
                                ],
                              ),
                            );
                            await reminderService
                                .deleteData(reminder.toMap())
                                .whenComplete(() => Navigator.pop(context));
                          },
                        );
                      },
                    )
                  else
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
