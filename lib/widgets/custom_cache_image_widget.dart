import 'package:cached_network_image/cached_network_image.dart';
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

    return CachedNetworkImage(
      imageUrl: imageUrl.trim(),
      fit: fit,
      progressIndicatorBuilder: (context, url, progress) {
        return const CustomCircularProgress(
          color: blueAccent,
        );
      },
      imageBuilder: (context, imageProvider) {
        return Image(image: imageProvider, fit: fit);
      },
      errorWidget: (context, error, stackTrace) {
        debugPrint('Error loading image');
        return Text(
          'Error loading image',
          style: styles.w600(16, Colors.white),
        );
      },
    );
  }
}
