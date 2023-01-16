import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:schedulemanager/app/config/constants.dart';
import 'package:schedulemanager/app/utils/responsive_util.dart';
import 'package:schedulemanager/app/utils/text_styles.dart';
import 'package:schedulemanager/data/models/reminder_model.dart';
import 'package:schedulemanager/widgets/progress_bar.dart';

class ShortEventDataWidget extends StatelessWidget {
  final ReminderModel event;
  final Color color;
  final void Function(ReminderModel event) onLongPressCallback;

  final ValueNotifier<double> height = ValueNotifier(0);
  final GlobalKey testKey = GlobalKey();

  ShortEventDataWidget({
    super.key,
    required this.event,
    required this.color,
    required this.onLongPressCallback,
  });

  Widget _getStatus() {
    return Chip(
      backgroundColor: red.withOpacity(0.15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      label: Text(
        'High',
        maxLines: 1,
        style: TextStyles.w700(12, red),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ResponsiveUtil resp = ResponsiveUtil.of(context);
    SchedulerBinding.instance.addPostFrameCallback((_) {
      final RenderObject? renderBoxRed =
          testKey.currentContext?.findRenderObject();
      final size = renderBoxRed!.paintBounds;
      height.value = size.size.height;
    });

    final double tasksProgress = event.progress.isNaN ? 0 : event.progress;

    return Container(
      constraints: BoxConstraints(maxWidth: resp.wp(70), minWidth: 0),
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: containerBg,
        boxShadow: shadows,
        border: Border.all(color: lightGrey.withOpacity(0.15)),
      ),
      child: Material(
        child: InkWell(
          onLongPress: () => onLongPressCallback(event),
          borderRadius: BorderRadius.circular(10),
          splashColor: color.withOpacity(0.25),
          highlightColor: lightGrey.withOpacity(0.05),
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
                        topRight: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                    ),
                  );
                },
              ),
              Flexible(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (event.tags.isNotEmpty) ...[
                            Chip(
                              backgroundColor: backgroundColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              label: Text(
                                event.tags.first.name,
                                maxLines: 1,
                                style: TextStyles.w500(12),
                              ),
                            ),
                            if (event.tags.length > 1)
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 2.5,
                                  horizontal: 5,
                                ),
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: accent,
                                ),
                                child: Text(
                                  '${(event.tags.length - 1).toString()}+',
                                  style: TextStyles.w700(10, Colors.white),
                                ),
                              ),
                            const Spacer(),
                            _getStatus(),
                          ],
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              event.title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyles.w700(20),
                            ),
                          ),
                          if (event.tasks.isEmpty) ...[
                            _getStatus(),
                          ]
                        ],
                      ),
                      if (event.tasks.isNotEmpty) ...[
                        SizedBox(height: resp.hp(1)),
                        Text(
                          'Progress',
                          style: TextStyles.w500(12),
                        ),
                        SizedBox(height: resp.hp(1)),
                        ProgressBar(
                          percent: tasksProgress,
                          height: resp.hp(1),
                          width: resp.wp(30),
                        ),
                      ]
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
