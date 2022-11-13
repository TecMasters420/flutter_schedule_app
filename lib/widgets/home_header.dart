import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:schedulemanager/constants/constants.dart';
import 'package:schedulemanager/utils/responsive_util.dart';
import 'package:schedulemanager/utils/text_styles.dart';

import '../services/auth_service.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final ResponsiveUtil resp = ResponsiveUtil.of(context);
    final AuthService auth = Provider.of<AuthService>(context);
    return Column(
      children: [
        Row(
          children: const [
            FlutterLogo(
              size: 50,
            ),
            Spacer(),
            Icon(Icons.notifications_none_rounded)
          ],
        ),
        SizedBox(height: resp.hp(2.5)),
        Row(
          children: [
            Text(
              'Hello, ',
              style: TextStyles.w400(38),
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              'Francisco!',
              style: TextStyles.w400(38, lightGrey),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ],
    );
  }
}
