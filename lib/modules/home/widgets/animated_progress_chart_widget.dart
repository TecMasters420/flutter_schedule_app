import 'package:flutter/material.dart';
import 'package:schedulemanager/widgets/painters/home_progress_chart_painter.dart';

import '../models/user_progress_model.dart';

class AnimatedProgressChartWidget extends StatefulWidget {
  final List<Color> progressColors;
  final List<UserProgressModel> percents;
  const AnimatedProgressChartWidget({
    super.key,
    required this.progressColors,
    required this.percents,
  });

  @override
  State<AnimatedProgressChartWidget> createState() =>
      _AnimatedProgressChartWidgetState();
}

class _AnimatedProgressChartWidgetState
    extends State<AnimatedProgressChartWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 2000));
    _animation = Tween<double>(begin: 0, end: 1)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.ease))
      ..addListener(_listener);
    _controller.forward();
    _controller.repeat(reverse: true);
    super.initState();
  }

  void _listener() {
    setState(() {});
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final value = _animation.value;

    return CustomPaint(
      isComplex: true,
      painter: HomeProgressChart(
        percents: widget.percents.map((e) => e.percent).toList(),
        animationValue:
            _controller.status == AnimationStatus.forward ? value : -value,
        colors: widget.progressColors,
      ),
    );
  }
}
