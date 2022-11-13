import 'package:flutter/material.dart';
import 'package:schedulemanager/utils/text_styles.dart';

import '../constants/constants.dart';

class CustomFormField extends StatelessWidget {
  final Function(String value) onChanged;
  final String labelText;
  final String hintText;
  final IconData icon;
  const CustomFormField({
    super.key,
    required this.labelText,
    required this.hintText,
    required this.icon,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        hintStyle: TextStyles.w400(12, grey),
        labelStyle: TextStyles.w400(12, grey),
        floatingLabelStyle: TextStyles.w400(16, accent),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(
            color: accent,
            width: 2,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(
            color: Colors.transparent,
            width: 0,
          ),
        ),
        suffixIcon: Icon(
          icon,
          size: 25,
          color: accent,
        ),
      ),
    );
  }
}
