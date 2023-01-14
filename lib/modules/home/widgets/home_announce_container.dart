import 'package:flutter/material.dart';
import '../../../app/utils/responsive_util.dart';

import '../../../app/config/constants.dart';
import '../../../app/utils/text_styles.dart';

class HomeAnnounceContainer extends StatelessWidget {
  final String title;
  final Widget secondWidget;
  const HomeAnnounceContainer({
    super.key,
    required this.title,
    required this.secondWidget,
  });

  @override
  Widget build(BuildContext context) {
    final ResponsiveUtil resp = ResponsiveUtil.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      decoration: BoxDecoration(
        color: containerBg,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              title,
              style: TextStyles.w500(16),
            ),
          ),
          SizedBox(width: resp.wp(2.5)),
          Expanded(
            flex: 2,
            child: secondWidget,
          ),
        ],
      ),
    );
  }
}
