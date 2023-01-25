import 'package:flutter/material.dart';
import 'package:schedulemanager/app/config/constants.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onTap;
  final Color color;
  final TextStyle style;
  final String text;
  final Widget? prefixWidget;
  final BoxConstraints? constraints;
  final bool hideShadows;
  final EdgeInsets? padding;
  final bool expand;
  final bool center;
  const CustomButton({
    super.key,
    required this.text,
    required this.color,
    required this.onTap,
    required this.style,
    this.prefixWidget,
    this.constraints,
    this.padding,
    this.center = false,
    this.expand = false,
    this.hideShadows = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        constraints: constraints ?? const BoxConstraints(),
        padding: padding ??
            const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 10,
            ),
        alignment: expand ? Alignment.center : null,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
          boxShadow: hideShadows ? null : shadows,
        ),
        child: prefixWidget == null
            ? Text(text, style: style)
            : Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment:
                    center ? MainAxisAlignment.center : MainAxisAlignment.start,
                children: [
                  prefixWidget!,
                  const SizedBox(width: 5),
                  Text(text, style: style),
                ],
              ),
      ),
    );
  }
}
