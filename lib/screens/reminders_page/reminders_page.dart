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
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Provider.of<ReminderService>(context, listen: false).getData();
    });
    _selectedDate = DateTime.now();
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

    final List<int> monthsWithReminders = [];
    for (final ReminderModel r in service.reminders) {
      final int reminderEndMonth = r.endDate.toDate().month;
      if (!monthsWithReminders.contains(reminderEndMonth)) {
        monthsWithReminders.add(reminderEndMonth);
      }
    }

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
    debugPrint(
        '${remindersInMonth.keys} ${_selectedDate.day} ${_selectedDate.month} ${remindersInMonth.keys} ${remindersInMonth[23]!.first.title}');
    final List<ReminderModel> remindersInSelectedDay =
        remindersInCurrentMonth == 0
            ? []
            : remindersInMonth.keys.contains(_selectedDate.day)
                ? remindersInMonth[_selectedDate.day]!.toList()
                : [];

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
                    'Reminders in November ${_selectedDate.day}: $remindersInCurrentMonth',
                initialDay: remindersInMonth.isEmpty
                    ? 0
                    : remindersInMonth.keys.elementAt(0),
                days: remindersInMonth.keys.toList(),
                initialMonth:
                    monthsWithReminders.isEmpty ? 0 : DateTime.now().month,
                months: monthsWithReminders,
                onSelectedNewMonth: (selectedMonth) {
                  final DateTime current = _selectedDate;
                  setState(() {
                    _selectedDate = DateTime(
                      current.year,
                      selectedMonth,
                      _selectedDate.day,
                    );
                  });
                },
                onSelectedNewDay: (newDay) {
                  final DateTime current = _selectedDate;
                  setState(() {
                    _selectedDate = DateTime(
                      current.year,
                      _selectedDate.month,
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
