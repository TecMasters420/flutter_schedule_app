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
    final styles = TextStyles.of(context);
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.text,
      maxLines: maxLines,
      style: styles.w500(14),
      decoration: InputDecoration(
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 15,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        disabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: blueAccent,
            width: 1.0,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: blueAccent,
            width: 1.0,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: blueAccent,
            width: 1.0,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        alignLabelWithHint: true,
        labelStyle: styles.w500(14, grey),
        hintStyle: styles.w500(14),
      ),
      onFieldSubmitted: (value) {
        onAcceptCallback(value);
      },
    );
  }
}
