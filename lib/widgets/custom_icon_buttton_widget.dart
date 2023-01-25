import 'package:flutter/material.dart';

class CustomIconButtonWidget extends StatelessWidget {
  final Color color;
  final IconData icon;
  final VoidCallback onTapCallback;
  const CustomIconButtonWidget({
    super.key,
    required this.color,
    required this.icon,
    required this.onTapCallback,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      style: IconButton.styleFrom(padding: EdgeInsets.zero),
      splashRadius: 20,
      splashColor: color.withOpacity(0.3),
      highlightColor: color.withOpacity(0.25),
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints(),
      icon: Icon(
        icon,
        color: color,
        size: 25,
      ),
      onPressed: onTapCallback,
    );
  }
}
