import 'package:flutter/material.dart';
import 'package:schedulemanager/app/config/constants.dart';
import 'package:schedulemanager/app/utils/responsive_util.dart';
import 'package:schedulemanager/app/utils/text_styles.dart';

import 'animated_progress_chart_widget.dart';
import 'home_announce_container.dart';

const maxProgressBar = 3;

class TasksHomeProgressContainer extends StatelessWidget {
  const TasksHomeProgressContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final ResponsiveUtil resp = ResponsiveUtil.of(context);
    final percents = [23, 50, 21, 100];
    final clampledPercentages = percents.take(maxProgressBar).toList();
    final clampledColors = colors.take(maxProgressBar).toList();
    return HomeAnnounceContainer(
      firstWidgetFlex: 2,
      firstWidget: AnimatedProgressChartWidget(
        progressColors: clampledColors,
        percents: clampledPercentages,
      ),
      secondWidgetFlex: 3,
      secondWidget: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ...List.generate(
            clampledPercentages.length,
            (x) => Padding(
              padding: EdgeInsets.only(top: x != 0 ? resp.hp(1) : 0),
              child: Row(
                children: [
                  Container(
                    height: 10,
                    width: 10,
                    decoration: BoxDecoration(
                      color: clampledColors[x],
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(width: resp.wp(2.5)),
                  Expanded(
                    child: Text(
                      'All Tasks',
                      maxLines: 2,
                      style: TextStyles.w700(14),
                    ),
                  ),
                  SizedBox(width: resp.wp(2.5)),
                  Expanded(
                    child: Text(
                      '${clampledPercentages[x].toString()}%',
                      style: TextStyles.w700(12, grey),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
