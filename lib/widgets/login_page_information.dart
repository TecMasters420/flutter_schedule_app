import 'package:flutter/material.dart';
import 'package:schedulemanager/utils/responsive_util.dart';

import '../constants/constants.dart';
import '../utils/text_styles.dart';

class LoginPageInformation extends StatelessWidget {
  final double scale;
  final double opacity;
  final String title;
  final String description;
  final bool withImage;
  final Widget? extraWidget;
  const LoginPageInformation({
    super.key,
    required this.scale,
    required this.opacity,
    required this.title,
    required this.description,
    required this.withImage,
    this.extraWidget,
  });

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
                    style: TextStyles.w600(26, Colors.white),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    description,
                    style: TextStyles.w100(13, Colors.grey[200]!),
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
