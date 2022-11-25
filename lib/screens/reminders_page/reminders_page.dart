import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:schedulemanager/models/reminder_model.dart';
import 'package:schedulemanager/services/auth_service.dart';
import '../reminder_details_page/reminders_details_page.dart';
import '../../services/reminder_service.dart';
import '../../utils/responsive_util.dart';
import '../../widgets/custom_back_button.dart';
import '../../widgets/user_profile_picture.dart';

import '../../constants/constants.dart';
import '../../utils/text_styles.dart';
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
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Provider.of<ReminderService>(context, listen: false).getData();
    });
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
    final AuthService auth = Provider.of<AuthService>(context);

    // Get months with reminders
    final List<int> monthsWithReminders = [];
    for (final ReminderModel r in service.reminders) {
      final int reminderEndMonth = r.endDate.toDate().month;
      if (!monthsWithReminders.contains(reminderEndMonth)) {
        monthsWithReminders.add(reminderEndMonth);
      }
    }

    // Get reminders in current month
    final List<ReminderModel> remInMonth = monthsWithReminders.isEmpty
        ? []
        : service.reminders
            .where((r) =>
                r.endDate.toDate().month ==
                (_selectedDate == null
                    ? monthsWithReminders[0]
                    : _selectedDate!.month))
            .toList();
    // Reminders per month
    final Map<int, List<ReminderModel>> remindersInMonth = {};
    for (final ReminderModel r in remInMonth) {
      final int reminderDay = r.endDate.toDate().day;
      remindersInMonth.containsKey(reminderDay)
          ? remindersInMonth[reminderDay]!.add(r)
          : remindersInMonth.addAll({
              reminderDay: [r]
            });
    }

    // Get list of days with reminders
    final List<int> daysWithReminders = remindersInMonth.keys.toList();
    daysWithReminders.sort((a, b) => a.compareTo(b));

    final int remindersInCurrentMonth = remindersInMonth.length;
    final int currentDay =
        _selectedDate == null || !daysWithReminders.contains(_selectedDate!.day)
            ? daysWithReminders[0]
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
                    userImage: auth.userInformation!.imageURL ?? '',
                  )
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
                label:
                    '${remindersInSelectedDay.length} ${remindersInSelectedDay.length == 1 ? 'Reminder' : 'Reminders'} in November ${_selectedDate == null ? daysWithReminders[0] : _selectedDate!.day}',
                initialDay:
                    daysWithReminders.isEmpty ? 0 : daysWithReminders[0],
                days: daysWithReminders,
                initialMonth:
                    monthsWithReminders.isEmpty ? 0 : monthsWithReminders[0],
                months: monthsWithReminders,
                onSelectedNewMonth: (selectedMonth) {
                  final DateTime current = _selectedDate ?? DateTime.now();
                  setState(() {
                    _selectedDate = DateTime(
                      current.year,
                      selectedMonth,
                      current.day,
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
      ),
    );
  }
}
