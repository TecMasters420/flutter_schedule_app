import 'package:flutter/material.dart';
import 'package:schedulemanager/widgets/responsive_container_widget.dart';
import '../../../app/utils/responsive_util.dart';

class HomeAnnounceContainer extends StatelessWidget {
  final Widget firstWidget;
  final Widget secondWidget;
  final int firstWidgetFlex;
  final int secondWidgetFlex;
  const HomeAnnounceContainer({
    super.key,
    required this.firstWidget,
    required this.secondWidget,
    this.firstWidgetFlex = 3,
    this.secondWidgetFlex = 2,
  });

  @override
  Widget build(BuildContext context) {
    final ResponsiveUtil resp = ResponsiveUtil.of(context);
    return ResponsiveContainerWidget(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Row(
        children: [
          Expanded(flex: firstWidgetFlex, child: firstWidget),
          SizedBox(width: resp.wp(2.5)),
          Expanded(
            flex: secondWidgetFlex,
            child: secondWidget,
          ),
        ],
      ),
    );
  }
}
