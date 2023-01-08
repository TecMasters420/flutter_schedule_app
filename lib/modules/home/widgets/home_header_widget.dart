import 'package:flutter/material.dart';
import '../../../app/config/constants.dart';
import '../../../app/utils/responsive_util.dart';
import '../../../widgets/user_profile_picture.dart';

import '../../../app/utils/text_styles.dart';

class HomeHeaderWidget extends StatelessWidget {
  const HomeHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final ResponsiveUtil resp = ResponsiveUtil.of(context);

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              children: [
                UserProfilePicture(
                  height: resp.hp(4),
                  width: resp.wp(10),
                  userImage: '',
                ),
                SizedBox(width: resp.wp(2)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Francisco Rodríguez',
                      style: TextStyles.w700(14),
                    ),
                    Text(
                      'View profile',
                      style: TextStyles.w700(12, accent),
                    ),
                  ],
                )
              ],
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 5),
              width: resp.wp(10),
              decoration: BoxDecoration(
                color: containerBg,
                borderRadius: BorderRadius.circular(15),
              ),
              child: const Icon(Icons.notifications_none_rounded, size: 30),
            ),
          ],
        ),
        SizedBox(height: resp.hp(2.5)),
        Container(
          height: resp.hp(10),
          width: resp.width,
          decoration: BoxDecoration(
            gradient: accentGradient,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Schedule App',
                style: TextStyles.w700(35, Colors.white),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
