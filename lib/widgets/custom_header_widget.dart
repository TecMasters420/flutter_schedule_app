import 'package:flutter/material.dart';

import '../app/config/constants.dart';
import '../app/utils/text_styles.dart';
import 'custom_back_button.dart';

class CustomHeaderWidget extends StatelessWidget {
  final String title;
  final double titleSize;
  final Widget? suffixWidget;
  const CustomHeaderWidget({
    super.key,
    required this.title,
    this.suffixWidget,
    this.titleSize = 25,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: CustomBackButton()),
        Expanded(
          flex: 8,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: accent,
              borderRadius: BorderRadius.circular(15),
              boxShadow: shadows,
            ),
            child: Center(
              child: Text(
                title,
                style: TextStyles.w700(titleSize, Colors.white),
              ),
            ),
          ),
        ),
        Expanded(
          child: suffixWidget ?? const SizedBox(),
        ),
      ],
    );
  }
}
