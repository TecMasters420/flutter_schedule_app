import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedulemanager/app/config/app_constants.dart';
import 'package:schedulemanager/app/utils/alert_dialogs_util.dart';
import 'package:schedulemanager/app/utils/register_util.dart';
import 'package:schedulemanager/modules/auth/controllers/register_controller.dart';
import 'package:schedulemanager/modules/auth/widgets/password_validator_helper_widget.dart';
import 'package:schedulemanager/widgets/custom_text_button_widget.dart';
import 'package:schedulemanager/widgets/required_textformfield_widget.dart';
import 'package:schedulemanager/widgets/responsive_container_widget.dart';

import '../../../app/config/constants.dart';

import '../../../app/utils/responsive_util.dart';
import '../../../app/utils/text_styles.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_form_field.dart';
import '../controllers/auth_controller.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ResponsiveUtil resp = ResponsiveUtil.of(context);
    final styles = TextStyles.of(context);
    final AuthController auth = Get.find();
    final RegisterController register = Get.find();

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: SizedBox(
          height: resp.height,
          child: Padding(
            padding: AppConstants.bodyPadding,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ResponsiveContainerWidget(
                  padding: EdgeInsets.symmetric(
                    vertical: resp.hp(2.5),
                    horizontal: resp.wp(7),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Register',
                        style: styles.w800(35),
                      ),
                      SizedBox(height: resp.hp(2)),
                      Text(
                        'Account data',
                        style: styles.w700(20),
                      ),
                      SizedBox(height: resp.hp(2.5)),
                      RequiredTextFormFieldWidget(
                        title: 'Email',
                        suffixIcon: Icons.alternate_email_rounded,
                        onChangeCallback: (value) {
                          register.user.value.email = value;
                        },
                      ),
                      SizedBox(height: resp.hp(1)),
                      RequiredTextFormFieldWidget(
                        title: 'Password',
                        obscure: true,
                        suffixIcon: Icons.lock_outline_rounded,
                        onChangeCallback: (value) {
                          register.pass.value = value;
                        },
                      ),
                      SizedBox(height: resp.hp(1)),
                      Obx(
                        () => PasswordValidatorHelperWidget(
                          pass: register.pass.value,
                        ),
                      ),
                      SizedBox(height: resp.hp(2.5)),
                      Text(
                        'User information',
                        style: styles.w700(20),
                      ),
                      SizedBox(height: resp.hp(2.5)),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                            child: RequiredTextFormFieldWidget(
                              title: 'Name',
                              suffixIcon: Icons.face,
                              onChangeCallback: (value) {
                                register.user.value.data.name = value;
                              },
                            ),
                          ),
                          SizedBox(width: resp.wp(5)),
                          Expanded(
                            child: RequiredTextFormFieldWidget(
                              title: 'Lastname',
                              suffixIcon: Icons.text_snippet_outlined,
                              onChangeCallback: (value) {
                                register.user.value.data.lastName = value;
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: resp.hp(1)),
                      Text(
                        'Phone',
                        style: styles.w700(14),
                      ),
                      SizedBox(height: resp.hp(1)),
                      Row(
                        children: [
                          Expanded(
                            child: CustomFormField(
                              icon: Icons.phone_enabled_outlined,
                              onChanged: (value) {
                                register.user.value.data.phone = value;
                              },
                            ),
                          ),
                          const Spacer(),
                        ],
                      ),
                      SizedBox(height: resp.hp(5)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          CustomTextButtonWidget(
                            title: 'Cancel',
                            onTap: Get.back,
                            customFontSize: 16,
                          ),
                          SizedBox(width: resp.wp(5)),
                          CustomButton(
                            color: blueAccent,
                            style: styles.w800(16, Colors.white),
                            hideShadows: true,
                            text: 'Register',
                            onTap: () async {
                              final user = register.user.value;
                              final pass = register.pass.value;
                              if (!RegisterUtil.isValidToRegister(user, pass)) {
                                AlertDialogsUtil.errorModal(
                                  context: context,
                                  title: 'Login failed',
                                  subtitle:
                                      'Enter all the information requested',
                                );
                                return;
                              }
                              AlertDialogsUtil.loadingModal(
                                context: context,
                                subtitle: 'Your data is being validated',
                              );
                              final registered =
                                  await auth.register(user, pass);
                              if (!registered) {
                                return;
                              }
                              Get.back(closeOverlays: true);
                              AlertDialogsUtil.completedModal(
                                context: context,
                                title: 'Completed!',
                                subtitle: 'User has registered',
                              );
                            },
                          ),
                        ],
                      )
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
