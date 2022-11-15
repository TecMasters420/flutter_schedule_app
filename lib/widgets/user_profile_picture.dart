import 'package:flutter/material.dart';

class UserProfilePicture extends StatelessWidget {
  final double size;
  const UserProfilePicture({
    super.key,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return FlutterLogo(size: size);
  }
}
