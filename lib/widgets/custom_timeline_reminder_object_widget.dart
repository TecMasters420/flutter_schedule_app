import 'package:flutter/material.dart';
import 'package:schedulemanager/app/utils/responsive_util.dart';

import '../app/config/constants.dart';
import '../app/utils/text_styles.dart';

class CustomTimeLineReminderObjectWidget extends StatelessWidget {
  final String title;
  final Widget suffixWidget;
  const CustomTimeLineReminderObjectWidget({
    super.key,
    required this.title,
    required this.suffixWidget,
  });

  @override
  Widget build(BuildContext context) {
    final ResponsiveUtil resp = ResponsiveUtil.of(context);
    return Padding(
      padding: const EdgeInsets.only(top: 50),
      child: SizedBox(
        width: resp.width,
        child: SingleChildScrollView(
          clipBehavior: Clip.none,
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: TextStyles.w600(14, black),
              ),
              SizedBox(width: resp.wp(5)),
              suffixWidget,
            ],
          ),
        ),
      ),
    );
  }
}
