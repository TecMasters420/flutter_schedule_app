import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../../../utils/responsive_util.dart';

import '../../../constants/constants.dart';
import '../../../utils/text_styles.dart';

class HomeActivitiesShow extends StatelessWidget {
  const HomeActivitiesShow({super.key});

  @override
  Widget build(BuildContext context) {
    final ResponsiveUtil resp = ResponsiveUtil.of(context);
    return PageView.builder(
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
    );
  }
}
