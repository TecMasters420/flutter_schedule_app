import 'package:flutter/material.dart';
import 'package:schedulemanager/app/config/constants.dart';

class ResponsiveContainerWidget extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final Color? customColor;
  final BoxConstraints? constraints;
  const ResponsiveContainerWidget({
    super.key,
    required this.child,
    this.padding,
    this.customColor,
    this.constraints,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: Container(
        constraints: constraints ?? const BoxConstraints(maxWidth: 600),
        margin: const EdgeInsets.symmetric(vertical: 0.8, horizontal: 0.8),
        clipBehavior: Clip.hardEdge,
        padding: padding ??
            const EdgeInsets.symmetric(
              vertical: 15,
              horizontal: 20,
            ),
        decoration: BoxDecoration(
          color: customColor ?? Theme.of(context).colorScheme.surface,
          // color: customColor,
          borderRadius: BorderRadius.circular(25),
          boxShadow: shadows,
        ),
        child: child,
      ),
    );
  }
}
