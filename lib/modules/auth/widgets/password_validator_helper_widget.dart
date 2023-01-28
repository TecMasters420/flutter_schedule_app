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

  Widget _getDot(final Color color) {
    return Container(
      height: 7,
      width: 7,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final styles = TextStyles.of(context);
    final controller = Get.put(PasswordValidatorController());
    controller.validate(pass);
    return Obx(
      () {
        return Column(
          children: [
            ...controller.elements.map(
              (e) {
                return AnimatedSwitcher(
                  duration: const Duration(milliseconds: 250),
                  child: e.isCompleted
                      ? Row(
                          key: Key(true.toString()),
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            _getDot(green),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                e.name,
                                style: styles.w700(14, green).copyWith(
                                      decoration: TextDecoration.lineThrough,
                                      decorationColor: green,
                                    ),
                              ),
                            )
                          ],
                        )
                      : Row(
                          key: Key(false.toString()),
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            _getDot(lightGrey),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                e.name,
                                style: styles.w500(14, lightGrey),
                              ),
                            )
                          ],
                        ),
                  transitionBuilder: (child, animation) {
                    return ScaleTransition(
                      scale: animation,
                      child: child,
                    );
                  },
                );
              },
            ),
          ],
        );
      },
    );
  }
}
