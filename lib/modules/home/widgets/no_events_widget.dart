import 'package:flutter/material.dart';
import '../../../app/config/constants.dart';
import '../../../app/utils/responsive_util.dart';
import '../../../widgets/custom_button.dart';

import '../../../app/utils/text_styles.dart';

class NoEventsWidget extends StatelessWidget {
  const NoEventsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final resp = ResponsiveUtil.of(context);
    return Column(
      children: [
        SizedBox(height: resp.hp(1)),
        Opacity(
          opacity: 0.5,
          child: Image.asset(
            'assets/images/no_data_image.png',
            height: resp.hp(15),
            width: resp.width,
          ),
        ),
        SizedBox(height: resp.hp(2.5)),
        Text('No events found', style: TextStyles.w700(16)),
        Text(
          'You can click on the button to add an event.',
          style: TextStyles.w500(14),
        ),
        SizedBox(height: resp.hp(1.5)),
        CustomButton(
          text: 'Add event',
          color: accent,
          height: resp.hp(4),
          width: resp.wp(25),
          onTap: () {},
          style: TextStyles.w500(14, Colors.white),
        ),
      ],
    );
  }
}
