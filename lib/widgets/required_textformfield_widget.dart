import 'package:flutter/material.dart';
import 'package:schedulemanager/app/utils/responsive_util.dart';

import '../app/utils/text_styles.dart';
import 'custom_form_field.dart';

class RequiredTextFormFieldWidget extends StatelessWidget {
  final String title;
  final IconData suffixIcon;
  final bool obscure;
  final void Function(String) onChangeCallback;
  const RequiredTextFormFieldWidget({
    super.key,
    required this.title,
    required this.suffixIcon,
    required this.onChangeCallback,
    this.obscure = false,
  });

  @override
  Widget build(BuildContext context) {
    final ResponsiveUtil resp = ResponsiveUtil.of(context);
    final styles = TextStyles.of(context);
    return Column(
      children: [
        Row(
          children: [
            Text(
              title,
              style: styles.w700(14),
            ),
            Text(
              ' *',
              style: styles.w700(14, Colors.red),
            ),
          ],
        ),
        SizedBox(height: resp.hp(1)),
        CustomFormField(
          obscure: obscure,
          icon: suffixIcon,
          onChanged: onChangeCallback,
        ),
      ],
    );
  }
}
