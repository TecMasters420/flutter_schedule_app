import 'package:flutter/material.dart';

class UserProfilePicture extends StatelessWidget {
  final double size;
  const UserProfilePicture({
    super.key,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, 'userProfilePage');
      },
      child: CircleAvatar(
        radius: size,
        child: Image.asset('assets/images/user.png'),
      ),
    );
  }
}
