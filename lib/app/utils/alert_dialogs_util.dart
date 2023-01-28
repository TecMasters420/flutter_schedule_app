import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedulemanager/app/config/constants.dart';
import 'package:schedulemanager/app/utils/text_styles.dart';
import 'package:schedulemanager/widgets/custom_button.dart';
import 'package:schedulemanager/widgets/custom_circular_progress.dart';
import 'package:schedulemanager/widgets/custom_text_button_widget.dart';

import '../../modules/event_details_creation/widgets/custom_text_form_field_widget.dart';

class AlertDialogsUtil {
  static void _baseModal({
    required BuildContext context,
    required String title,
    required String subtitle,
    String? image,
    Widget? customChild,
    bool ignoreConstraints = false,
  }) {
    final styles = TextStyles.of(context);
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
      enableDrag: false,
      isDismissible: false,
      constraints: ignoreConstraints
          ? const BoxConstraints()
          : BoxConstraints(
              maxHeight: image == null && customChild == null ? 250 : 450,
            ),
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(30),
          child: customChild ??
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (image != null)
                    Center(
                      child: Image.asset(
                        image,
                        height: 200,
                      ),
                    ),
                  const Spacer(),
                  Text(
                    title,
                    style: styles.w700(20),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    subtitle,
                    style: styles.w500(14, grey),
                  ),
                  const Spacer(),
                  CustomButton(
                    expand: true,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    text: 'Done',
                    color: blueAccent,
                    style: styles.w700(16),
                    onTap: () {
                      Get.back();
                    },
                  )
                ],
              ),
        );
      },
    );
  }

  static void errorModal({
    required BuildContext context,
    required String title,
    required String subtitle,
  }) {
    _baseModal(
      context: context,
      title: title,
      subtitle: subtitle,
      image: 'assets/images/cancel.png',
    );
  }

  static void completedModal({
    required BuildContext context,
    required String title,
    required String subtitle,
  }) {
    _baseModal(
      context: context,
      title: title,
      subtitle: subtitle,
      image: 'assets/images/checked.png',
    );
  }

  static void warningModal({
    required BuildContext context,
    required String title,
    required String subtitle,
  }) {
    _baseModal(
      context: context,
      title: title,
      subtitle: subtitle,
      image: 'assets/images/warning.png',
    );
  }

  static void loadingModal({
    required BuildContext context,
    required String subtitle,
  }) {
    final styles = TextStyles.of(context);
    _baseModal(
      context: context,
      title: 'Loading',
      subtitle: subtitle,
      ignoreConstraints: true,
      customChild: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            height: 50,
            child: CustomCircularProgress(
              color: blueAccent,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            'Loading',
            style: styles.w700(20),
          ),
          const SizedBox(height: 5),
          Text(
            subtitle,
            style: styles.w500(14, grey),
          ),
          const SizedBox(height: 5),
        ],
      ),
    );
  }

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
    final context = Get.context!;
    final styles = TextStyles.of(context);
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
                      style: styles.w700(20, titleColor),
                    ),
                    const SizedBox(height: 5),
                    ...bodyText.map(
                      (e) => Column(
                        children: [
                          Text(
                            '- ${e[0].toUpperCase()}${e.substring(1)}',
                            style: styles.w500(14),
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
                            style: styles.w700(
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
    final context = Get.context!;
    final styles = TextStyles.of(context);
    return Get.defaultDialog(
      titlePadding: const EdgeInsets.only(top: 20),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20),
      title: 'Set $title',
      radius: 30,
      titleStyle: styles.w700(18),
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
