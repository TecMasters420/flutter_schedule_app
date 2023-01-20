import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:schedulemanager/app/config/app_constants.dart';
import 'package:schedulemanager/app/utils/register_util.dart';
import 'package:schedulemanager/modules/auth/controllers/register_controller.dart';
import 'package:schedulemanager/modules/auth/widgets/password_validator_helper_widget.dart';
import 'package:schedulemanager/routes/app_routes.dart';
import 'package:schedulemanager/widgets/required_textformfield_widget.dart';

import '../../../app/config/constants.dart';

import '../../../app/utils/responsive_util.dart';
import '../../../app/utils/text_styles.dart';
import '../../../widgets/custom_alert_dialog.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_circular_progress.dart';
import '../../../widgets/custom_form_field.dart';
import '../controllers/auth_controller.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ResponsiveUtil resp = ResponsiveUtil.of(context);
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
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Register',
                  style: TextStyles.w800(35),
                ),
                SizedBox(height: resp.hp(2)),
                Text(
                  'Account data',
                  style: TextStyles.w700(20),
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
                  style: TextStyles.w700(20),
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
                          register.user.value.name = value;
                        },
                      ),
                    ),
                    SizedBox(width: resp.wp(5)),
                    Expanded(
                      child: RequiredTextFormFieldWidget(
                        title: 'Lastname',
                        suffixIcon: Icons.text_snippet_outlined,
                        onChangeCallback: (value) {
                          register.user.value.lastName = value;
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: resp.hp(1)),
                Text(
                  'Phone',
                  style: TextStyles.w700(14),
                ),
                SizedBox(height: resp.hp(1)),
                Row(
                  children: [
                    Expanded(
                      child: CustomFormField(
                        icon: Icons.phone_enabled_outlined,
                        onChanged: (value) {
                          register.user.value.phone = value;
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
                    CustomButton(
                      color: lightBlue,
                      height: resp.hp(5),
                      style: TextStyles.w800(16, darkAccent),
                      hideShadows: true,
                      width: resp.wp(30),
                      text: 'Cancel',
                      onTap: () => Get.back(),
                    ),
                    SizedBox(width: resp.wp(2.5)),
                    CustomButton(
                      color: darkAccent,
                      height: resp.hp(5),
                      style: TextStyles.w800(16, Colors.white),
                      width: resp.wp(30),
                      hideShadows: true,
                      text: 'Register',
                      onTap: () async {
                        final user = register.user.value;
                        final pass = register.pass.value;
                        if (!RegisterUtil.isValidToRegister(user, pass)) {
                          CustomAlertDialog(
                            resp: resp,
                            dismissible: true,
                            context: context,
                            onAcceptCallback: () {},
                            showButtons: false,
                            title: 'Invalid data',
                            customBody: Text(
                              'Please check the data you have entered.',
                              style: TextStyles.w500(16),
                            ),
                          );
                          return;
                        }
                        CustomAlertDialog(
                          resp: resp,
                          dismissible: false,
                          context: context,
                          onAcceptCallback: () {},
                          showButtons: false,
                          title: 'Registering...',
                          customBody: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const CustomCircularProgress(
                                color: accent,
                              ),
                              SizedBox(height: resp.hp(2)),
                              Text(
                                'Please wait a while while registering',
                                style: TextStyles.w500(16),
                              )
                            ],
                          ),
                        );
                        final registered = await auth.register(user, pass);
                        if (!registered) {
                          Get.back(closeOverlays: true);
                          CustomAlertDialog(
                            resp: resp,
                            dismissible: true,
                            context: context,
                            onAcceptCallback: () {},
                            showButtons: false,
                            customBody: const SizedBox(),
                            title: 'Failed to register user',
                          );
                          return;
                        }
                        Get.offAllNamed(AppRoutes.login);
                        CustomAlertDialog(
                          resp: resp,
                          dismissible: true,
                          context: context,
                          onAcceptCallback: () {},
                          showButtons: false,
                          customBody: const SizedBox(),
                          title: 'User has registered!',
                        );
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
