import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/route_manager.dart';
import 'package:intl/intl.dart';
import 'package:schedulemanager/app/config/constants.dart';
import 'package:schedulemanager/app/utils/responsive_util.dart';
import 'package:schedulemanager/app/utils/text_styles.dart';
import 'package:schedulemanager/data/models/event_model.dart';
import 'package:schedulemanager/routes/app_routes.dart';
import 'package:schedulemanager/widgets/progress_bar.dart';

class ShortEventDataWidget extends StatelessWidget {
  final EventModel event;
  final Color color;
  final void Function(EventModel event) onLongPressCallback;

  final ValueNotifier<double> height = ValueNotifier(0);
  final GlobalKey testKey = GlobalKey();

  ShortEventDataWidget({
    super.key,
    required this.event,
    required this.color,
    required this.onLongPressCallback,
  });

  @override
  Widget build(BuildContext context) {
    final ResponsiveUtil resp = ResponsiveUtil.of(context);
    final styles = TextStyles.of(context);
    SchedulerBinding.instance.addPostFrameCallback((_) {
      final RenderObject? renderBoxRed =
          testKey.currentContext?.findRenderObject();
      final size = renderBoxRed!.paintBounds;
      height.value = size.size.height;
    });

    final double tasksProgress = event.progress.isNaN ? 0 : event.progress;

    Widget _getStatus() {
      return Chip(
        backgroundColor: red.withOpacity(0.15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        label: Text(
          'High',
          maxLines: 1,
          style: styles.w700(12, red),
        ),
      );
    }

    return Container(
      constraints: BoxConstraints(maxWidth: resp.wp(70), minWidth: 0),
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: containerBg,
        boxShadow: shadows,
      ),
      child: Material(
        child: InkWell(
          onTap: () => Get.toNamed(AppRoutes.eventDetails, arguments: event.id),
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
                    height: height.value,
                    width: resp.wp(2),
                    decoration: BoxDecoration(
                      color: color,
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
                              backgroundColor: blueAccent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              label: Text(
                                '#${event.tags.first.name.trim()}',
                                maxLines: 1,
                                style: styles.w700(12, Colors.white),
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
                                  color: blueAccent,
                                ),
                                child: Text(
                                  '${(event.tags.length - 1).toString()}+',
                                  style: styles.w700(10, Colors.white),
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
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  event.title,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: styles.w700(16),
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.flag,
                                      color: red,
                                      size: 15,
                                    ),
                                    Text(
                                      'Due ${DateFormat('hh:mm a').format(event.endDate)} ',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: styles.w500(12, grey),
                                    ),
                                  ],
                                )
                              ],
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
                          style: styles.w700(12),
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
