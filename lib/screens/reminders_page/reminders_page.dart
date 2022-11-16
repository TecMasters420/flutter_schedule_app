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
  static const int _containers = 10;

  List<Size?>? _infoContainersSize;
  late final List<GlobalKey> _infoContainerKey;

  @override
  void initState() {
    super.initState();
    _infoContainersSize = List.generate(_containers, (index) => null);
    _infoContainerKey = List.generate(_containers, (index) => GlobalKey());
  }

  @override
  Widget build(BuildContext context) {
    final ResponsiveUtil resp = ResponsiveUtil.of(context);

    final DateTime now = DateTime.now();
    final int days = DateTime(now.year, now.month + 1, 1)
        .difference(DateTime(now.year, now.month, 1))
        .inDays;

    SchedulerBinding.instance.addPostFrameCallback((_) {
      for (int x = 0; x < _containers; x++) {
        if (_infoContainerKey[x].currentContext != null &&
            _infoContainersSize![x] == null) {
          final RenderObject? renderBoxRed =
              _infoContainerKey[x].currentContext?.findRenderObject();
          if (renderBoxRed != null) {
            final sizeRed = renderBoxRed.paintBounds;
            setState(() {
              _infoContainersSize![x] = sizeRed.size;
            });
          }
        }
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
                    days: days,
                    onSelectedNewDay: (newDay) {},
                  ),
                  SizedBox(height: resp.hp(2)),
                  Text(
                    'Reminders',
                    style: TextStyles.w700(resp.dp(2), black),
                  ),
                  ...List.generate(_containers, (x) {
                    final Color containerColor =
                        colors[Random().nextInt(colors.length - 1)];
                    return Column(
                      children: [
                        SizedBox(height: resp.hp(3)),
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
                                height: _infoContainersSize![x] != null
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                  }),
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
