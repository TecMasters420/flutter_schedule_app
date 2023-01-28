import 'dart:math';

import 'package:flutter/material.dart';
import 'package:schedulemanager/app/config/constants.dart';
import 'package:schedulemanager/app/utils/responsive_util.dart';
import 'package:schedulemanager/app/utils/text_styles.dart';
import 'package:schedulemanager/modules/home/models/user_progress_model.dart';

import 'animated_progress_chart_widget.dart';
import 'home_announce_container.dart';

const maxProgressBar = 3;

class TasksHomeProgressContainer extends StatelessWidget {
  const TasksHomeProgressContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final ResponsiveUtil resp = ResponsiveUtil.of(context);
    final styles = TextStyles.of(context);

    final percentsName = ['All Tasks', 'Expired Tasks', 'Next Tasks'];
    final percents = List.generate(
      percentsName.length,
      (x) => UserProgressModel(
        percent: Random().nextDouble() * 100,
        name: percentsName[x],
      ),
    ).toList();
    final clampledPercentages = percents.take(maxProgressBar).toList();
    final clampledColors = colors.take(maxProgressBar).toList();
    return HomeAnnounceContainer(
      firstWidgetFlex: 2,
      firstWidget: AnimatedProgressChartWidget(
        progressColors: clampledColors,
        percents: clampledPercentages,
      ),
      secondWidgetFlex: 3,
      secondWidget: Padding(
        padding: EdgeInsets.only(left: resp.wp(5)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Weekly progress',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: styles.w700(18),
            ),
            const Spacer(),
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
                        shape: BoxShape.rectangle,
                        color: clampledColors[x],
                        borderRadius: BorderRadius.circular(2.5),
                      ),
                    ),
                    SizedBox(width: resp.wp(2.5)),
                    Expanded(
                      flex: 2,
                      child: Text(
                        clampledPercentages[x].name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: styles.w700(12),
                      ),
                    ),
                    SizedBox(width: resp.wp(2.5)),
                    Expanded(
                      child: Text(
                        '${clampledPercentages[x].percent.toStringAsFixed(2)}%',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: styles.w600(12, grey),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
