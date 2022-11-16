import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:intl/intl.dart';
import 'package:schedulemanager/screens/activities_details_page/widgets/reminder_hour.dart';
import 'package:schedulemanager/utils/responsive_util.dart';
import 'package:schedulemanager/widgets/custom_back_button.dart';
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
  List<Size?>? _infoContainersSize;

  late List<GlobalKey> _infoContainerKey;
  late Map<int, int> _remindersPerDay;
  late int _monthDays;
  late int _selectedDay;
  late int _lastContainerChecked;
  late int _remindersCountInSelectedDay;

  @override
  void initState() {
    super.initState();
    _selectedDay = 0;
    _monthDays = _getDays(DateTime.now());
    _remindersCountInSelectedDay = _getRemindersCount();
    _clearKeyAndSize();
  }

  void _clearKeyAndSize() {
    _lastContainerChecked = 0;
    _infoContainersSize =
        List.generate(_remindersCountInSelectedDay, (index) => null);
    _infoContainerKey =
        List.generate(_remindersCountInSelectedDay, (index) => GlobalKey());
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

  int _getRemindersCount() => _remindersPerDay.values.elementAt(_selectedDay);

  @override
  Widget build(BuildContext context) {
    final ResponsiveUtil resp = ResponsiveUtil.of(context);
    _remindersCountInSelectedDay = _getRemindersCount();

    SchedulerBinding.instance.addPostFrameCallback((_) {
      while (_lastContainerChecked < _remindersCountInSelectedDay) {
        if (_infoContainerKey[_lastContainerChecked].currentContext != null &&
            _infoContainersSize![_lastContainerChecked] == null) {
          final RenderObject? renderBoxRed =
              _infoContainerKey[_lastContainerChecked]
                  .currentContext
                  ?.findRenderObject();
          if (renderBoxRed != null) {
            final sizeRed = renderBoxRed.paintBounds;
            setState(() {
              _infoContainersSize![_lastContainerChecked] = sizeRed.size;
            });
          }
        }
        _lastContainerChecked++;
      }
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
                      UserProfilePicture(size: resp.dp(2.5))
                    ],
                  ),
                  SizedBox(height: resp.hp(2.5)),
                  Text('Today',
                      style: TextStyles.w400(resp.dp(1.5), lightGrey)),
                  SizedBox(height: resp.hp(0.5)),
                  Text(
                    DateFormat(DateFormat.YEAR_MONTH_DAY, 'en_US').format(
                      DateTime.now().toUtc(),
                    ),
                    style: TextStyles.w700(resp.dp(2.5), black),
                  ),
                  SizedBox(height: resp.hp(5)),
                  Text(
                    'Today Schedule',
                    style: TextStyles.w700(resp.dp(2), black),
                  ),
                  ScrolleableDaysList(
                    days: _monthDays,
                    onSelectedNewDay: (newDay) {
                      if (newDay == _selectedDay) return;
                      setState(() {
                        _selectedDay = newDay;
                        _remindersCountInSelectedDay = _getRemindersCount();
                        _clearKeyAndSize();
                      });
                    },
                  ),
                  SizedBox(height: resp.hp(2)),
                  Text(
                    '$_remindersCountInSelectedDay Reminders',
                    style: TextStyles.w700(resp.dp(2), black),
                  ),
                  SizedBox(height: resp.hp(3)),
                  if (_remindersCountInSelectedDay != 0) ...[
                    ...List.generate(
                      _remindersPerDay.values.elementAt(_selectedDay),
                      (x) {
                        final Color containerColor =
                            colors[Random().nextInt(colors.length - 1)];
                        return Column(
                          children: [
                            if (x != 0) SizedBox(height: resp.hp(3)),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Expanded(
                                  flex: 5,
                                  child: ReminderHour(
                                    hours: const ['09:00', '09:30'],
                                    fontSize: resp.dp(1.25),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 400),
                                    height: _infoContainersSize![x] != null &&
                                            _lastContainerChecked ==
                                                _infoContainerKey.length
                                        ? _infoContainersSize![x]?.height
                                        : 0,
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(100),
                                          bottomLeft: Radius.circular(100)),
                                      gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          containerColor,
                                          containerColor.withOpacity(0.7),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                // Two expanded
                                Expanded(
                                  flex: 30,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 20),
                                    child: Column(
                                      key: _infoContainerKey[x],
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Sprint Planing Period 02 in Okt 2021',
                                          style: TextStyles.w600(
                                            resp.dp(1.75),
                                          ),
                                          textAlign: TextAlign.start,
                                        ),
                                        SizedBox(height: resp.hp(0.5)),
                                        Text(
                                          'Neque porro quisquam est qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit..',
                                          style: TextStyles.w400(
                                            resp.dp(1.25),
                                            lightGrey,
                                          ),
                                          textAlign: TextAlign.start,
                                        ),
                                        SizedBox(height: resp.hp(0.5)),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.access_time_rounded,
                                              size: resp.dp(1.75),
                                              color: lightGrey,
                                            ),
                                            SizedBox(width: resp.wp(1)),
                                            Text(
                                              'Time: 09:00 - 09:00',
                                              style: TextStyles.w400(
                                                  resp.dp(1), lightGrey),
                                              textAlign: TextAlign.start,
                                            )
                                          ],
                                        ),
                                        SizedBox(height: resp.hp(0.5)),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.location_on_outlined,
                                              size: resp.dp(1.75),
                                              color: lightGrey,
                                            ),
                                            SizedBox(width: resp.wp(1)),
                                            Text(
                                              'Location: Tijuana, BC.',
                                              style: TextStyles.w400(
                                                  resp.dp(1), lightGrey),
                                              textAlign: TextAlign.start,
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        );
                      },
                    ),
                  ] else
                    Center(
                      child: Text(
                        'No reminders',
                        style: TextStyles.w500(resp.dp(2), lightGrey),
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
                finalHeight: resp.hp(50),
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
