import 'package:flutter/material.dart';
import 'package:schedulemanager/app/config/constants.dart';

import '../../../app/utils/responsive_util.dart';

class DotIndicator extends StatelessWidget {
  final bool isFinalElement;
  final bool isCurrentPage;
  const DotIndicator({
    super.key,
    required this.isFinalElement,
    required this.isCurrentPage,
  });

  @override
  Widget build(BuildContext context) {
    final ResponsiveUtil resp = ResponsiveUtil.of(context);
    return Padding(
      padding: EdgeInsets.only(
        right: !isFinalElement ? 5 : 0,
      ),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        height: resp.hp(1.25),
        width: isCurrentPage ? 24 : 12,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(isCurrentPage ? 20 : 100),
          color: isCurrentPage ? accent : accent.withOpacity(0.25),
        ),
      ),
    );
  }
}
