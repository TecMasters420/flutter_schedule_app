import 'package:flutter/material.dart';
import 'package:schedulemanager/app/config/app_constants.dart';
import 'package:schedulemanager/app/config/constants.dart';
import 'package:schedulemanager/app/utils/responsive_util.dart';
import 'package:schedulemanager/widgets/custom_header_widget.dart';
import 'package:schedulemanager/widgets/custom_text_button_widget.dart';

import '../../../app/utils/text_styles.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/user_profile_picture.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ResponsiveUtil resp = ResponsiveUtil.of(context);
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: AppConstants.bodyPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomHeaderWidget(title: 'Notifications'),
              SizedBox(height: resp.hp(2.5)),
              Text(
                'Invitations',
                style: TextStyles.w700(20),
              ),
              SizedBox(height: resp.hp(2.5)),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                alignment: Alignment.topLeft,
                decoration: BoxDecoration(
                  color: containerBg,
                  boxShadow: shadows,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    UserProfilePicture(
                      height: resp.hp(4),
                      width: resp.wp(10),
                      userImage: 'assets/images/user.png',
                    ),
                    SizedBox(width: resp.wp(2.5)),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            text: TextSpan(
                              text: 'Francisco Rodríguez 2 ',
                              style: TextStyles.w700(14),
                              children: [
                                TextSpan(
                                  text: 'has invited you to event: ',
                                  style: TextStyles.w500(14),
                                ),
                                TextSpan(
                                  text: 'Create application',
                                  style: TextStyles.w700(14, accent),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            '5 minutes ago',
                            style: TextStyles.w500(14, grey),
                          ),
                          CustomTextButtonWidget(
                            title: 'See details',
                            onTap: () {},
                          ),
                          SizedBox(height: resp.hp(2)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              CustomButton(
                                constraints:
                                    const BoxConstraints(maxWidth: 150),
                                text: 'Accept',
                                color: accent,
                                height: resp.hp(4),
                                width: resp.wp(20),
                                style: TextStyles.w700(14, Colors.white),
                                hideShadows: true,
                                onTap: () {},
                              ),
                              SizedBox(width: resp.wp(2.5)),
                              CustomButton(
                                constraints:
                                    const BoxConstraints(maxWidth: 150),
                                text: 'Deny',
                                color: lightBlue,
                                height: resp.hp(4),
                                width: resp.wp(20),
                                style: TextStyles.w700(14, accent),
                                hideShadows: true,
                                onTap: () {},
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: resp.hp(2.5)),
              Text(
                'Events',
                style: TextStyles.w700(20),
              ),
              SizedBox(height: resp.hp(2.5)),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                alignment: Alignment.topLeft,
                decoration: BoxDecoration(
                  color: containerBg,
                  boxShadow: shadows,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: resp.hp(4.5),
                      width: resp.wp(10),
                      decoration: BoxDecoration(
                        color: containerBg,
                        boxShadow: shadows,
                        shape: BoxShape.circle,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          'assets/images/calendar.png',
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    SizedBox(width: resp.wp(2.5)),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            text: TextSpan(
                              text: '2 months ',
                              style: TextStyles.w700(14),
                              children: [
                                TextSpan(
                                  text: 'left until the end of the event: ',
                                  style: TextStyles.w500(14),
                                ),
                                TextSpan(
                                  text: 'Create application',
                                  style: TextStyles.w700(14, accent),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            '5 minutes ago',
                            style: TextStyles.w500(14, grey),
                          ),
                          SizedBox(height: resp.hp(2)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              CustomButton(
                                constraints:
                                    const BoxConstraints(maxWidth: 150),
                                text: 'Details',
                                color: accent,
                                height: resp.hp(4),
                                width: resp.wp(20),
                                style: TextStyles.w700(14, Colors.white),
                                hideShadows: true,
                                onTap: () {},
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: resp.hp(2.5)),
              Text(
                'Group Events',
                style: TextStyles.w700(20),
              ),
              SizedBox(height: resp.hp(2.5)),
              ...List.generate(
                5,
                (x) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: x < 4 ? 20 : 0),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 15),
                      alignment: Alignment.topLeft,
                      decoration: BoxDecoration(
                        color: containerBg,
                        boxShadow: shadows,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          UserProfilePicture(
                            height: resp.hp(4),
                            width: resp.wp(10),
                            userImage: 'assets/images/user.png',
                          ),
                          SizedBox(width: resp.wp(2.5)),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RichText(
                                  text: TextSpan(
                                    text: 'Carlos Catalan ',
                                    style: TextStyles.w700(14),
                                    children: [
                                      TextSpan(
                                        text: 'has modified the event ',
                                        style: TextStyles.w500(14),
                                      ),
                                      TextSpan(
                                        text: 'Finish Home Page',
                                        style: TextStyles.w700(14, accent),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: resp.hp(1)),
                                Text(
                                  'Changes',
                                  style: TextStyles.w700(14),
                                ),
                                ...['Animations in the statistics'].map(
                                  (e) => Row(
                                    children: [
                                      Container(
                                        width: 5,
                                        height: 5,
                                        decoration: const BoxDecoration(
                                          color: accent,
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                      const SizedBox(width: 5),
                                      Text(
                                        e,
                                        style: TextStyles.w500(14),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: resp.hp(1)),
                                Text(
                                  '5 minutes ago',
                                  style: TextStyles.w500(14, grey),
                                ),
                                SizedBox(height: resp.hp(2)),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    CustomButton(
                                      constraints:
                                          const BoxConstraints(maxWidth: 150),
                                      text: 'Details',
                                      color: accent,
                                      height: resp.hp(4),
                                      width: resp.wp(20),
                                      style: TextStyles.w700(14, Colors.white),
                                      hideShadows: true,
                                      onTap: () {},
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
