import 'package:flutter/material.dart';
import 'package:schedulemanager/app/config/constants.dart';

class ResponsiveContainerWidget extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  const ResponsiveContainerWidget({
    super.key,
    required this.child,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ??
          const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 20,
          ),
      decoration: BoxDecoration(
        color: containerBg,
        borderRadius: BorderRadius.circular(20),
        boxShadow: shadows,
      ),
      child: child,
    );
  }
}
