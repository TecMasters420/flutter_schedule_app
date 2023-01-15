import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:schedulemanager/app/config/constants.dart';
import 'package:schedulemanager/app/utils/responsive_util.dart';
import 'package:schedulemanager/app/utils/text_styles.dart';
import 'package:schedulemanager/data/models/reminder_model.dart';

class ShortEventDataWidget extends StatelessWidget {
  final ReminderModel event;
  final Color color;

  final ValueNotifier<double> height = ValueNotifier(0);
  final GlobalKey testKey = GlobalKey();

  ShortEventDataWidget({
    super.key,
    required this.event,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final ResponsiveUtil resp = ResponsiveUtil.of(context);
    SchedulerBinding.instance.addPostFrameCallback((_) {
      final RenderObject? renderBoxRed =
          testKey.currentContext?.findRenderObject();
      final size = renderBoxRed!.paintBounds;
      height.value = size.size.height;
    });

    return Container(
      constraints: BoxConstraints(maxWidth: resp.wp(50), minWidth: 0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: backgroundColor,
        boxShadow: shadows,
        border: Border.all(color: lightGrey.withOpacity(0.15)),
      ),
      child: Row(
        key: testKey,
        mainAxisSize: MainAxisSize.min,
        children: [
          ValueListenableBuilder(
            valueListenable: height,
            builder: (context, value, child) {
              return AnimatedContainer(
                curve: Curves.ease,
                duration: const Duration(milliseconds: 400),
                height: (height.value * 0.65),
                width: resp.wp(1),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
              );
            },
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    event.title,
                    style: TextStyles.w700(16),
                  ),
                  SizedBox(height: resp.hp(0.25)),
                  Text(
                    'In ${event.getExpirationTime()}',
                    style: TextStyles.w500(14, grey),
                  ),
                  if (event.endLocation != null &&
                      event.endLocation!.address != null) ...[
                    SizedBox(height: resp.hp(0.5)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.location_on_outlined, size: 20),
                        Text(
                          'End location',
                          style: TextStyles.w700(14),
                        ),
                      ],
                    ),
                    SizedBox(height: resp.hp(0.25)),
                    Text(
                      event.endLocation!.address!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyles.w500(14, grey),
                    ),
                  ],
                  if (event.tasks.isNotEmpty) ...[
                    SizedBox(height: resp.hp(0.5)),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircularPercentIndicator(
                          radius: 8,
                          lineWidth: 2,
                          animation: true,
                          percent: 0.9,
                          linearGradient: accentGradient,
                          backgroundColor: backgroundColor,
                        ),
                        SizedBox(width: resp.wp(1)),
                        Text(
                          'Progress',
                          style: TextStyles.w700(14),
                        ),
                      ],
                    ),
                    SizedBox(height: resp.hp(0.25)),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '90%',
                          style: TextStyles.w500(14, grey),
                        ),
                      ],
                    ),
                  ]
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
