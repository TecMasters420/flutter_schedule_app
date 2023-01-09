import 'package:flutter/material.dart';
import '../app/config/constants.dart';

class AnimatedMarker extends StatefulWidget {
  const AnimatedMarker({
    super.key,
  });

  @override
  State<AnimatedMarker> createState() => _AnimatedMarkerState();
}

class _AnimatedMarkerState extends State<AnimatedMarker>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500))
      ..forward()
      ..repeat(reverse: true)
      ..addListener(_animationListener);
    _animation = Tween<double>(begin: 1, end: 0.25).animate(_controller);
  }

  void _animationListener() {
    setState(() {});
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double value = _animation.value;
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 35 * value,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: darkAccent.withOpacity(0.5),
            shape: BoxShape.circle,
          ),
        ),
        Container(
          width: 15,
          decoration: const BoxDecoration(
            color: darkAccent,
            shape: BoxShape.circle,
          ),
        ),
      ],
    );
  }
}
