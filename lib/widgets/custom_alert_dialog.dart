import 'package:flutter/material.dart';
import '../utils/responsive_util.dart';

import '../constants/constants.dart';
import '../utils/text_styles.dart';
import 'custom_button.dart';

class CustomAlertDialog {
  CustomAlertDialog({
    required final ResponsiveUtil resp,
    required final BuildContext context,
    required final VoidCallback onAcceptCallback,
    required final String title,
    final Widget? customBody,
  }) {
    final AlertDialog alert = AlertDialog(
      actionsAlignment: MainAxisAlignment.center,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      title: Text(
        title,
        style: TextStyles.w500(resp.sp20),
        textAlign: TextAlign.center,
      ),
      content: customBody ??
          Text(
            'Select an option',
            style: TextStyles.w500(resp.sp16, grey),
            textAlign: TextAlign.center,
          ),
      actions: [
        CustomButton(
          text: 'No',
          color: lightGrey.withOpacity(0.25),
          height: resp.hp(5),
          width: resp.wp(25),
          onTap: () => Navigator.pop(context),
          style: TextStyles.w500(resp.sp16),
        ),
        CustomButton(
          text: 'Yes',
          color: accent,
          height: resp.hp(5),
          width: resp.wp(25),
          onTap: () {
            Navigator.pop(context);
            onAcceptCallback();
          },
          style: TextStyles.w500(resp.sp16, Colors.white),
        ),
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
