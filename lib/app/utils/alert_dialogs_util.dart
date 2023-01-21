import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedulemanager/app/config/constants.dart';
import 'package:schedulemanager/app/utils/text_styles.dart';

class AlertDialogsUtil {
  static void forStatusBase(
    String title,
    List<String> bodyText, {
    bool dimissible = false,
    bool showLoadingIndicator = false,
    String image = '',
    Color titleColor = black,
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
                    Text(title, style: TextStyles.w700(20, titleColor)),
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
                    ]
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
}
