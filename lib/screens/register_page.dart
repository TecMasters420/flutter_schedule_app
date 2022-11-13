import 'package:flutter/material.dart';
import 'package:schedulemanager/utils/responsive_util.dart';
import 'package:schedulemanager/utils/text_styles.dart';
import 'package:schedulemanager/widgets/custom_button.dart';
import 'package:schedulemanager/widgets/custom_form_field.dart';

import '../constants/constants.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

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
                const FlutterLogo(
                  size: 150,
                ),
                SizedBox(height: resp.hp(2.5)),
                Text(
                  'Register page!',
                  style: TextStyles.w500(20),
                ),
                SizedBox(height: resp.hp(1)),
                Text(
                  'Enter the following information to register',
                  style: TextStyles.w200(12, Colors.grey[600]!),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: resp.hp(2.5)),
                const CustomFormField(
                  labelText: 'Name',
                  hintText: 'Francisco Rodríguez',
                  icon: Icons.person_outline_rounded,
                ),
                SizedBox(height: resp.hp(2.5)),
                const CustomFormField(
                  labelText: 'Email',
                  hintText: 'email@gmail.com',
                  icon: Icons.alternate_email_rounded,
                ),
                SizedBox(height: resp.hp(2.5)),
                const CustomFormField(
                  labelText: 'Password',
                  hintText: '*******',
                  icon: Icons.lock_outline_rounded,
                ),
                SizedBox(height: resp.hp(2.5)),
                CustomButton(
                  color: tempAccent,
                  height: resp.hp(5),
                  style: TextStyles.w800(16, Colors.white),
                  width: resp.wp(30),
                  text: 'Register',
                  onTap: (() =>
                      Navigator.pushReplacementNamed(context, 'loginPage')),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
