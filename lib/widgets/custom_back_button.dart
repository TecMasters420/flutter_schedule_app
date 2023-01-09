import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedulemanager/app/config/constants.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(
        Icons.arrow_back_ios_rounded,
        color: accent,
      ),
      splashRadius: 20,
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.zero,
      onPressed: () => Get.back(),
    );
  }
}
