import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:schedulemanager/utils/responsive_util.dart';
import 'package:schedulemanager/widgets/activities_types.dart';
import 'package:schedulemanager/widgets/custom_button.dart';
import 'package:schedulemanager/widgets/map_preview.dart';

import '../constants/constants.dart';
import '../utils/text_styles.dart';
import '../widgets/home_header.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // late final PageController _pageController;

  @override
  void initState() {
    // _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ResponsiveUtil resp = ResponsiveUtil.of(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: accent,
        child: const Icon(Icons.add),
        onPressed: () {},
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.only(
            left: 32,
            right: 32,
            top: 80,
            bottom: 80,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const HomeHeader(),
              SizedBox(height: resp.hp(1)),
              Text(
                'A great day to get better',
                style: TextStyles.w400(resp.dp(1.5), lightGrey),
              ),
              SizedBox(height: resp.hp(5)),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'My daily activities',
                    style: TextStyles.w500(resp.dp(2)),
                  ),
                  const Spacer(),
                  Flexible(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          constraints: const BoxConstraints(maxWidth: 70),
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          decoration: BoxDecoration(
                            color: lightGrey.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.add, color: accent, size: resp.dp(1)),
                              SizedBox(width: resp.wp(1)),
                              Text(
                                'Add',
                                style: TextStyles.w500(resp.dp(1.15)),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: resp.hp(2.5)),
              SizedBox(
                height: resp.hp(25),
                width: resp.width,
                child: PageView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: 2,
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                        color: accent,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: ClipRRect(
                        clipBehavior: Clip.none,
                        borderRadius: BorderRadius.circular(30),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 20,
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child: Text(
                                  "Excellent, you're almost done with your activities! ;)",
                                  style: TextStyles.w800(
                                      resp.dp(1.75), Colors.white),
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
                                        resp.dp(2.5), Colors.white),
                                  ),
                                  progressColor: tempAccent,
                                  backgroundColor: lightGrey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: resp.hp(5)),
              const ActivitiesTypes(),
              SizedBox(height: resp.hp(5)),
              ...List.generate(
                DateTime(DateTime.now().year, DateTime.now().month + 1, 0).day,
                (index) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: resp.hp(2)),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Column(
                            children: [
                              Container(
                                height: 5,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: colors[
                                      Random().nextInt(colors.length - 1)],
                                ),
                              ),
                              Text(
                                '${index + 1}',
                                style: TextStyles.w500(resp.dp(1.75)),
                              ),
                              Text(
                                DateFormat('EEEE')
                                    .format(DateTime(DateTime.now().year,
                                        DateTime.now().month, index + 1))
                                    .substring(0, 3),
                                style: TextStyles.w500(resp.dp(1.75)),
                              ),
                              Text(
                                DateFormat('MMMM')
                                    .format(DateTime.now())
                                    .substring(0, 3),
                                style: TextStyles.w500(resp.dp(1.75)),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: resp.wp(5)),
                        Expanded(
                          flex: 10,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Hour: ',
                                    style: TextStyles.w500(
                                        resp.dp(1.15), lightGrey),
                                  ),
                                  Text(
                                    '11:00 - 11:30',
                                    style: TextStyles.w500(
                                      resp.dp(1.15),
                                      lightGrey,
                                    ),
                                  ),
                                  const Spacer(),
                                  Icon(
                                    Icons.more_horiz_rounded,
                                    color: lightGrey,
                                    size: resp.dp(2.25),
                                  )
                                ],
                              ),
                              SizedBox(height: resp.hp(1)),
                              Text(
                                'Bussiness meeting with Samasdasdasda',
                                style: TextStyles.w700(resp.dp(1.75)),
                                textAlign: TextAlign.start,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: resp.hp(1)),
                              Text(
                                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum',
                                style: TextStyles.w400(resp.dp(1.25), grey),
                                textAlign: TextAlign.start,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                              if (Random().nextInt(100) < 50) ...[
                                SizedBox(height: resp.hp(2)),
                                Text(
                                  'Location: South Portland',
                                  style: TextStyles.w600(resp.dp(1.5)),
                                ),
                                SizedBox(height: resp.hp(0.5)),
                                Row(
                                  children: [
                                    Text(
                                      'Time to arrive: ',
                                      style:
                                          TextStyles.w400(resp.dp(1.25), grey),
                                    ),
                                    Text(
                                      '92 min',
                                      style:
                                          TextStyles.w400(resp.dp(1.25), grey),
                                    ),
                                  ],
                                ),
                                SizedBox(height: resp.hp(2)),
                                const MapPreview(),
                              ],
                              SizedBox(height: resp.hp(2)),
                              Row(
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        'Time left: ',
                                        style: TextStyles.w400(
                                            resp.dp(1.25), grey),
                                      ),
                                      Text(
                                        '1 day',
                                        style: TextStyles.w400(
                                            resp.dp(1.25), grey),
                                      ),
                                    ],
                                  ),
                                  const Spacer(),
                                  CustomButton(
                                    constraints:
                                        const BoxConstraints(maxWidth: 150),
                                    text: 'Details',
                                    color: accent,
                                    height: resp.hp(4),
                                    width: resp.wp(15),
                                    style: TextStyles.w600(
                                        resp.dp(1.15), Colors.white),
                                    onTap: () => Navigator.pushNamed(
                                        context, 'activitiesDetailsPage'),
                                  )
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: resp.hp(1)),
                    Divider(
                      color: lightGrey.withOpacity(0.15),
                      height: resp.dp(2),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
