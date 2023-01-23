import 'package:flutter/material.dart';
import '../../../app/utils/responsive_util.dart';

import '../../../app/config/constants.dart';
import '../../../app/utils/text_styles.dart';

class AllEventsRedirectionButton extends StatelessWidget {
  const AllEventsRedirectionButton({super.key});

  @override
  Widget build(BuildContext context) {
    final ResponsiveUtil resp = ResponsiveUtil.of(context);

    return GestureDetector(
      child: SizedBox(
        height: resp.hp(10),
        width: resp.width,
        child: Material(
          color: lightBlue,
          borderRadius: BorderRadius.circular(20),
          child: InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: () => Navigator.pushNamed(context, 'remindersPage'),
            splashColor: accent.withOpacity(0.25),
            highlightColor: Colors.transparent,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Press to see all events',
                  textAlign: TextAlign.center,
                  style: TextStyles.w700(
                    18,
                    accent,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
