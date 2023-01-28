import 'package:flutter/material.dart';
import '../../../app/utils/text_styles.dart';

class WeatherContainer extends StatelessWidget {
  final int temp;
  const WeatherContainer({
    super.key,
    required this.temp,
  });

  @override
  Widget build(BuildContext context) {
    final styles = TextStyles.of(context);
    return Stack(
      alignment: Alignment.center,
      children: [
        Text(
          '$temp° C',
          style: styles.w600(30),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Opacity(
            opacity: 0.15,
            child: Image.asset(
              'assets/images/weather.png',
              fit: BoxFit.contain,
              height: 100,
              width: double.infinity,
            ),
          ),
        ),
      ],
    );
  }
}
