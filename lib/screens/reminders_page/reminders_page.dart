import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../models/reminder_model.dart';
import '../reminder_details_page/reminders_details_page.dart';
import '../../services/reminder_service.dart';
import '../../utils/responsive_util.dart';
import '../../widgets/custom_back_button.dart';
import '../../widgets/user_profile_picture.dart';

import '../../constants/constants.dart';
import '../../utils/text_styles.dart';
import '../reminder_details_page/widgets/expandible_creation_or_edit_reminder.dart';
import 'widgets/widgets.dart';

class RemindersPage extends StatefulWidget {
  const RemindersPage({super.key});

  @override
  State<RemindersPage> createState() => _RemindersPageState();
}

class _RemindersPageState extends State<RemindersPage> {
  late List<ReminderModel> _remindersToShow;
  late DateTime _selectedDate;
  late int _monthDays;

  @override
  void initState() {
    super.initState();
    _remindersToShow = [];
    _selectedDate = DateTime.now();
    _monthDays = _getDays(DateTime.now());
    _getReminders();
  }

  void _getReminders() async {
    final service = Provider.of<ReminderService>(context, listen: false);
    await service.getData();
    _remindersToShow = service.getRemindersPerDate(_selectedDate);
  }

  int _getDays(final DateTime date) {
    final int days = DateTime(date.year, date.month + 1, 1)
        .difference(DateTime(date.year, date.month, 1))
        .inDays;
    return days;
  }

  String _getFormattedDate(final DateTime date) {
    return DateFormat(DateFormat.YEAR_MONTH_DAY, 'en_US').format(
      date.toUtc(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ResponsiveUtil resp = ResponsiveUtil.of(context);
    final ReminderService service = Provider.of<ReminderService>(context);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
          left: 32,
          right: 32,
          top: 50,
          bottom: 20,
        ),
        child: Stack(
          children: [
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const CustomBackButton(),
                      const Spacer(),
                      UserProfilePicture(size: resp.sp20)
                    ],
                  ),
                  SizedBox(height: resp.hp(2.5)),
                  Text('Today is',
                      style: TextStyles.w400(resp.sp16, lightGrey)),
                  SizedBox(height: resp.hp(0.5)),
                  Text(
                    _getFormattedDate(DateTime.now()),
                    style: TextStyles.w700(resp.sp20, black),
                  ),
                  ScrolleableDaysList(
                    label:
                        '${_getFormattedDate(_selectedDate).split(',')[0]} Schedules',
                    initialDay: _selectedDate.day - 1,
                    days: _monthDays,
                    onSelectedNewDay: (newDay) {
                      final DateTime current = _selectedDate;
                      setState(() {
                        _selectedDate = DateTime(
                            current.year, DateTime.now().month, newDay);
                        _remindersToShow =
                            service.getRemindersPerDate(_selectedDate);
                      });
                    },
                  ),
                  SizedBox(height: resp.hp(2)),
                  Text(
                    '${_remindersToShow.length} Reminders',
                    style: TextStyles.w700(resp.sp20, black),
                  ),
                  SizedBox(height: resp.hp(3)),
                  if (_remindersToShow.isNotEmpty)
                    RemindersListPerDay(reminders: _remindersToShow)
                  else
                    Center(
                      child: Text(
                        'No reminders',
                        style: TextStyles.w500(resp.sp20, lightGrey),
                      ),
                    ),
                  SizedBox(height: resp.hp(5)),
                ],
              ),
            ),
            ExpandibleCreationOrEditReminder(
              icon: Icons.add,
              initialHeight: resp.hp(6),
              finalHeight: resp.hp(50),
              initialWidth: resp.wp(13),
              finalWidth: resp.width,
              iconSize: resp.dp(3),
              onAcceptCallback: (reminder) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ReminderDetailsPage(
                      reminder: reminder,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
