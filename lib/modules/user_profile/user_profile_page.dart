import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:schedulemanager/widgets/loading_widget.dart';
import 'package:schedulemanager/widgets/responsive_container_widget.dart';
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
    final styles = TextStyles.of(context);

    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: AppConstants.bodyPadding,
          child: Obx(
            () {
              return controller.currentUser == null ||
                      controller.isLoading.value
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
                        SizedBox(
                          width: resp.width,
                          height: resp.hp(20),
                          child: Stack(
                            clipBehavior: Clip.none,
                            alignment: Alignment.center,
                            children: [
                              ResponsiveContainerWidget(
                                padding: EdgeInsets.zero,
                                child: Center(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(30),
                                    child: Image.asset(
                                      'assets/images/home_logo.png',
                                      fit: BoxFit.fill,
                                      width: resp.width,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                top: resp.hp(5),
                                child: UserProfilePicture(
                                  height: resp.hp(20),
                                  width: resp.wp(42.5),
                                  userImage:
                                      controller.currentUser!.data.imageUrl ??
                                          '',
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: resp.hp(8)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: CustomButton(
                                text: 'Save',
                                color: blueAccent,
                                center: true,
                                expand: true,
                                onTap: () {
                                  Get.back();
                                },
                                style: styles.w800(16, Colors.white),
                              ),
                            ),
                            SizedBox(width: resp.wp(2.5)),
                            Expanded(
                              child: CustomButton(
                                text: 'Log out',
                                color: red,
                                center: true,
                                expand: true,
                                onTap: () async {
                                  await controller.signOut();
                                },
                                style: styles.w800(16, Colors.white),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: resp.hp(4)),
                        Text(
                          'Information',
                          style: styles.w700(20),
                        ),
                        SizedBox(height: resp.hp(2.5)),
                        ResponsiveContainerWidget(
                          padding: const EdgeInsets.symmetric(
                            vertical: AppConstants.bPadding,
                            horizontal: 20,
                          ),
                          child: Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Name',
                                    style: styles.w700(16),
                                  ),
                                  Text(
                                    controller.currentUser!.data.name,
                                    style: styles.w400(14),
                                  ),
                                  SizedBox(height: resp.hp(2)),
                                  Text(
                                    'Last name',
                                    style: styles.w700(16),
                                  ),
                                  Text(
                                    controller.currentUser!.data.lastName,
                                    style: styles.w400(14),
                                  ),
                                  SizedBox(height: resp.hp(2)),
                                  Text(
                                    'Email',
                                    style: styles.w700(16),
                                  ),
                                  Text(
                                    controller.currentUser!.email,
                                    style: styles.w400(14),
                                  ),
                                  SizedBox(height: resp.hp(2)),
                                  Text(
                                    'Phone number',
                                    style: styles.w700(16),
                                  ),
                                  Text(
                                    controller.currentUser!.data.phone ??
                                        'No Number',
                                    style: styles.w400(14),
                                  ),
                                  SizedBox(height: resp.hp(2)),
                                  Text(
                                    'Registered at',
                                    style: styles.w700(16),
                                  ),
                                  Text(
                                    DateFormat(
                                            DateFormat.YEAR_MONTH_DAY, 'en_US')
                                        .format(
                                      DateTime.now().toUtc(),
                                    ),
                                    style: styles.w500(14),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: resp.hp(3)),
                        Text(
                          'Groups',
                          style: styles.w700(20),
                        ),
                        SizedBox(height: resp.hp(2.5)),
                        SizedBox(height: resp.hp(3)),
                        Text(
                          'App Settings',
                          style: styles.w700(20),
                        ),
                        SizedBox(height: resp.hp(2.5)),
                        SizedBox(height: resp.hp(3)),
                        Text(
                          'More',
                          style: styles.w700(20),
                        ),
                        SizedBox(height: resp.hp(2.5)),
                      ],
                    );
            },
          ),
        ),
      ),
    );
  }
}
