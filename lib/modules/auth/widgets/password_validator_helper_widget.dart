import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedulemanager/app/config/constants.dart';
import 'package:schedulemanager/app/utils/text_styles.dart';
import 'package:schedulemanager/modules/auth/controllers/password_validator_controller.dart';

class PasswordValidatorHelperWidget extends StatelessWidget {
  final String pass;
  const PasswordValidatorHelperWidget({
    super.key,
    required this.pass,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PasswordValidatorController());
    controller.validate(pass);
    return Obx(
      () {
        return Column(
          children: [
            ...controller.elements.map((e) {
              final color = e.isCompleted ? green : lightGrey;
              return Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    height: 7,
                    width: 7,
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      e.name,
                      style: e.isCompleted
                          ? TextStyles.w500(14, color).copyWith(
                              decoration: TextDecoration.lineThrough,
                              decorationColor: color,
                            )
                          : TextStyles.w500(14, color),
                    ),
                  )
                ],
              );
            }),
          ],
        );
      },
    );
  }
}
