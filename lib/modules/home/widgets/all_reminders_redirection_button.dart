import 'package:flutter/material.dart';
import 'package:schedulemanager/app/utils/responsive_util.dart';

import '../../../app/config/constants.dart';
import '../../../app/utils/text_styles.dart';

class AllEventsRedirectionButton extends StatelessWidget {
  const AllEventsRedirectionButton({super.key});

  @override
  Widget build(BuildContext context) {
    final ResponsiveUtil resp = ResponsiveUtil.of(context);

    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, 'remindersPage'),
      child: Container(
        height: resp.hp(10),
        width: double.infinity,
        decoration: BoxDecoration(
          color: lightGrey.withOpacity(0.2),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Press to see all reminders',
              textAlign: TextAlign.center,
              style: TextStyles.w600(
                16,
                grey.withOpacity(0.5),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
