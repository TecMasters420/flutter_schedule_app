import 'package:flutter/material.dart';

import '../../../constants/constants.dart';
import '../../../utils/text_styles.dart';

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
                style: TextStyles.w400(fontSize, lightGrey),
              ),
              if (x < dates.length - 1) const Divider(),
            ],
          ),
        ),
      ],
    );
  }
}
