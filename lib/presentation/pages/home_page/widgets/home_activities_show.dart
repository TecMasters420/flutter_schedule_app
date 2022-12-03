import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:schedulemanager/presentation/pages/home_page/widgets/home_announce_container.dart';
import '../../../../app/config/constants.dart';
import '../../../../app/utils/responsive_util.dart';
import '../../../../app/utils/text_styles.dart';

class HomeActivitiesShow extends StatelessWidget {
  const HomeActivitiesShow({super.key});

  @override
  Widget build(BuildContext context) {
    final ResponsiveUtil resp = ResponsiveUtil.of(context);
    return PageView(
      physics: const BouncingScrollPhysics(),
      children: [
        HomeAnnounceContainer(
          title: "Excellent, you're almost done with your activities!",
          secondWidget: CircularPercentIndicator(
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
            progressColor: Colors.white,
            backgroundColor: tempAccent,
          ),
        ),
      ],
    );
  }
}
