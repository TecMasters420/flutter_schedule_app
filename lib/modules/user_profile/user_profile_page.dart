import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:schedulemanager/widgets/loading_widget.dart';
import '../../app/config/app_constants.dart';
import '../../app/config/constants.dart';
import '../../app/utils/responsive_util.dart';
import '../../app/utils/text_styles.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_header_widget.dart';
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
          padding: AppConstants.bodyPadding,
          child: Obx(() {
            return controller.currentUser == null || controller.isLoading.value
                ? SizedBox(
                    height: resp.height - 70,
                    child: const LoadingWidget(),
                  )
                : Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomHeaderWidget(
                        title: '${controller.currentUser!.data.name} Profile',
                      ),
                      SizedBox(height: resp.hp(2.5)),
                      Stack(
                        clipBehavior: Clip.none,
                        alignment: Alignment.center,
                        children: [
                          Container(
                            height: resp.hp(20),
                            width: resp.width,
                            decoration: BoxDecoration(
                              color: containerBg,
                              boxShadow: shadows,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Image.asset(
                              'assets/images/home_logo.png',
                              fit: BoxFit.fill,
                            ),
                          ),
                          Positioned(
                            top: resp.hp(5),
                            child: UserProfilePicture(
                              height: resp.hp(20),
                              width: resp.wp(42.5),
                              userImage:
                                  controller.currentUser!.data.imageUrl ?? '',
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: resp.hp(8)),
                      Text(
                        'Information',
                        style: TextStyles.w700(20),
                      ),
                      SizedBox(height: resp.hp(2.5)),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 15,
                        ),
                        alignment: Alignment.topLeft,
                        decoration: BoxDecoration(
                          color: containerBg,
                          boxShadow: shadows,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Name',
                              style: TextStyles.w700(16),
                            ),
                            Text(
                              controller.currentUser!.data.name,
                              style: TextStyles.w400(14),
                            ),
                            SizedBox(height: resp.hp(2)),
                            Text(
                              'Last name',
                              style: TextStyles.w700(16),
                            ),
                            Text(
                              controller.currentUser!.data.lastName,
                              style: TextStyles.w400(14),
                            ),
                            SizedBox(height: resp.hp(2)),
                            Text(
                              'Email',
                              style: TextStyles.w700(16),
                            ),
                            Text(
                              controller.currentUser!.email,
                              style: TextStyles.w400(14),
                            ),
                            SizedBox(height: resp.hp(2)),
                            Text(
                              'Phone number',
                              style: TextStyles.w700(16),
                            ),
                            Text(
                              controller.currentUser!.data.phone ?? 'No Number',
                              style: TextStyles.w400(14),
                            ),
                            SizedBox(height: resp.hp(2)),
                            Text(
                              'Registered at',
                              style: TextStyles.w700(16),
                            ),
                            Text(
                              DateFormat(DateFormat.YEAR_MONTH_DAY, 'en_US')
                                  .format(
                                DateTime.now().toUtc(),
                              ),
                              style: TextStyles.w500(14),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: resp.hp(3)),
                      Text(
                        'Groups',
                        style: TextStyles.w700(20),
                      ),
                      SizedBox(height: resp.hp(2.5)),
                      SizedBox(height: resp.hp(3)),
                      Text(
                        'App Settings',
                        style: TextStyles.w700(20),
                      ),
                      SizedBox(height: resp.hp(2.5)),
                      SizedBox(height: resp.hp(3)),
                      Text(
                        'More',
                        style: TextStyles.w700(20),
                      ),
                      SizedBox(height: resp.hp(2.5)),
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
                            onTap: () async {
                              await controller.signOut();
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
