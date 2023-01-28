import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedulemanager/app/config/constants.dart';
import 'package:schedulemanager/app/utils/text_styles.dart';
import 'package:schedulemanager/widgets/custom_button.dart';
import 'package:schedulemanager/widgets/custom_text_button_widget.dart';

import '../../modules/event_details_creation/widgets/custom_text_form_field_widget.dart';

class AlertDialogsUtil {
  static void forStatusBase(
    String title,
    List<String> bodyText, {
    bool dimissible = false,
    bool showLoadingIndicator = false,
    String image = '',
    Color titleColor = black,
    bool showActions = false,
    VoidCallback? onAccept,
  }) {
    Get.defaultDialog(
      title: '',
      barrierDismissible: dimissible,
      titlePadding: EdgeInsets.zero,
      content: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topCenter,
        children: [
          Container(
            constraints: const BoxConstraints(
              minWidth: 400,
              minHeight: 150,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (image.isNotEmpty) const SizedBox(height: 60),
                Column(
                  children: [
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      style: TextStyles.w700(20, titleColor),
                    ),
                    const SizedBox(height: 5),
                    ...bodyText.map(
                      (e) => Column(
                        children: [
                          Text(
                            '- ${e[0].toUpperCase()}${e.substring(1)}',
                            style: TextStyles.w500(14),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 2.5),
                        ],
                      ),
                    ),
                    if (showLoadingIndicator) ...[
                      const SizedBox(height: 20),
                      const CircularProgressIndicator(),
                    ],
                    if (showActions) ...[
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          CustomButton(
                            text: 'Accept',
                            color: blueAccent,
                            onTap: onAccept ?? () {},
                            style: TextStyles.w700(
                              14,
                              Colors.white,
                            ),
                          ),
                          const SizedBox(width: 20),
                          CustomTextButtonWidget(
                            title: 'Cancel',
                            onTap: () {
                              Get.back();
                            },
                          ),
                        ],
                      )
                    ],
                  ],
                ),
              ],
            ),
          ),
          if (image.isNotEmpty)
            Positioned(
              top: -100,
              // bottom: 50,
              child: Container(
                height: 150,
                width: 150,
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 10,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: shadows,
                ),
                child: Image.asset(image),
              ),
            ),
        ],
      ),
    );
  }

  static void loading({List<String>? customBodyMessage}) {
    forStatusBase(
      'Loading...',
      customBodyMessage ?? [],
      image: 'assets/images/stopwatch.png',
      dimissible: false,
      showLoadingIndicator: true,
    );
  }

  static void error({List<String>? customBodyMessage}) {
    forStatusBase(
      'Error!',
      titleColor: red,
      customBodyMessage ?? [],
      image: 'assets/images/cancel.png',
      dimissible: true,
    );
  }

  static void warning({List<String>? customBodyMessage}) {
    forStatusBase(
      'Warning!',
      titleColor: orange,
      customBodyMessage ?? [],
      image: 'assets/images/warning.png',
      dimissible: true,
    );
  }

  static void check({List<String>? customBodyMessage}) {
    forStatusBase(
      'Completed!',
      titleColor: green,
      customBodyMessage ?? [],
      image: 'assets/images/checked.png',
      dimissible: true,
    );
  }

  static void remove({
    required List<String>? customBodyMessage,
    required VoidCallback onAcceptCallback,
  }) {
    forStatusBase(
      'Delete this item?',
      titleColor: red,
      customBodyMessage ?? [],
      image: 'assets/images/cancel.png',
      dimissible: true,
      showActions: true,
      onAccept: onAcceptCallback,
    );
  }

  static Future<void> withTextField({
    required String title,
    required String initialText,
    required int maxLines,
    void Function(String)? onSummitCallback,
  }) {
    return Get.defaultDialog(
      titlePadding: const EdgeInsets.only(top: 20),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20),
      title: 'Set $title',
      radius: 30,
      titleStyle: TextStyles.w700(18),
      content: Column(
        children: [
          const SizedBox(height: 20),
          CustomTextFormFieldWidget(
            initialText: initialText,
            label: title,
            maxLines: maxLines,
            onAcceptCallback: (value) {
              Get.back();
              if (onSummitCallback != null) {
                onSummitCallback(value);
              }
            },
          )
        ],
      ),
    );
  }
}
