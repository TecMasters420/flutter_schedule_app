import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../utils/responsive_util.dart';
import '../../widgets/custom_button.dart';

import '../../constants/constants.dart';
import '../../services/auth_service.dart';
import '../../utils/text_styles.dart';
import '../../widgets/custom_back_button.dart';

class UserProfilePage extends StatelessWidget {
  const UserProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final ResponsiveUtil resp = ResponsiveUtil.of(context);
    final AuthService auth = Provider.of<AuthService>(context);
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.only(
            left: 32,
            right: 32,
            top: 50,
            bottom: 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomBackButton(),
              SizedBox(height: resp.hp(2.5)),
              Center(
                child: Text(
                  '${auth.user!.displayName ?? 'NoName'} Profile.',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyles.w700(resp.sp30),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: resp.hp(3)),
              Image.asset(
                'assets/images/user.png',
                height: resp.hp(20),
                width: resp.width,
              ),
              SizedBox(height: resp.hp(3)),
              Text(
                'Information:',
                style: TextStyles.w700(resp.sp20, black),
              ),
              SizedBox(height: resp.hp(3)),
              Text(
                'Name: ',
                style: TextStyles.w500(resp.sp16, black),
              ),
              Text(
                auth.user!.displayName ?? 'NoName',
                style: TextStyles.w400(resp.sp14, black),
              ),
              SizedBox(height: resp.hp(3)),
              Text(
                'Email: ',
                style: TextStyles.w500(resp.sp16, black),
              ),
              Text(
                auth.user!.email ?? 'NoEmail',
                style: TextStyles.w400(resp.sp14, black),
              ),
              SizedBox(height: resp.hp(3)),
              Text(
                'Phone number: ',
                style: TextStyles.w500(resp.sp16, black),
              ),
              Text(
                auth.user!.phoneNumber ?? 'NoNumber',
                style: TextStyles.w400(resp.sp14, black),
              ),
              SizedBox(height: resp.hp(3)),
              Text(
                'Registered at: ',
                style: TextStyles.w500(resp.sp16, black),
              ),
              Text(
                DateFormat(DateFormat.YEAR_MONTH_DAY, 'en_US').format(
                  DateTime.now().toUtc(),
                ),
                style: TextStyles.w400(resp.sp14, black),
              ),
              SizedBox(height: resp.hp(3)),
              CustomButton(
                text: 'Save',
                color: accent,
                height: resp.hp(5),
                width: double.infinity,
                onTap: () {},
                style: TextStyles.w700(resp.sp20, Colors.white),
              )
            ],
          ),
        ),
      ),
    );
  }
}
