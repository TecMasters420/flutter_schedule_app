import 'package:flutter/material.dart';
import 'package:schedulemanager/app/utils/responsive_util.dart';

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
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: SingleChildScrollView(
        clipBehavior: Clip.none,
        scrollDirection: Axis.horizontal,
        physics: suffixWidget == null
            ? const NeverScrollableScrollPhysics()
            : const BouncingScrollPhysics(),
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
              suffixWidget ??
                  Expanded(
                    child: Container(
                      height: 1,
                      color: lightGrey.withOpacity(0.25),
                    ),
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
