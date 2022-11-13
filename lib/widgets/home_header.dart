import 'package:flutter/material.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        FlutterLogo(
          size: 50,
        ),
        Spacer(),
        Icon(Icons.notifications_none_rounded)
      ],
    );
  }
}
