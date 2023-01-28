import 'package:flutter/material.dart';

import '../app/config/constants.dart';
import '../app/utils/responsive_util.dart';
import '../app/utils/text_styles.dart';
import 'custom_button.dart';

class CustomAlertDialog {
  CustomAlertDialog({
    required final ResponsiveUtil resp,
    required final BuildContext context,
    required final VoidCallback onAcceptCallback,
    required final String title,
    final bool showButtons = true,
    final bool dismissible = true,
    final Widget? customBody,
  }) {
    final styles = TextStyles.of(context);

    final AlertDialog alert = AlertDialog(
      actionsAlignment: MainAxisAlignment.center,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      title: Text(
        title,
        style: styles.w500(25),
        textAlign: TextAlign.center,
      ),
      content: customBody ??
          Text(
            'Select an option',
            style: styles.w500(16, grey),
            textAlign: TextAlign.center,
          ),
      actions: [
        if (showButtons) ...[
          CustomButton(
            text: 'No',
            color: lightGrey.withOpacity(0.25),
            onTap: () => Navigator.pop(context),
            style: styles.w500(16),
          ),
          CustomButton(
            text: 'Yes',
            color: blueAccent,
            onTap: () {
              Navigator.pop(context);
              onAcceptCallback();
            },
            style: styles.w500(16, Colors.white),
          ),
        ]
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      barrierDismissible: dismissible,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
