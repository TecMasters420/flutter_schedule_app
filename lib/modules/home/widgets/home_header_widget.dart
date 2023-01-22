import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:schedulemanager/widgets/responsive_container_widget.dart';
import '../../../app/config/constants.dart';
import '../../../app/utils/responsive_util.dart';
import '../../../routes/app_routes.dart';
import '../../../widgets/custom_text_button_widget.dart';
import '../../../widgets/user_profile_picture.dart';

import '../../../app/utils/text_styles.dart';

class HomeHeaderWidget extends StatelessWidget {
  final String userImage;
  final String name;
  const HomeHeaderWidget({
    super.key,
    required this.userImage,
    required this.name,
  });

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
                  width: resp.hp(4),
                  redirectToProfile: true,
                  userImage: userImage,
                ),
                SizedBox(width: resp.wp(2)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: TextStyles.w700(14),
                    ),
                    CustomTextButtonWidget(
                      title: 'View profile',
                      customFontSize: 12,
                      onTap: () => Get.toNamed(AppRoutes.profile),
                    ),
                  ],
                )
              ],
            ),
            const Spacer(),
            GestureDetector(
              onTap: () => Get.toNamed(AppRoutes.notifications),
              child: Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.topLeft,
                children: [
                  const Icon(Icons.notifications_none_rounded, size: 30),
                  Positioned(
                    top: -3,
                    left: 12,
                    child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 3, vertical: 3),
                      decoration: const BoxDecoration(
                        color: red,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        '10+',
                        style: TextStyles.w700(10, Colors.white),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: resp.hp(2.5)),
        ResponsiveContainerWidget(
          customColor: accent,
          padding: const EdgeInsets.symmetric(vertical: 30),
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
