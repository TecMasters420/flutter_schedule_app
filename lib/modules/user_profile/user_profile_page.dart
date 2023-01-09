import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
// import '../../app/utils/responsive_util.dart';
import '../../app/config/constants.dart';
import '../../app/utils/responsive_util.dart';
import '../../app/utils/text_styles.dart';
import '../../widgets/custom_back_button.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/user_profile_picture.dart';
import '../auth/controllers/auth_controller.dart';

class UserProfilePage extends GetWidget<AuthController> {
  const UserProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final ResponsiveUtil resp = ResponsiveUtil.of(context);

    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.only(
            left: 32,
            right: 32,
            top: 50,
            bottom: 20,
          ),
          child: Obx(() {
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomBackButton(),
                SizedBox(height: resp.hp(2.5)),
                Center(
                  child: Text(
                    '${controller.currentUser!.name.toUpperCase()} Profile.',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyles.w700(35),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: resp.hp(3)),
                Center(
                  child: UserProfilePicture(
                    height: resp.hp(20),
                    width: resp.wp(42.5),
                    userImage: controller.currentUser!.imageUrl ?? '',
                  ),
                ),
                SizedBox(height: resp.hp(3)),
                Container(
                  alignment: Alignment.topLeft,
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  decoration: BoxDecoration(
                    color: containerBg,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Information:',
                        style: TextStyles.w700(25),
                      ),
                      SizedBox(height: resp.hp(2)),
                      Text(
                        'Name:',
                        style: TextStyles.w700(16),
                      ),
                      Text(
                        controller.currentUser!.name,
                        style: TextStyles.w400(14),
                      ),
                      SizedBox(height: resp.hp(2)),
                      Text(
                        'Last name:',
                        style: TextStyles.w700(16),
                      ),
                      Text(
                        controller.currentUser!.lastName,
                        style: TextStyles.w400(14),
                      ),
                      SizedBox(height: resp.hp(2)),
                      Text(
                        'Email:',
                        style: TextStyles.w700(16),
                      ),
                      Text(
                        controller.currentUser!.email,
                        style: TextStyles.w400(14),
                      ),
                      SizedBox(height: resp.hp(2)),
                      Text(
                        'Phone number:',
                        style: TextStyles.w700(16),
                      ),
                      Text(
                        controller.currentUser!.phone ?? 'No Number',
                        style: TextStyles.w400(14),
                      ),
                      SizedBox(height: resp.hp(2)),
                      Text(
                        'Registered at:',
                        style: TextStyles.w700(16),
                      ),
                      Text(
                        DateFormat(DateFormat.YEAR_MONTH_DAY, 'en_US').format(
                          DateTime.now().toUtc(),
                        ),
                        style: TextStyles.w500(14),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: resp.hp(3)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomButton(
                      text: 'Save',
                      color: accent,
                      height: resp.hp(5),
                      width: resp.wp(25),
                      onTap: () {
                        Get.back();
                      },
                      style: TextStyles.w500(16, Colors.white),
                    ),
                    SizedBox(width: resp.wp(2.5)),
                    CustomButton(
                      text: 'Log out',
                      color: red,
                      height: resp.hp(5),
                      width: resp.wp(25),
                      onTap: () {
                        Get.back();
                      },
                      style: TextStyles.w500(16, Colors.white),
                    ),
                  ],
                )
              ],
            );
          }),
        ),
      ),
    );
  }
}
