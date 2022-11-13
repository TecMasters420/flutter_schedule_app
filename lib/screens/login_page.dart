import 'package:flutter/material.dart';
import 'package:schedulemanager/models/user_model.dart';
import 'package:schedulemanager/services/auth_service.dart';
import 'package:schedulemanager/utils/responsive_util.dart';
import 'package:schedulemanager/utils/text_styles.dart';
import 'package:schedulemanager/widgets/custom_button.dart';
import 'package:schedulemanager/widgets/custom_form_field.dart';

import '../constants/constants.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final UserModel _user;

  @override
  void initState() {
    _user = UserModel();
    super.initState();
  }

  void _showSnackbar(
      final BuildContext context, final String code, final String type) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(milliseconds: 250),
        backgroundColor: type == 'error' ? Colors.red[200] : Colors.green[200],
        content: Text('Message: $code'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ResponsiveUtil resp = ResponsiveUtil.of(context);
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
                const FlutterLogo(
                  size: 150,
                ),
                SizedBox(height: resp.hp(2.5)),
                Text(
                  'Login',
                  style: TextStyles.w500(30),
                ),
                SizedBox(height: resp.hp(1)),
                Text(
                  'aliquam consectetur et tincidunt praesent enim massa pellentesque velit odio neque',
                  style: TextStyles.w200(12, Colors.grey[600]!),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: resp.hp(2.5)),
                CustomFormField(
                  labelText: 'Email',
                  hintText: 'email@gmail.com',
                  icon: Icons.alternate_email_rounded,
                  onChanged: (value) {
                    setState(() {
                      _user.email = value;
                    });
                  },
                ),
                SizedBox(height: resp.hp(2.5)),
                CustomFormField(
                  labelText: 'Password',
                  hintText: '*******',
                  icon: Icons.lock_outline_rounded,
                  onChanged: (value) {
                    setState(() {
                      _user.password = value;
                    });
                  },
                ),
                Row(
                  children: [
                    const Spacer(),
                    TextButton(
                      child: Text(
                        'Recovery password',
                        style: TextStyles.w400(12, accent),
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
                  onTap: () => AuthService().login(
                    _user.email!,
                    _user.password!,
                    () {
                      _showSnackbar(context, 'Logged!', 'Logged');
                      Navigator.pushReplacementNamed(context, 'homePage');
                    },
                    (errorCode) => _showSnackbar(context, errorCode, 'error'),
                  ),
                ),
                SizedBox(height: resp.hp(1)),
                Text(
                  'Or',
                  style: TextStyles.w200(12, Colors.grey[600]!),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: resp.hp(1)),
                CustomButton(
                  color: Colors.grey[50]!,
                  height: resp.hp(5),
                  style: TextStyles.w400(14),
                  width: resp.wp(30),
                  text: 'Google',
                  prefixWidget: Image.asset(
                    'assets/images/google.png',
                    height: resp.hp(5),
                    width: resp.wp(5),
                  ),
                  // onTap: () => AuthService()
                  //     .createUser('franciscojrdzrdz@gmail.com', 'franktest'),
                  onTap: (() =>
                      Navigator.pushReplacementNamed(context, 'homePage')),
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account yet?",
                      style: TextStyles.w400(12, grey),
                    ),
                    TextButton(
                      child: Text(
                        'Sign Up',
                        style: TextStyles.w500(12, accent),
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
