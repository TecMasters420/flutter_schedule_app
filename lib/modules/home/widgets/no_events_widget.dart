import 'package:flutter/cupertino.dart';
import 'package:schedulemanager/app/utils/responsive_util.dart';

import '../../../app/config/constants.dart';
import '../../../app/utils/text_styles.dart';

class NoEventsWidget extends StatelessWidget {
  const NoEventsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final resp = ResponsiveUtil.of(context);
    return Center(
      child: Text(
        'No Events',
        style: TextStyles.w500(resp.sp14, lightGrey),
      ),
    );
  }
}
