import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import '../utils/responsive_util.dart';

class ReminderContainer extends StatelessWidget {
  final Color color;
  final Widget leftWidget;
  final Widget rightWidget;

  final ValueNotifier<double> height = ValueNotifier(0);
  final GlobalKey testKey = GlobalKey();
  bool isGenerated = false;

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
      if (!isGenerated) {
        isGenerated = true;
        final RenderObject? renderBoxRed =
            testKey.currentContext?.findRenderObject();
        final size = renderBoxRed!.paintBounds;
        height.value = size.size.height;
      }
    });

    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          key: testKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
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
                            curve: Curves.ease,
                            duration: const Duration(milliseconds: 350),
                            height: height.value,
                            width: double.infinity,
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
          ),
        ),
        SizedBox(height: resp.hp(2.5)),
      ],
    );
  }
}
