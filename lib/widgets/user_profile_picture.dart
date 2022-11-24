import 'package:flutter/material.dart';
import 'package:schedulemanager/widgets/custom_circular_progress.dart';

class UserProfilePicture extends StatelessWidget {
  final double height;
  final double width;
  final String userImage;
  const UserProfilePicture({
    super.key,
    required this.height,
    required this.width,
    required this.userImage,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, 'userProfilePage');
      },
      child: SizedBox(
        width: width,
        height: height,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: userImage.isEmpty
              ? Image.asset('assets/images/user.png')
              : Image.network(
                  userImage,
                  fit: BoxFit.fill,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset('assets/images/user.png');
                  },
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress != null) {
                      return const CustomCircularProgress();
                    }
                    return child;
                  },
                ),
        ),
      ),
    );
  }
}
