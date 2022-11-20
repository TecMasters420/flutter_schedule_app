import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:schedulemanager/utils/responsive_util.dart';

import '../../../constants/constants.dart';
import '../../../utils/text_styles.dart';

class ReminderDateData extends StatelessWidget {
  final int index;
  const ReminderDateData({
    super.key,
    required this.index,
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
          '${index + 1}',
          style: TextStyles.w500(resp.sp16),
        ),
        Text(
          DateFormat('EEEE')
              .format(DateTime(
                  DateTime.now().year, DateTime.now().month, index + 1))
              .substring(0, 3),
          style: TextStyles.w500(resp.sp16),
        ),
        Text(
          DateFormat('MMMM').format(DateTime.now()).substring(0, 3),
          style: TextStyles.w500(resp.sp16),
        ),
      ],
    );
  }
}
