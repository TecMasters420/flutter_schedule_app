import 'package:flutter/material.dart';
import 'package:schedule_app/constants/constants.dart';
import 'package:schedule_app/utils/responsive_util.dart';
import 'package:schedule_app/utils/text_styles.dart';
import 'package:schedule_app/widgets/custom_button.dart';
import 'package:schedule_app/widgets/custom_form_field.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

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
                  'Hello Again!',
                  style: TextStyles.w500(20),
                ),
                SizedBox(height: resp.hp(1)),
                Text(
                  'aliquam consectetur et tincidunt praesent enim massa pellentesque velit odio neque',
                  style: TextStyles.w200(12, Colors.grey[600]!),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: resp.hp(2.5)),
                const CustomFormField(
                  labelText: 'Email',
                  hintText: 'email@gmail.com',
                  icon: Icons.alternate_email_rounded,
                ),
                SizedBox(height: resp.hp(5)),
                const CustomFormField(
                  labelText: 'Password',
                  hintText: '*******',
                  icon: Icons.lock_outline_rounded,
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
                  text: 'Login',
                  onTap: (() =>
                      Navigator.pushReplacementNamed(context, 'homePage')),
                ),
                const Spacer(),
                Row(
                  children: [
                    Text(
                      "Don't have an account yet? ",
                      style: TextStyles.w400(12, grey),
                    ),
                    TextButton(
                      child: Text(
                        'Sign Up',
                        style: TextStyles.w500(12, accent),
                      ),
                      onPressed: () {},
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
