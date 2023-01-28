import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedulemanager/app/utils/alert_dialogs_util.dart';
import 'package:schedulemanager/routes/app_routes.dart';
import 'package:schedulemanager/widgets/custom_text_button_widget.dart';
import 'package:schedulemanager/widgets/responsive_container_widget.dart';

import '../../../app/config/app_constants.dart';
import '../../../app/config/constants.dart';

import '../../../app/utils/responsive_util.dart';
import '../../../app/utils/text_styles.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/required_textformfield_widget.dart';
import '../controllers/auth_controller.dart';

// ignore: must_be_immutable
class LoginPage extends StatelessWidget {
  String _email = '';
  String _password = '';
  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ResponsiveUtil resp = ResponsiveUtil.of(context);
    final AuthController auth = Get.find();

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        clipBehavior: Clip.none,
        physics: const BouncingScrollPhysics(),
        child: SizedBox(
          height: resp.height,
          child: Padding(
            padding: AppConstants.bodyPadding,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Center(
                //   child: CircleAvatar(
                //     backgroundImage: const AssetImage(
                //       'assets/images/calendar.png',
                //     ),
                //     maxRadius: resp.wp(30),
                //   ),
                // ),
                // SizedBox(height: resp.hp(2.5)),
                ResponsiveContainerWidget(
                  padding: EdgeInsets.symmetric(
                    vertical: resp.hp(2.5),
                    horizontal: resp.wp(7),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                          _email = value;
                        },
                      ),
                      SizedBox(height: resp.hp(1)),
                      RequiredTextFormFieldWidget(
                        title: 'Password',
                        obscure: true,
                        suffixIcon: Icons.lock_outline_rounded,
                        onChangeCallback: (value) {
                          _password = value;
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
                            color: blueAccent,
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            style: TextStyles.w800(16, Colors.white),
                            text: 'Login',
                            expand: true,
                            onTap: () async {
                              if (_email.isEmpty || _password.isEmpty) {
                                AlertDialogsUtil.error(
                                  customBodyMessage: [
                                    'Enter all the information requested'
                                  ],
                                );
                                return;
                              }
                              AlertDialogsUtil.loading(
                                customBodyMessage: [
                                  'Your data is being validated'
                                ],
                              );
                              await auth.logIn(_email, _password);
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
                              Expanded(
                                child: CustomButton(
                                  color: containerBg,
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 15),
                                  style: TextStyles.w700(14),
                                  text: 'Google',
                                  center: true,
                                  prefixWidget: Image.asset(
                                    'assets/images/google.png',
                                    height: 14,
                                    width: 14,
                                  ),
                                  onTap: () async {
                                    AlertDialogsUtil.loading(
                                      customBodyMessage: [
                                        'Your data is being validated'
                                      ],
                                    );
                                    await auth.googleLogin();
                                  },
                                ),
                              ),
                              SizedBox(width: resp.wp(5)),
                              Expanded(
                                child: CustomButton(
                                  color: blueAccent,
                                  style: TextStyles.w700(14, Colors.white),
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 15),
                                  text: 'Facebook',
                                  center: true,
                                  prefixWidget: Image.asset(
                                    'assets/images/facebook.png',
                                    height: 14,
                                    width: 14,
                                  ),
                                  onTap: () async {
                                    AlertDialogsUtil.warning(
                                      customBodyMessage: ['Not yet available'],
                                    );
                                  },
                                ),
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
                              Expanded(
                                child: CustomTextButtonWidget(
                                  title: 'Create an account',
                                  onTap: () => Get.toNamed(AppRoutes.register),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ],
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
