import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/config/constants.dart';

import '../../../app/utils/responsive_util.dart';
import '../../../app/utils/text_styles.dart';
import '../../../widgets/custom_alert_dialog.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_circular_progress.dart';
import '../../../widgets/custom_form_field.dart';
import '../controllers/auth_controller.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? _email;
  String? _password;

  @override
  Widget build(BuildContext context) {
    final ResponsiveUtil resp = ResponsiveUtil.of(context);
    final AuthController auth = Get.find();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: containerBg,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 50),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
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
              SizedBox(height: resp.hp(7)),
              Row(
                children: [
                  Text(
                    'Email',
                    style: TextStyles.w700(14),
                  ),
                  Text(
                    ' *',
                    style: TextStyles.w700(14, Colors.red),
                  ),
                ],
              ),
              SizedBox(height: resp.hp(1)),
              CustomFormField(
                labelText: 'Email',
                hintText: 'email@gmail.com',
                icon: Icons.alternate_email_rounded,
                onChanged: (value) {
                  setState(() {
                    _email = value;
                  });
                },
              ),
              SizedBox(height: resp.hp(1)),
              Row(
                children: [
                  Text(
                    'Password',
                    style: TextStyles.w700(14),
                  ),
                  Text(
                    ' *',
                    style: TextStyles.w700(14, Colors.red),
                  ),
                ],
              ),
              SizedBox(height: resp.hp(1)),
              CustomFormField(
                obscure: true,
                labelText: 'Password',
                hintText: '************',
                icon: Icons.lock_outline_rounded,
                onChanged: (value) {
                  setState(() {
                    _password = value;
                  });
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    child: Text(
                      'Forget password?',
                      style: TextStyles.w700(14, accent),
                    ),
                    onPressed: () {},
                  )
                ],
              ),
              Column(
                children: [
                  SizedBox(height: resp.hp(1)),
                  CustomButton(
                    color: darkAccent,
                    height: resp.hp(5),
                    style: TextStyles.w800(16, Colors.white),
                    width: resp.wp(30),
                    text: 'Login',
                    onTap: () async {
                      if (_email == null || _password == null) return;
                      await auth.logIn(_email!, _password!);
                    },
                  ),
                  SizedBox(height: resp.hp(1)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Not registered yet? ',
                        style: TextStyles.w700(14),
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                        ),
                        child: Text(
                          'Create an account',
                          style: TextStyles.w700(14, accent),
                        ),
                        onPressed: () {},
                      ),
                    ],
                  ),
                  Text(
                    'Or',
                    style: TextStyles.w500(14, lightGrey),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: resp.hp(1)),
                  CustomButton(
                    color: Colors.transparent,
                    height: resp.hp(5),
                    style: TextStyles.w500(14),
                    width: resp.wp(40),
                    text: 'Login with Google',
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
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
