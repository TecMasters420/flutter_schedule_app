import 'package:flutter/material.dart';
import '../../../app/utils/responsive_util.dart';

import '../../../app/config/constants.dart';
import '../../../app/utils/text_styles.dart';
import '../../../widgets/custom_circular_progress.dart';

class LoginPageInformation extends StatelessWidget {
  final double scale;
  final double opacity;
  final String title;
  final String description;
  final String? imageUrl;
  final bool withImage;
  final Widget? extraWidget;
  const LoginPageInformation(
      {super.key,
      required this.scale,
      required this.opacity,
      required this.title,
      required this.description,
      required this.withImage,
      this.extraWidget,
      this.imageUrl});

  @override
  Widget build(BuildContext context) {
    final ResponsiveUtil resp = ResponsiveUtil.of(context);
    return AnimatedScale(
      duration: const Duration(milliseconds: 250),
      scale: scale,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 250),
        opacity: opacity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Image
            if (withImage)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Container(
                  height: resp.hp(65),
                  decoration: BoxDecoration(
                    color: tempAccent,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: withImage && imageUrl != null && imageUrl != ''
                      ? imageUrl!.contains('assets/images')
                          ? Image.asset(imageUrl!)
                          : Image.network(
                              imageUrl!,
                              loadingBuilder:
                                  (context, child, loadingProgress) {
                                if (loadingProgress == null) return child;
                                return const CustomCircularProgress();
                              },
                              errorBuilder: (context, error, stackTrace) {
                                debugPrint('Error loading image');
                                return Text(
                                  'Error loading image',
                                  style: TextStyles.w600(16, Colors.white),
                                );
                              },
                            )
                      : SizedBox(
                          height: resp.hp(65),
                          width: double.infinity,
                        ),
                ),
              ),

            // Information
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 100),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Text(
                    title,
                    style: TextStyles.w600(resp.sp30, Colors.white),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    description,
                    style: TextStyles.w400(16, Colors.grey[100]!),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                  ),
                ],
              ),
            ),
            if (extraWidget != null) extraWidget!
          ],
        ),
      ),
    );
  }
}
