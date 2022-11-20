import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:intl/intl.dart';
import 'package:schedulemanager/screens/reminder_details_page/widgets/reminder_hour.dart';
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
  late Map<int, int> _remindersPerDay;
  late int _monthDays;
  late int _selectedDay;
  late int _remindersCountInSelectedDay;

  late bool _containersHeightIsGen;
  late List<GlobalKey> _keys;
  late List<Size?> _sizes;
  late List<bool> _tempContainData;

  @override
  void initState() {
    super.initState();
    _selectedDay = 0;
    _monthDays = _getDays(DateTime.now());
    _remindersCountInSelectedDay = _getRemindersCount;
    _tempContainData = List.generate(
        _remindersCountInSelectedDay, (index) => Random().nextBool());
    _clearKeyAndSize();
  }

  void _clearKeyAndSize() {
    _containersHeightIsGen = false;
    _sizes = List.generate(_remindersCountInSelectedDay, (index) => null);
    _keys = List.generate(_remindersCountInSelectedDay, (index) => GlobalKey());
  }

  int _getDays(final DateTime date) {
    final int days = DateTime(date.year, date.month + 1, 1)
        .difference(DateTime(date.year, date.month, 1))
        .inDays;

    _remindersPerDay = {};
    for (int x = 0; x <= days; x++) {
      _remindersPerDay.addAll({x: Random().nextInt(10)});
    }
    return days;
  }

  int get _getRemindersCount => _remindersPerDay.values.elementAt(_selectedDay);

  @override
  Widget build(BuildContext context) {
    final ResponsiveUtil resp = ResponsiveUtil.of(context);

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
                    days: _monthDays,
                    onSelectedNewDay: (newDay) {
                      if (newDay == _selectedDay) return;
                      setState(() {
                        _selectedDay = newDay;
                        _remindersCountInSelectedDay = _getRemindersCount;
                        _clearKeyAndSize();
                      });
                    },
                  ),
                  SizedBox(height: resp.hp(2)),
                  Text(
                    '$_remindersCountInSelectedDay Reminders',
                    style: TextStyles.w700(resp.sp20, black),
                  ),
                  SizedBox(height: resp.hp(3)),
                  if (_getRemindersCount != 0) ...[
                    ...List.generate(
                      _getRemindersCount,
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
                            showHourInTop: false,
                            containData: _tempContainData[x],
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
