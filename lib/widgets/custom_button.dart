import 'package:flutter/material.dart';
import 'package:schedule_app/constants/constants.dart';
import 'package:schedule_app/utils/responsive_util.dart';

import '../utils/text_styles.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  const CustomButton({
    super.key,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final ResponsiveUtil resp = ResponsiveUtil.of(context);
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: resp.hp(5),
          width: resp.wp(40),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: tempAccent,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            text,
            style: TextStyles.w900(
              16,
              Colors.grey[300]!,
            ),
          ),
        ),
      ),
    );
  }
}
