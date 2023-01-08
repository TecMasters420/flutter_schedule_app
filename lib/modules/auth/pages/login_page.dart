import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/config/constants.dart';

import '../../../app/utils/responsive_util.dart';
import '../../../app/utils/text_styles.dart';
import '../../../widgets/custom_button.dart';
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
      backgroundColor: backgroundColor,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: SizedBox(
          height: resp.height,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 50,
              vertical: 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                Image.asset('assets/images/home_logo.png'),
                SizedBox(height: resp.hp(2.5)),
                Text(
                  'Hello, Welcome!',
                  style: TextStyles.w500(resp.sp40),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: resp.hp(1)),
                Text(
                  'Enter the following fields that are requested to log in.',
                  style: TextStyles.w400(16, Colors.grey[600]!),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: resp.hp(2.5)),
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
                SizedBox(height: resp.hp(2.5)),
                CustomFormField(
                  obscure: true,
                  labelText: 'Password',
                  hintText: '*******',
                  icon: Icons.lock_outline_rounded,
                  onChanged: (value) {
                    setState(() {
                      _password = value;
                    });
                  },
                ),
                Row(
                  children: [
                    const Spacer(),
                    TextButton(
                      child: Text(
                        'Recovery password',
                        style: TextStyles.w400(16, accent),
                      ),
                      onPressed: () {},
                    )
                  ],
                ),
                SizedBox(height: resp.hp(2.5)),
                CustomButton(
                  color: tempAccent,
                  height: resp.hp(5),
                  style: TextStyles.w800(16, Colors.white),
                  width: resp.wp(30),
                  text: 'Login',
                  onTap: () async {
                    if (_email == null || _password == null) return;
                    await auth.logIn(_email!, _password!);
                  },
                ),
                // SizedBox(height: resp.hp(1)),
                // Text(
                //   'Or',
                //   style: TextStyles.w200(16, Colors.grey[600]!),
                //   textAlign: TextAlign.center,
                // ),
                // SizedBox(height: resp.hp(1)),
                // CustomButton(
                //   color: Colors.grey[50]!,
                //   height: resp.hp(5),
                //   style: TextStyles.w400(16),
                //   width: resp.wp(30),
                //   text: 'Google',
                //   prefixWidget: Image.asset(
                //     'assets/images/google.png',
                //     height: resp.hp(5),
                //     width: resp.wp(5),
                //   ),
                //   onTap: () async {
                //     CustomAlertDialog(
                //       resp: resp,
                //       dismissible: false,
                //       context: context,
                //       onAcceptCallback: () {},
                //       showButtons: false,
                //       title: 'Logging in...',
                //       customBody: Column(
                //         mainAxisSize: MainAxisSize.min,
                //         children: [
                //           const CustomCircularProgress(color: accent),
                //           SizedBox(height: resp.hp(2)),
                //           Text('Wait a bit while it logs in',
                //               style: TextStyles.w500(16))
                //         ],
                //       ),
                //     );
                //     // await auth.googleLogin();
                //   },
                // ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account yet?",
                      style: TextStyles.w400(16, grey),
                    ),
                    TextButton(
                      child: Text(
                        'Sign Up',
                        style: TextStyles.w500(16, accent),
                      ),
                      onPressed: () =>
                          Navigator.pushNamed(context, 'registerPage'),
                    )
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
