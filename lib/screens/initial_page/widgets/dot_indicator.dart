import 'package:flutter/material.dart';
import '../../../utils/responsive_util.dart';

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
          color: isCurrentPage ? Colors.white : Colors.white.withOpacity(0.5),
        ),
      ),
    );
  }
}
