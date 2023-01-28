import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedulemanager/app/config/constants.dart';
import 'package:schedulemanager/widgets/custom_icon_buttton_widget.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomIconButtonWidget(
      color: blueAccent,
      icon: Icons.arrow_back_ios_rounded,
      onTapCallback: Get.back,
    );
  }
}
