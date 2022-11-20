import 'dart:math';

import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:schedulemanager/screens/home_page/widgets/reminder_date_data.dart';
import 'package:schedulemanager/services/auth_service.dart';
import 'package:schedulemanager/utils/responsive_util.dart';
import 'package:schedulemanager/widgets/custom_button.dart';

import '../../constants/constants.dart';
import '../../providers/activities_provider.dart';
import '../../utils/text_styles.dart';
import '../../widgets/reminder_information.dart';
import 'widgets/widgets.dart';

class HomePage extends StatelessWidget {
  static const _maxReminders = 1;
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final ResponsiveUtil resp = ResponsiveUtil.of(context);
    final ActivitiesProvider activities =
        Provider.of<ActivitiesProvider>(context);
    final AuthService auth = Provider.of<AuthService>(context);
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
                bottom: 80,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // const HomeHeader(),
                  Text('Hello ${auth.user!.displayName ?? 'NoName'}!',
                      style: TextStyles.w400(resp.sp16, lightGrey)),
                  Text(
                    'My daily activities',
                    style: TextStyles.w700(resp.sp30),
                  ),
                  SizedBox(height: resp.hp(2)),
                  SizedBox(
                    height: resp.hp(25),
                    width: resp.width,
                    child: PageView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: 2,
                      itemBuilder: (context, index) {
                        return Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 20,
                          ),
                          decoration: BoxDecoration(
                            color: accent,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child: Text(
                                  "Excellent, you're almost done with your activities! ;)",
                                  style: TextStyles.w800(
                                    resp.sp16,
                                    Colors.white,
                                  ),
                                  textAlign: TextAlign.start,
                                ),
                              ),
                              SizedBox(width: resp.wp(2.5)),
                              Expanded(
                                flex: 2,
                                child: CircularPercentIndicator(
                                  radius: resp.hp(6.5),
                                  lineWidth: 13.0,
                                  animation: true,
                                  percent: 0.9,
                                  center: Text(
                                    '90%',
                                    style: TextStyles.w800(
                                      resp.sp16,
                                      Colors.white,
                                    ),
                                  ),
                                  progressColor: tempAccent,
                                  backgroundColor: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: resp.hp(5)),
                  const ActivitiesTypes(),
                  SizedBox(height: resp.hp(1)),
                  Divider(
                    color: lightGrey.withOpacity(0.15),
                    height: resp.hp(1),
                    thickness: 0.5,
                  ),
                  SizedBox(height: resp.hp(1)),
                  Row(
                    children: [
                      Text(
                        '${activities.remindersCount} Reminders',
                        style: TextStyles.w700(resp.sp16, black),
                      ),
                      // const Spacer(),
                      // CustomButton(
                      //   color: lightGrey.withOpacity(0.2),
                      //   text: 'Add',
                      //   height: resp.hp(4),
                      //   style: TextStyles.w500(resp.sp16),
                      //   width: double.infinity,
                      //   constraints: const BoxConstraints(maxWidth: 70),
                      //   prefixWidget:
                      //       Icon(Icons.add, size: resp.sp20, color: accent),
                      //   onTap: () {
                      //     Navigator.pushNamed(context, 'remindersPage');
                      //   },
                      // ),
                    ],
                  ),
                  SizedBox(height: resp.hp(2.5)),
                  if (activities.remindersCount != 0) ...[
                    ...List.generate(
                      activities.remindersCount > _maxReminders
                          ? _maxReminders + 2
                          : activities.remindersCount,
                      (index) => index <= _maxReminders
                          ? ReminderContainer(
                              index: index,
                              leftWidget: ReminderDateData(index: index),
                              middleWidget: const SizedBox(),
                              rightWidget: ReminderInformation(
                                showHourInTop: true,
                                containData: Random().nextBool(),
                              ),
                            )
                          : GestureDetector(
                              onTap: () =>
                                  Navigator.pushNamed(context, 'remindersPage'),
                              child: Container(
                                height: resp.hp(10),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: lightGrey.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Press to see all reminders',
                                      textAlign: TextAlign.center,
                                      style: TextStyles.w600(
                                        resp.sp16,
                                        grey.withOpacity(0.5),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                    )
                  ] else
                    Center(
                      child: Text(
                        'No Activities',
                        style: TextStyles.w500(resp.sp14, lightGrey),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
