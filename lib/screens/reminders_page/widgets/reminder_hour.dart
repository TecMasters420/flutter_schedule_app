import 'package:flutter/material.dart';
import '../../../constants/constants.dart';

import '../../../utils/text_styles.dart';

class ReminderHour extends StatelessWidget {
  final List<String> hours;
  final double fontSize;
  const ReminderHour({
    super.key,
    required this.hours,
    required this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...List.generate(
          hours.length,
          (x) => Column(
            children: [
              Text(
                hours[x],
                style: TextStyles.w400(fontSize, lightGrey),
              ),
              if (x < hours.length - 1) const Divider(),
            ],
          ),
        ),
      ],
    );
  }
}