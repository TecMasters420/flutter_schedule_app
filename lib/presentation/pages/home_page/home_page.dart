import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedulemanager/presentation/controllers/auth_controller.dart';
import 'package:schedulemanager/presentation/controllers/reminders_controller.dart';

import '../../../app/utils/responsive_util.dart';

import '../../../app/utils/text_styles.dart';
import '../../widgets/user_profile_picture.dart';
import 'widgets/widgets.dart';

class HomePage extends GetWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final ResponsiveUtil resp = ResponsiveUtil.of(context);
    final RemindersController reminderService = Get.put(RemindersController());
    final AuthController auth = Get.find();

    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.only(
                left: 32,
                right: 32,
                top: 50,
                bottom: 80,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: resp.hp(5)),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Welcome!',
                          style: TextStyles.w500(resp.sp20),
                        ),
                      ),
                      UserProfilePicture(
                        height: resp.hp(5),
                        width: resp.wp(10),
                        userImage: auth.userInformation.value!.imageURL ?? '',
                      )
                    ],
                  ),
                  SizedBox(height: resp.hp(2.5)),
                  Text(
                    'My daily activities',
                    style: TextStyles.w700(resp.sp30),
                  ),
                  SizedBox(height: resp.hp(2)),
                  SizedBox(
                    height: resp.hp(28),
                    width: resp.width,
                    child: const HomeActivitiesShow(),
                  ),
                  SizedBox(height: resp.hp(5)),
                  Obx(
                    () => ActivitiesTypes(
                      initialTabIndex: 1,
                      remindersPerType: {
                        'Expired': reminderService.expiredReminders,
                        'Current': reminderService.notExpiredReminders,
                        'Completed': reminderService.expiredReminders,
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
