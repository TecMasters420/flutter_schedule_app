import 'package:flutter/material.dart';
import 'package:schedulemanager/app/utils/responsive_util.dart';
import 'package:schedulemanager/app/utils/text_styles.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final ResponsiveUtil resp = ResponsiveUtil.of(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(),
          SizedBox(height: resp.hp(2.5)),
          Text('Loading...', style: TextStyles.w700(16)),
        ],
      ),
    );
  }
}
