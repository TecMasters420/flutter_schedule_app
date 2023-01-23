import 'package:flutter/material.dart';
import 'package:schedulemanager/app/config/constants.dart';
import 'package:schedulemanager/widgets/custom_cache_image_widget.dart';
import 'custom_circular_progress.dart';

class UserProfilePicture extends StatelessWidget {
  final double height;
  final double width;
  final String userImage;
  final bool redirectToProfile;
  const UserProfilePicture({
    super.key,
    required this.height,
    required this.width,
    required this.userImage,
    this.redirectToProfile = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (redirectToProfile) Navigator.pushNamed(context, 'userProfilePage');
      },
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: containerBg,
          boxShadow: shadows,
          shape: BoxShape.circle,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(1000),
          child: userImage.isEmpty
              ? Image.asset('assets/images/user.png', fit: BoxFit.fill)
              : CustomCacheImageWidget(imageUrl: userImage),
        ),
      ),
    );
  }
}
