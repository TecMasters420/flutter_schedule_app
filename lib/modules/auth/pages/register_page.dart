import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/config/constants.dart';

import '../../../app/utils/responsive_util.dart';
import '../../../app/utils/text_styles.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_form_field.dart';
import '../controllers/auth_controller.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late String _email;
  late String _password;

  @override
  void initState() {
    _email = '';
    _password = '';
    super.initState();
  }

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
                Image.asset('assets/images/home_logo.png'),
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
                CustomFormField(
                  labelText: 'Name',
                  hintText: 'Francisco Rodríguez',
                  icon: Icons.person_outline_rounded,
                  onChanged: (value) {},
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
                  labelText: 'Password',
                  hintText: '*******',
                  icon: Icons.lock_outline_rounded,
                  onChanged: (value) {
                    setState(() {
                      _password = value;
                    });
                  },
                ),
                SizedBox(height: resp.hp(2.5)),
                CustomButton(
                  color: tempAccent,
                  height: resp.hp(5),
                  style: TextStyles.w800(16, Colors.white),
                  width: resp.wp(30),
                  text: 'Register',
                  onTap: () async {},
                  // onTap: () async =>
                  //     await auth.createUser(_user.email!, _user.password!),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
