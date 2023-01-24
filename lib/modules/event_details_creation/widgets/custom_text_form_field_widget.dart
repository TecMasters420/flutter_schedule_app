import 'package:flutter/material.dart';
import 'package:schedulemanager/app/config/constants.dart';

import '../../../app/utils/text_styles.dart';

class CustomTextFormFieldWidget extends StatelessWidget {
  final void Function(String) onAcceptCallback;
  final String initialText;
  final String label;
  final int maxLines;
  late final TextEditingController controller;
  CustomTextFormFieldWidget({
    super.key,
    required this.initialText,
    required this.label,
    required this.maxLines,
    required this.onAcceptCallback,
  }) {
    controller = TextEditingController(text: initialText);
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.text,
      maxLines: maxLines,
      decoration: InputDecoration(
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 10,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        disabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: accent,
            width: 1.0,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: accent,
            width: 1.0,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: accent,
            width: 1.0,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        alignLabelWithHint: true,
        labelStyle: TextStyles.w500(14, grey),
      ),
      onFieldSubmitted: (value) {
        onAcceptCallback(value);
      },
    );
  }
}
