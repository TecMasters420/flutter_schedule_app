import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../app/utils/responsive_util.dart';

import '../../../app/config/constants.dart';
import '../../../app/utils/text_styles.dart';

class ReminderDateData extends StatelessWidget {
  final DateTime endDate;
  final Duration timeRemaining;
  const ReminderDateData({
    super.key,
    required this.endDate,
    required this.timeRemaining,
  });

  @override
  Widget build(BuildContext context) {
    final ResponsiveUtil resp = ResponsiveUtil.of(context);
    return Column(
      children: [
        Container(
          height: 5,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: colors[Random().nextInt(colors.length - 1)],
          ),
        ),
        Text(
          endDate.day.toString(),
          style: TextStyles.w500(resp.sp16),
        ),
        Text(
          DateFormat('EEEE').format(endDate).substring(0, 3),
          style: TextStyles.w500(resp.sp16),
        ),
        Text(
          DateFormat('MMMM').format(endDate).substring(0, 3),
          style: TextStyles.w500(resp.sp16),
        ),
      ],
    );
  }
}
