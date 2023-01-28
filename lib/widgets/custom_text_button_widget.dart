import 'package:flutter/material.dart';

import '../app/config/constants.dart';
import '../app/utils/text_styles.dart';

class CustomTextButtonWidget extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final double customFontSize;
  const CustomTextButtonWidget({
    super.key,
    required this.title,
    required this.onTap,
    this.customFontSize = 14,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
        minimumSize: const Size(10, 10),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        alignment: Alignment.centerLeft,
      ),
      onPressed: onTap,
      child: Text(
        title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyles.w700(customFontSize, blueAccent),
      ),
    );
  }
}
