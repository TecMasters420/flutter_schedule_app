import 'package:flutter/material.dart';

class MapPreview extends StatelessWidget {
  const MapPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Image.asset(
        'assets/images/testMap.png',
        height: 150,
        width: 500,
        fit: BoxFit.cover,
      ),
    );
  }
}
