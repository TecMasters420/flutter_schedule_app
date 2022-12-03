import 'package:flutter/material.dart';

import '../../app/config/constants.dart';
import '../../app/utils/responsive_util.dart';
import '../../app/utils/text_styles.dart';

class CustomFormField extends StatelessWidget {
  final void Function(String value) onChanged;
  final String labelText;
  final String hintText;
  final IconData icon;
  final bool obscure;
  final TextEditingController? controller;
  final int? maxLines;

  const CustomFormField({
    super.key,
    required this.labelText,
    required this.hintText,
    required this.icon,
    required this.onChanged,
    this.obscure = false,
    this.controller,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    final ResponsiveUtil resp = ResponsiveUtil.of(context);
    return TextFormField(
      controller: controller,
      maxLines: maxLines ?? 1,
      obscureText: obscure,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyles.w400(resp.sp14, grey),
        labelStyle: TextStyles.w400(resp.sp14, grey),
        floatingLabelStyle: TextStyles.w400(resp.sp16, accent),
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
          size: resp.sp20,
          color: accent,
        ),
      ),
    );
  }
}
