import 'package:flutter/material.dart';

import '../app/config/constants.dart';
import '../app/utils/text_styles.dart';

class CustomFormField extends StatelessWidget {
  final void Function(String value) onChanged;
  final IconData icon;
  final bool obscure;
  final TextEditingController? controller;
  final int? maxLines;

  const CustomFormField({
    super.key,
    required this.icon,
    required this.onChanged,
    this.obscure = false,
    this.controller,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines ?? 1,
      obscureText: obscure,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintStyle: TextStyles.w400(14, grey),
        labelStyle: TextStyles.w400(14, grey),
        floatingLabelStyle: TextStyles.w400(16, accent),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: accent,
            width: 2,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: lightGrey,
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
