import 'package:flutter/material.dart';
import 'package:schedulemanager/widgets/loading_widget.dart';
import '../../../app/utils/responsive_util.dart';

import '../../../app/config/constants.dart';
import '../../../app/utils/text_styles.dart';

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
              Flexible(
                child: SizedBox(
                  height: resp.hp(65),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: resp.wp(5)),
                    child: withImage && imageUrl != null && imageUrl != ''
                        ? imageUrl!.contains('assets/images')
                            ? Image.asset(imageUrl!)
                            : Image.network(
                                imageUrl!,
                                loadingBuilder:
                                    (context, child, loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return const LoadingWidget();
                                },
                                errorBuilder: (context, error, stackTrace) {
                                  debugPrint('Error loading image');
                                  return Text(
                                    'Error loading image',
                                    style: TextStyles.w600(16, Colors.white),
                                  );
                                },
                              )
                        : null,
                  ),
                ),
              ),

            // Information
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 100),
              child: Column(
                children: [
                  SizedBox(height: resp.hp(2.5)),
                  Text(
                    title,
                    style: TextStyles.w800(30),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    description,
                    style: TextStyles.w500(16, grey),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                  ),
                  if (extraWidget != null) ...[
                    SizedBox(height: resp.hp(2)),
                    extraWidget!,
                  ],
                ],
              ),
            ),
            SizedBox(height: resp.hp(10)),
          ],
        ),
      ),
    );
  }
}
