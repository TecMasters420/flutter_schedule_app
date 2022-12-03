import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../app/config/constants.dart';
import '../../../data/models/user_model.dart';
import '../../../app/services/auth_service.dart';
import '../../../app/utils/responsive_util.dart';
import '../../../app/utils/text_styles.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_form_field.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
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
        duration: const Duration(milliseconds: 1000),
        backgroundColor: type == 'error' ? Colors.red[200] : Colors.green[200],
        content: Text('Message: $code'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ResponsiveUtil resp = ResponsiveUtil.of(context);
    final AuthService auth = Provider.of<AuthService>(context);
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
                SizedBox(height: resp.hp(2.5)),
                CustomButton(
                  color: tempAccent,
                  height: resp.hp(5),
                  style: TextStyles.w800(16, Colors.white),
                  width: resp.wp(30),
                  text: 'Register',
                  onTap: () async => await auth.createUser(
                    _user.email!,
                    _user.password!,
                    () {
                      _showSnackbar(context, 'Registered!', 'Registered');
                      Navigator.pushReplacementNamed(context, 'loginPage');
                    },
                    (errorCode) => _showSnackbar(context, errorCode, 'error'),
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
