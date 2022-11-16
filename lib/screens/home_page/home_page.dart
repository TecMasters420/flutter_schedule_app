import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:schedulemanager/utils/responsive_util.dart';
import 'package:schedulemanager/widgets/custom_button.dart';

import '../../constants/constants.dart';
import '../../providers/activities_provider.dart';
import '../../utils/text_styles.dart';
import 'widgets/widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ResponsiveUtil resp = ResponsiveUtil.of(context);
    final ActivitiesProvider activities =
        Provider.of<ActivitiesProvider>(context);
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
                children: [
                  const HomeHeader(),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'My daily activities',
                        style: TextStyles.w500(resp.dp(2)),
                      ),
                      const Spacer(),
                      Flexible(
                        child: CustomButton(
                          color: lightGrey.withOpacity(0.1),
                          text: 'Add',
                          height: resp.hp(3.5),
                          style: TextStyles.w500(resp.dp(1.15)),
                          width: resp.wp(20),
                          constraints: const BoxConstraints(maxWidth: 70),
                          prefixWidget:
                              Icon(Icons.add, size: resp.dp(2), color: accent),
                          onTap: () {
                            Navigator.pushNamed(context, 'remindersPage');
                          },
                        ),
                      ),
                    ],
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
                  SizedBox(height: resp.hp(5)),
                  if (activities.remindersCount != 0) ...[
                    ...List.generate(
                      // DateTime(DateTime.now().year, DateTime.now().month + 1, 0)
                      //     .day,
                      activities.remindersCount,
                      (index) => ActivityHomeContainer(index: index),
                    )
                  ] else
                    Center(
                      child: Text(
                        'No Activities',
                        style: TextStyles.w500(resp.dp(1.5), lightGrey),
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
