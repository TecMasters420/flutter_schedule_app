import 'package:flutter/material.dart';
import 'package:schedulemanager/app/config/constants.dart';
import 'package:schedulemanager/widgets/custom_circular_progress.dart';
import '../app/utils/text_styles.dart';

class CustomCacheImageWidget extends StatelessWidget {
  final String imageUrl;
  final BoxFit fit;
  const CustomCacheImageWidget({
    super.key,
    required this.imageUrl,
    this.fit = BoxFit.fill,
  });

  @override
  Widget build(BuildContext context) {
    return Image.network(
      imageUrl.trim(),
      fit: fit,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return const CustomCircularProgress(
          color: accent,
        );
      },
      errorBuilder: (context, error, stackTrace) {
        debugPrint('Error loading image');
        return Text(
          'Error loading image',
          style: TextStyles.w600(16, Colors.white),
        );
      },
    );
  }
}
