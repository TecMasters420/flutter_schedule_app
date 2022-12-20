import 'package:flutter/material.dart';
import 'package:schedulemanager/app/config/app_colors.dart';

import '../../../app/config/constants.dart';
import '../../../app/utils/text_styles.dart';

class ReminderHour extends StatelessWidget {
  final List<String> dates;
  final double fontSize;
  const ReminderHour({
    super.key,
    required this.dates,
    required this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...List.generate(
          dates.length,
          (x) => Column(
            children: [
              Text(
                dates[x],
                style: TextStyles.w400(fontSize, grey),
              ),
              if (x < dates.length - 1)
                const Divider(color: lightGrey, thickness: 0.25),
            ],
          ),
        ),
      ],
    );
  }
}
