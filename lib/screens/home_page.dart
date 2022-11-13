import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:schedulemanager/utils/responsive_util.dart';
import 'package:schedulemanager/widgets/reminders_stream.dart';

import '../constants/constants.dart';
import '../utils/text_styles.dart';
import '../widgets/home_header.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final PageController _pageController;

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ResponsiveUtil resp = ResponsiveUtil.of(context);
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
            top: 80,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const HomeHeader(),
              SizedBox(height: resp.hp(2.5)),
              Row(
                children: [
                  Text('Hello, ', style: TextStyles.w400(42)),
                  Text('Francisco!', style: TextStyles.w400(42, lightGrey)),
                ],
              ),
              SizedBox(height: resp.hp(1)),
              Text(
                'A great day to get better',
                style: TextStyles.w400(14, lightGrey),
              ),
              SizedBox(height: resp.hp(5)),
              Row(
                children: [
                  Text(
                    'My daily activities',
                    style: TextStyles.w500(20),
                  ),
                  const Spacer(),
                  Flexible(
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      decoration: BoxDecoration(
                        color: lightGrey.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.add, color: accent),
                          SizedBox(width: resp.wp(1)),
                          Text(
                            'Add',
                            style: TextStyles.w500(14),
                          ),
                        ],
                      ),
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
                        color: Colors.green[200],
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: ClipRRect(
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
                                  style: TextStyles.w800(18, Colors.white),
                                  textAlign: TextAlign.start,
                                ),
                              ),
                              SizedBox(width: resp.wp(2.5)),
                              Expanded(
                                flex: 2,
                                child: CircularPercentIndicator(
                                  radius: 60,
                                  lineWidth: 13.0,
                                  animation: true,
                                  percent: 0.9,
                                  center: Text(
                                    '90%',
                                    style: TextStyles.w800(18, Colors.white),
                                  ),
                                  progressColor: Colors.white,
                                  backgroundColor: Colors.green[100]!,
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
              Row(
                children: [
                  const Spacer(),
                  Text(
                    'Next',
                    style: TextStyles.w600(16),
                  ),
                  const Spacer(),
                  Text(
                    'Not completed',
                    style: TextStyles.w400(16, grey),
                  ),
                  const Spacer(),
                  Text(
                    'Canceled',
                    style: TextStyles.w400(16, grey),
                  ),
                  const Spacer(),
                ],
              ),
              RemindersStream()
            ],
          ),
        ),
      ),
    );
  }
}
