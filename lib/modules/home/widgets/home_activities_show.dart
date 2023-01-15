import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'home_announce_container.dart';
import '../../../app/config/constants.dart';
import '../../../app/utils/text_styles.dart';

class HomeActivitiesShow extends StatelessWidget {
  const HomeActivitiesShow({super.key});

  @override
  Widget build(BuildContext context) {
    return PageView(
      clipBehavior: Clip.none,
      physics: const BouncingScrollPhysics(),
      children: [
        HomeAnnounceContainer(
          title: "Excellent, you're almost done with your activities!",
          secondWidget: CircularPercentIndicator(
            radius: 60,
            lineWidth: 13.0,
            animation: true,
            percent: 0.9,
            linearGradient: accentGradient,
            backgroundColor: backgroundColor,
            center: Text(
              '90%',
              style: TextStyles.w800(16),
            ),
          ),
        ),
      ],
    );
  }
}
