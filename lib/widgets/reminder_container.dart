import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import '../app/utils/responsive_util.dart';

class ReminderContainer extends StatelessWidget {
  final Color color;
  final Widget leftWidget;
  final Widget rightWidget;

  final ValueNotifier<double> height = ValueNotifier(0);
  final GlobalKey testKey = GlobalKey();

  ReminderContainer({
    super.key,
    required this.color,
    required this.leftWidget,
    required this.rightWidget,
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

    return Column(
      children: [
        Column(
          key: testKey,
          children: [
            Row(
              children: [
                Expanded(flex: 8, child: leftWidget),
                Expanded(
                  flex: 1,
                  child: ValueListenableBuilder(
                    valueListenable: height,
                    builder: (context, value, child) {
                      return AnimatedContainer(
                        curve: Curves.fastOutSlowIn,
                        duration: const Duration(milliseconds: 400),
                        height: height.value,
                        width: resp.width,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: color,
                          borderRadius: BorderRadius.circular(20),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(width: resp.wp(2)),
                Expanded(flex: 30, child: rightWidget),
                SizedBox(width: resp.wp(1)),
              ],
            ),
          ],
        ),
        SizedBox(height: resp.hp(2.5)),
      ],
    );
  }
}
