import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class HomeProgressChart extends CustomPainter {
  final List<double> percents;
  final List<Color> colors;
  double animationValue;
  HomeProgressChart({
    required this.percents,
    required this.animationValue,
    required this.colors,
  });

  @override
  void paint(Canvas canvas, Size size) {
    double space = 1;
    const double decrement = 0.25;
    animationValue = clampDouble(animationValue.abs(), 0.01, 1) *
        (animationValue < 0 ? -1 : 1);
    for (int x = 0; x < percents.length; x++) {
      final strokeWidth = size.width / 20;
      final center = Offset(size.width / 2, size.height / 2);
      final radius = (size.width / 2) * space;
      space -= decrement;

      // Color del circulo de atras
      final backgroundPaint = Paint()
        ..isAntiAlias = true
        ..strokeWidth = strokeWidth
        ..color = Colors.transparent
        ..style = PaintingStyle.stroke;
      canvas.drawCircle(center, radius, backgroundPaint);

      // Color del circulo frontal
      final foregroundPaint = Paint()
        ..isAntiAlias = true
        ..strokeWidth = strokeWidth
        ..color = colors[x]
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round;
      final foregroundPaint2 = Paint()
        ..isAntiAlias = true
        ..strokeWidth = strokeWidth
        ..color = colors[x].withOpacity(0.15)
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round;

      final finalSize = 2 * pi * (percents[x] / 100);

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        pi * animationValue,
        2 * pi * animationValue,
        // finalSize
        false,
        foregroundPaint2,
      );
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        (pi * animationValue) + (finalSize * animationValue.abs()),
        finalSize * animationValue.abs(),
        false,
        foregroundPaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
