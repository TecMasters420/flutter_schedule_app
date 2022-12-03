import 'package:flutter/material.dart';

import '../../app_docker/constants/constants.dart';

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
      child: LayoutBuilder(builder: (context, constraints) {
        return Stack(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOut,
              height: height,
              width: constraints.maxWidth * (percent / 100),
              decoration: BoxDecoration(
                color: accent,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ],
        );
      }),
    );
  }
}
