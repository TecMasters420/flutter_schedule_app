import 'package:flutter/material.dart';
import 'package:schedulemanager/constants/constants.dart';
import 'package:schedulemanager/utils/responsive_util.dart';
import 'package:schedulemanager/utils/text_styles.dart';
import 'package:schedulemanager/widgets/user_profile_picture.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final ResponsiveUtil resp = ResponsiveUtil.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.notifications_none_rounded, color: black),
            const Spacer(),
            UserProfilePicture(size: resp.dp(5))
          ],
        ),
        SizedBox(height: resp.hp(2.5)),
        Row(
          children: [
            Text(
              'Hello, ',
              style: TextStyles.w400(resp.dp(4)),
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              'Francisco!',
              style: TextStyles.w400(resp.dp(4), lightGrey),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
        Text(
          'A great day to get better',
          style: TextStyles.w400(resp.dp(1.5), lightGrey),
        ),
        SizedBox(height: resp.hp(5)),
      ],
    );
  }
}
