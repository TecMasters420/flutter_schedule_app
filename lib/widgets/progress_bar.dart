import 'package:flutter/material.dart';

import '../constants/constants.dart';

class ProgressBar extends StatelessWidget {
  final double percent;
  final double height;
  final double width;
  const ProgressBar({
    super.key,
    required this.percent,
    required this.height,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: accent.withOpacity(0.15),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Stack(
        children: [
          Container(
            height: height,
            width: width * (percent / 100),
            decoration: BoxDecoration(
              color: tempAccent,
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ],
      ),
    );
  }
}
