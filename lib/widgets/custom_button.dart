import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onTap;
  final Color color;
  final TextStyle style;
  final double height;
  final double width;
  final String text;
  final Widget? prefixWidget;
  final BoxConstraints? constraints;
  const CustomButton(
      {super.key,
      required this.text,
      required this.color,
      required this.height,
      required this.width,
      required this.onTap,
      required this.style,
      this.prefixWidget,
      this.constraints});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        constraints: constraints ?? const BoxConstraints(),
        height: height,
        width: width,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
        ),
        child: prefixWidget == null
            ? Text(text, style: style)
            : Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
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
