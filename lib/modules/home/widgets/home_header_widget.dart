import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import '../../../app/config/constants.dart';
import '../../../app/utils/responsive_util.dart';
import '../../../widgets/custom_text_button_widget.dart';
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
                    CustomTextButtonWidget(
                      title: 'View profile',
                      customFontSize: 12,
                      onTap: () => Get.toNamed('userProfilePage'),
                    ),
                  ],
                )
              ],
            ),
            const Spacer(),
            IconButton(
              style: IconButton.styleFrom(
                padding: EdgeInsets.zero,
                alignment: Alignment.topCenter,
              ),
              icon: const Icon(Icons.notifications_none_rounded, size: 30),
              onPressed: () => Get.toNamed('/notificationsPage'),
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
