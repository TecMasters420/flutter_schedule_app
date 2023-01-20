import 'package:flutter/material.dart';

import '../app/config/constants.dart';

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
    final Color progressColor = percent == 0
        ? lightGrey
        : percent <= 25
            ? red
            : percent <= 50
                ? orange
                : green;

    return Container(
      height: height,
      width: width,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: const Color(0xffeaebf0),
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
                color: progressColor,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ],
        );
      }),
    );
  }
}
