import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:schedulemanager/models/reminder_model.dart';
import 'package:schedulemanager/models/tag_model.dart';
import 'package:schedulemanager/models/task_model.dart';
import 'package:schedulemanager/screens/reminder_details_page/widgets/reminder_hour.dart';
import 'package:schedulemanager/services/base_service.dart';
import 'package:schedulemanager/services/reminder_service.dart';
import 'package:schedulemanager/widgets/reminder_container.dart';
import 'package:schedulemanager/utils/responsive_util.dart';
import 'package:schedulemanager/widgets/custom_back_button.dart';
import 'package:schedulemanager/widgets/reminder_information.dart';
import 'package:schedulemanager/widgets/user_profile_picture.dart';

import '../../constants/constants.dart';
import '../../utils/text_styles.dart';
import '../home_page/widgets/expandible_bottom_container.dart';
import 'widgets/widgets.dart';

class RemindersPage extends StatefulWidget {
  const RemindersPage({super.key});

  @override
  State<RemindersPage> createState() => _RemindersPageState();
}

class _RemindersPageState extends State<RemindersPage> {
  late bool _containersHeightIsGen;
  late List<GlobalKey> _keys;
  late List<Size?> _sizes;
  late List<ReminderModel> _remindersToShow;
  late DateTime _selectedDate;
  late int _monthDays;

  @override
  void initState() {
    super.initState();
    _sizes = [];
    _keys = [];
    _containersHeightIsGen = false;
    _remindersToShow = [];
    _selectedDate = DateTime.now();
    _monthDays = _getDays(DateTime.now());
    _getReminders();
  }

  void _getReminders() async {
    final service = Provider.of<ReminderService>(context, listen: false);
    await service.getData();
    _remindersToShow = service.getRemindersPerDate(_selectedDate);
    _clearKeyAndSize(_remindersToShow.length);
  }

  void _clearKeyAndSize(final int quantity) {
    _containersHeightIsGen = false;
    _sizes = List.generate(quantity, (index) => null);
    _keys = List.generate(quantity, (index) => GlobalKey());
  }

  int _getDays(final DateTime date) {
    final int days = DateTime(date.year, date.month + 1, 1)
        .difference(DateTime(date.year, date.month, 1))
        .inDays;
    return days;
  }

  @override
  Widget build(BuildContext context) {
    final ResponsiveUtil resp = ResponsiveUtil.of(context);
    final ReminderService service = Provider.of<ReminderService>(context);

    SchedulerBinding.instance.addPostFrameCallback((_) async {
      if (_containersHeightIsGen) return;
      for (int x = 0; x < _keys.length; x++) {
        final RenderObject? renderBoxRed =
            _keys[x].currentContext?.findRenderObject();
        final sizeRed = renderBoxRed!.paintBounds;
        _sizes[x] = sizeRed.size;
      }
      setState(() {
        _containersHeightIsGen = true;
      });
    });

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final DateTime now = DateTime.now();
          final ReminderModel reminder = ReminderModel(
            creationDate: Timestamp.fromDate(now),
            description: 'Generic desc',
            startDate: Timestamp.fromDate(DateTime.now()),
            endDate:
                Timestamp.fromDate(DateTime(now.year, now.month, now.day + 2)),
            location: const GeoPoint(30, 30),
            title: 'Generic title',
            uid: FirebaseAuth.instance.currentUser!.uid,
            expectedTemp: 32,
            tasks: [
              TaskModel(
                name: 'Start Project',
                isCompleted: true,
              ),
            ],
            tags: [
              TagModel(name: 'StandUp'),
            ],
          );
          await ReminderService().create(reminder.toMap());
        },
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.only(
                left: 32,
                right: 32,
                top: 50,
                bottom: 100,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
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
                  Text('Today', style: TextStyles.w400(resp.sp16, lightGrey)),
                  SizedBox(height: resp.hp(0.5)),
                  Text(
                    DateFormat(DateFormat.YEAR_MONTH_DAY, 'en_US').format(
                      DateTime.now().toUtc(),
                    ),
                    style: TextStyles.w700(resp.sp20, black),
                  ),
                  SizedBox(height: resp.hp(5)),
                  Text(
                    'Today Schedule',
                    style: TextStyles.w700(resp.sp20, black),
                  ),
                  ScrolleableDaysList(
                    initialDay: _selectedDate.day - 1,
                    days: _monthDays,
                    onSelectedNewDay: (newDay) {
                      if (newDay == _selectedDate.day) return;
                      final DateTime current = _selectedDate;
                      setState(() {
                        _selectedDate = DateTime(
                            current.year, DateTime.now().month, newDay);
                        _remindersToShow =
                            service.getRemindersPerDate(_selectedDate);
                        _clearKeyAndSize(_remindersToShow.length);
                      });
                    },
                  ),
                  SizedBox(height: resp.hp(2)),
                  Text(
                    '${_remindersToShow.length} Reminders',
                    style: TextStyles.w700(resp.sp20, black),
                  ),
                  SizedBox(height: resp.hp(3)),
                  if (_remindersToShow.isNotEmpty) ...[
                    ...List.generate(
                      _remindersToShow.length,
                      (x) {
                        final Color containerColor =
                            colors[Random().nextInt(colors.length - 1)];
                        return ReminderContainer(
                          containerKey: _keys[x],
                          index: x,
                          leftWidget: ReminderHour(
                            hours: const ['09:00', '09:30'],
                            fontSize: resp.sp14,
                          ),
                          middleWidget: AnimatedContainer(
                            curve: Curves.easeIn,
                            duration: const Duration(milliseconds: 300),
                            height: _sizes[x] == null ? 0 : _sizes[x]!.height,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: containerColor,
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          rightWidget: ReminderInformation(
                            reminder: _remindersToShow[x],
                            showHourInTop: false,
                          ),
                        );
                      },
                    ),
                  ] else
                    Center(
                      child: Text(
                        'No reminders',
                        style: TextStyles.w500(resp.sp20, lightGrey),
                      ),
                    ),
                  SizedBox(height: resp.hp(1)),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(
                left: 32,
                right: 32,
                bottom: 20,
              ),
              child: ExpandibleBottomContainer(
                initialHeight: resp.hp(6),
                finalHeight: resp.hp(75),
                initialWidth: resp.wp(13),
                finalWidth: resp.width,
                iconSize: resp.dp(3),
              ),
            ),
          )
        ],
      ),
    );
  }
}
