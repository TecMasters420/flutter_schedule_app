import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:schedulemanager/app/utils/responsive_util.dart';

import '../../../app/config/constants.dart';
import '../../../app/utils/text_styles.dart';

class ReminderDateData extends StatelessWidget {
  final DateTime endDate;
  final Duration timeRemaining;
  final Color dotColor;
  const ReminderDateData({
    super.key,
    required this.endDate,
    required this.timeRemaining,
    required this.dotColor,
  });

  @override
  Widget build(BuildContext context) {
    final ResponsiveUtil resp = ResponsiveUtil.of(context);
    return Column(
      children: [
        Text(
          endDate.day.toString(),
          style: TextStyles.w800(18),
        ),
        Text(
          DateFormat('EEEE').format(endDate).substring(0, 3),
          style: TextStyles.w500(16),
        ),
        Text(
          DateFormat('MMMM').format(endDate).substring(0, 3),
          style: TextStyles.w500(16),
        ),
        SizedBox(height: resp.hp(1)),
        Container(
          height: 5,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: dotColor,
          ),
        ),
      ],
    );
  }
}
