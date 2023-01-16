import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:schedulemanager/app/utils/responsive_util.dart';
import 'package:schedulemanager/modules/reminders_page/controllers/events_page_scroll_controller.dart';

import '../app/config/constants.dart';
import '../app/utils/text_styles.dart';

class CustomTimeLineReminderObjectWidget extends StatelessWidget {
  final String title;
  final TextStyle? titleStyle;
  final Widget? suffixWidget;
  const CustomTimeLineReminderObjectWidget({
    super.key,
    required this.title,
    required this.suffixWidget,
    this.titleStyle,
  });

  @override
  Widget build(BuildContext context) {
    final ResponsiveUtil resp = ResponsiveUtil.of(context);

    if (suffixWidget == null) {
      return Padding(
        padding: const EdgeInsets.only(top: 10),
        child: SizedBox(
          width: resp.width,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: titleStyle ?? TextStyles.w600(14, black),
              ),
              SizedBox(width: resp.wp(5)),
              Expanded(
                  child: Container(
                height: 1,
                color: lightGrey.withOpacity(0.25),
              ))
            ],
          ),
        ),
      );
    }

    final maxLeftScroll = resp.wp(10);
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: SizedBox(
        width: resp.width,
        child: GetBuilder(
          tag: title,
          init: EventsPageScrollController(),
          builder: (scroll) {
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Obx(() {
                  final scrollPosition = scroll.value.value;
                  final percent = scrollPosition / maxLeftScroll;
                  final opacity = clampDouble(percent, 0, 1);
                  return Opacity(
                    opacity: 1 - opacity,
                    child: Text(
                      title,
                      style: titleStyle ?? TextStyles.w600(14, black),
                    ),
                  );
                }),
                SizedBox(width: resp.wp(5)),
                Expanded(
                  child: suffixWidget == null
                      ? Container(
                          height: 1,
                          color: lightGrey.withOpacity(0.25),
                        )
                      : SingleChildScrollView(
                          controller: scroll.controller,
                          physics: const BouncingScrollPhysics(),
                          clipBehavior: Clip.none,
                          scrollDirection: Axis.horizontal,
                          child: suffixWidget,
                        ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
