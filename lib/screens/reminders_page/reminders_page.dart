import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:schedulemanager/models/reminder_model.dart';
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
  final DateTime? initialDate;
  const RemindersPage({
    super.key,
    this.initialDate,
  });

  @override
  State<RemindersPage> createState() => _RemindersPageState();
}

class _RemindersPageState extends State<RemindersPage> {
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialDate ?? DateTime.now();
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

    final List<ReminderModel> inMonth = service.reminders
        .where((r) => r.endDate.toDate().month == _selectedDate.month)
        .toList();
    final Map<int, List<ReminderModel>> remindersInMonth = {};
    for (final ReminderModel r in inMonth) {
      final int reminderDay = r.endDate.toDate().day;
      remindersInMonth.containsKey(reminderDay)
          ? remindersInMonth[reminderDay]!.add(r)
          : remindersInMonth.addAll({
              reminderDay: [r]
            });
    }

    final int remindersInCurrentMonth = remindersInMonth.length;
    final List<ReminderModel> remindersInSelectedDay =
        remindersInCurrentMonth == 0
            ? []
            : remindersInMonth[_selectedDate.day]!.toList();

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
                  Text(
                    'Today is',
                    style: TextStyles.w400(resp.sp16, lightGrey),
                  ),
                  SizedBox(height: resp.hp(0.5)),
                  Text(
                    _getFormattedDate(DateTime.now()),
                    style: TextStyles.w700(resp.sp20, black),
                  ),
                  ScrolleableDaysList(
                    label: 'Reminders in November: $remindersInCurrentMonth',
                    initialDay: remindersInMonth.isEmpty
                        ? 0
                        : remindersInMonth.keys.elementAt(0),
                    days: remindersInMonth.keys.toList(),
                    onSelectedNewDay: (newDay) {
                      final DateTime current = _selectedDate;
                      setState(() {
                        _selectedDate = DateTime(
                          current.year,
                          DateTime.now().month,
                          newDay,
                        );
                      });
                    },
                  ),
                  SizedBox(height: resp.hp(3)),
                  if (remindersInSelectedDay.isNotEmpty)
                    RemindersListPerDay(
                      reminders: remindersInSelectedDay,
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
                    builder: (BuildContext context) =>
                        ReminderDetailsPage(reminder: reminder),
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
