import 'package:flutter/material.dart';
import '../utils/responsive_util.dart';
import '../utils/text_styles.dart';

import '../constants/constants.dart';

class CustomFormField extends StatelessWidget {
  final void Function(String value) onChanged;
  final String labelText;
  final String hintText;
  final IconData icon;
  final bool obscure;
  final TextEditingController? controller;

  const CustomFormField({
    super.key,
    required this.labelText,
    required this.hintText,
    required this.icon,
    required this.onChanged,
    this.obscure = false,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final ResponsiveUtil resp = ResponsiveUtil.of(context);
    return TextFormField(
      controller: controller,
      obscureText: obscure,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyles.w400(resp.sp14, grey),
        labelStyle: TextStyles.w400(resp.sp14, grey),
        floatingLabelStyle: TextStyles.w400(resp.sp16, accent),
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
          size: resp.sp20,
          color: accent,
        ),
      ),
    );
  }
}
