import 'package:flutter/material.dart';
import '../utils/responsive_util.dart';

import '../constants/constants.dart';
import '../utils/text_styles.dart';

class ReminderInformationWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? value;
  final Widget? extra;
  const ReminderInformationWidget({
    super.key,
    required this.icon,
    required this.title,
    this.value,
    this.extra,
  });

  @override
  Widget build(BuildContext context) {
    final ResponsiveUtil resp = ResponsiveUtil.of(context);

    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              icon,
              color: grey,
              size: resp.sp20,
            ),
            SizedBox(width: resp.wp(5)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyles.w600(resp.sp14),
                  ),
                  if (value != null)
                    Text(
                      value!,
                      style: TextStyles.w500(resp.sp14, grey),
                    ),
                  if (extra != null) ...[
                    SizedBox(height: resp.hp(1)),
                    extra!,
                  ]
                ],
              ),
            )
          ],
        ),
        SizedBox(height: resp.hp(2.5)),
      ],
    );
  }
}
