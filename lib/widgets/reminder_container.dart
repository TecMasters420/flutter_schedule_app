import 'package:flutter/material.dart';

import '../utils/responsive_util.dart';

class ReminderContainer extends StatelessWidget {
  final GlobalKey? containerKey;
  final Widget leftWidget;
  final Widget? middleWidget;
  final Widget rightWidget;
  final int index;
  const ReminderContainer({
    super.key,
    required this.index,
    required this.leftWidget,
    required this.rightWidget,
    this.middleWidget,
    this.containerKey,
  });

  @override
  Widget build(BuildContext context) {
    final ResponsiveUtil resp = ResponsiveUtil.of(context);

    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          key: containerKey ?? GlobalKey(),
          child: Row(
            children: [
              Expanded(flex: 8, child: leftWidget),
              if (middleWidget != null) ...[
                Expanded(flex: 1, child: middleWidget!),
                SizedBox(width: resp.wp(2)),
              ],
              Expanded(flex: 30, child: rightWidget)
            ],
          ),
        ),
        SizedBox(height: resp.hp(5)),
      ],
    );
  }
}
