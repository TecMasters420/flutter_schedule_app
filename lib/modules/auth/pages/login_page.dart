import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedulemanager/modules/auth/controllers/login_controller.dart';
import 'package:schedulemanager/routes/app_routes.dart';
import 'package:schedulemanager/widgets/custom_text_button_widget.dart';

import '../../../app/config/app_constants.dart';
import '../../../app/config/constants.dart';

import '../../../app/utils/responsive_util.dart';
import '../../../app/utils/text_styles.dart';
import '../../../widgets/custom_alert_dialog.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_circular_progress.dart';
import '../../../widgets/required_textformfield_widget.dart';
import '../controllers/auth_controller.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ResponsiveUtil resp = ResponsiveUtil.of(context);
    final AuthController auth = Get.find();
    final LoginController login = Get.find();

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: AppConstants.bodyPadding,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: CircleAvatar(
                    backgroundImage:
                        const AssetImage('assets/images/calendar.png'),
                    maxRadius: resp.wp(30),
                  ),
                ),
                SizedBox(height: resp.hp(2.5)),
                Text(
                  'Login - Alpha',
                  style: TextStyles.w800(35),
                ),
                SizedBox(height: resp.hp(0.5)),
                Text(
                  'Enter the following information so you can organize your events!',
                  style: TextStyles.w500(14, grey),
                ),
                SizedBox(height: resp.hp(3)),
                RequiredTextFormFieldWidget(
                  title: 'Email',
                  suffixIcon: Icons.alternate_email_rounded,
                  onChangeCallback: (value) {
                    login.email.value = value;
                  },
                ),
                SizedBox(height: resp.hp(1)),
                RequiredTextFormFieldWidget(
                  title: 'Password',
                  obscure: true,
                  suffixIcon: Icons.lock_outline_rounded,
                  onChangeCallback: (value) {
                    login.password.value = value;
                  },
                ),
                SizedBox(height: resp.hp(1)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomTextButtonWidget(
                      title: 'Forget password?',
                      onTap: () {},
                    )
                  ],
                ),
                SizedBox(height: resp.hp(1)),
                Column(
                  children: [
                    SizedBox(height: resp.hp(1)),
                    CustomButton(
                      color: darkAccent,
                      height: resp.hp(5),
                      style: TextStyles.w800(16, Colors.white),
                      width: resp.wp(30),
                      text: login.email.value.isNotEmpty ? 'Login' : 'Login',
                      onTap: () async {
                        final email = login.email.value;
                        final password = login.password.value;
                        if (email.isEmpty || password.isEmpty) {
                          return;
                        }
                        CustomAlertDialog(
                          resp: resp,
                          dismissible: false,
                          context: context,
                          onAcceptCallback: () {},
                          showButtons: false,
                          title: 'Logging in...',
                          customBody: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const CustomCircularProgress(
                                color: accent,
                              ),
                              SizedBox(height: resp.hp(2)),
                              Text(
                                'Wait a bit while it logs in',
                                style: TextStyles.w500(16),
                              )
                            ],
                          ),
                        );
                        await auth.logIn(
                          login.email.value,
                          login.password.value,
                        );
                      },
                    ),
                    SizedBox(height: resp.hp(1)),
                    Text(
                      'Or',
                      style: TextStyles.w500(14, grey),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: resp.hp(1)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomButton(
                          color: containerBg,
                          height: resp.hp(5),
                          style: TextStyles.w700(14),
                          width: resp.wp(30),
                          text: 'Google',
                          prefixWidget: Image.asset(
                            'assets/images/google.png',
                            height: resp.hp(5),
                            width: resp.wp(5),
                          ),
                          onTap: () async {
                            CustomAlertDialog(
                              resp: resp,
                              dismissible: false,
                              context: context,
                              onAcceptCallback: () {},
                              showButtons: false,
                              title: 'Logging in...',
                              customBody: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const CustomCircularProgress(
                                    color: accent,
                                  ),
                                  SizedBox(height: resp.hp(2)),
                                  Text(
                                    'Wait a bit while it logs in',
                                    style: TextStyles.w500(16),
                                  )
                                ],
                              ),
                            );
                            await auth.googleLogin();
                          },
                        ),
                        SizedBox(width: resp.wp(5)),
                        CustomButton(
                          color: accent,
                          height: resp.hp(5),
                          style: TextStyles.w700(14, Colors.white),
                          width: resp.wp(30),
                          text: 'Facebook',
                          hideShadows: true,
                          prefixWidget: Image.asset(
                            'assets/images/facebook.png',
                            height: resp.hp(5),
                            width: resp.wp(5),
                          ),
                          onTap: () async {
                            CustomAlertDialog(
                              resp: resp,
                              dismissible: false,
                              context: context,
                              onAcceptCallback: () {},
                              showButtons: false,
                              title: 'Logging in...',
                              customBody: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const CustomCircularProgress(
                                    color: accent,
                                  ),
                                  SizedBox(height: resp.hp(2)),
                                  Text(
                                    'Wait a bit while it logs in',
                                    style: TextStyles.w500(16),
                                  )
                                ],
                              ),
                            );
                            await auth.googleLogin();
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: resp.hp(2.5)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account? ",
                          style: TextStyles.w500(14, grey),
                        ),
                        CustomTextButtonWidget(
                          title: 'Create an account',
                          onTap: () => Get.toNamed(AppRoutes.register),
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
