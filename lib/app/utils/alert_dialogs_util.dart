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
      isScrollControlled: true,
      constraints: ignoreConstraints
          ? const BoxConstraints()
          : BoxConstraints(
              maxHeight: image == null && customChild == null ? 250 : 450,
            ),
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            top: 30,
            right: 30,
            left: 30,
            bottom: MediaQuery.of(context).viewInsets.bottom + 30,
          ),
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
                    style: styles.w500(16, grey),
                  ),
                  const Spacer(),
                  CustomButton(
                    expand: true,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    text: 'Done',
                    color: blueAccent,
                    style: styles.w700(16, Colors.white),
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

  static void removeModal({
    required BuildContext context,
    required String subtitle,
    required void Function() onAcceptCallback,
  }) {
    final styles = TextStyles.of(context);
    _baseModal(
      context: context,
      title: 'Remove',
      subtitle: subtitle,
      customChild: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Center(
            child: Image.asset(
              'assets/images/cancel.png',
              height: 200,
            ),
          ),
          const Spacer(),
          Text(
            'Remove element',
            style: styles.w700(20),
          ),
          const SizedBox(height: 5),
          Text(
            subtitle,
            style: styles.w500(14, grey),
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CustomTextButtonWidget(
                title: 'Cancel',
                onTap: () {
                  Get.back();
                },
              ),
              const SizedBox(width: 20),
              CustomButton(
                expand: true,
                text: 'Accept',
                color: blueAccent,
                style: styles.w700(16, Colors.white),
                onTap: () {
                  Get.back();
                  onAcceptCallback();
                },
              ),
            ],
          )
        ],
      ),
    );
  }

  static void textFieldModal({
    required BuildContext context,
    required String subtitle,
    required String fieldName,
    required String initialText,
    required void Function(String) onAcceptCallback,
  }) {
    final styles = TextStyles.of(context);
    _baseModal(
      context: context,
      title: 'Add data',
      subtitle: subtitle,
      ignoreConstraints: true,
      customChild: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Data',
            style: styles.w700(20),
          ),
          const SizedBox(height: 5),
          Text(
            subtitle,
            style: styles.w500(14, grey),
          ),
          const SizedBox(height: 10),
          CustomTextFormFieldWidget(
            initialText: initialText,
            label: fieldName,
            maxLines: 1,
            onAcceptCallback: (value) {
              Get.back();
              onAcceptCallback(value);
            },
          ),
          const SizedBox(height: 5),
        ],
      ),
    );
  }
}
