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
    final styles = TextStyles.of(context);

    return Image.network(
      imageUrl.trim(),
      fit: fit,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return const CustomCircularProgress(
          color: blueAccent,
        );
      },
      errorBuilder: (context, error, stackTrace) {
        debugPrint('Error loading image');
        return Text(
          'Error loading image',
          style: styles.w600(16, Colors.white),
        );
      },
    );
  }
}
