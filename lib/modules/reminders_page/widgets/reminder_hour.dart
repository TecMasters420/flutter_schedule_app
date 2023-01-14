import 'package:flutter/material.dart';

import '../../../app/config/constants.dart';
import '../../../app/utils/text_styles.dart';

class ReminderHour extends StatelessWidget {
  final List<String> dates;
  const ReminderHour({
    super.key,
    required this.dates,
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
                style: TextStyles.w500(14, lightGrey),
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
