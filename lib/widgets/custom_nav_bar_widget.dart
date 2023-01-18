import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:schedulemanager/app/utils/text_styles.dart';
import 'package:schedulemanager/modules/navbar/controllers/navbar_controller.dart';

import '../app/config/constants.dart';

class CustomNavBarWidget extends StatelessWidget {
  const CustomNavBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final NavBarController navBar = Get.find();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Container(
        padding: const EdgeInsets.only(
          top: 15,
          bottom: 15,
          right: 15,
          left: 15,
        ),
        decoration: BoxDecoration(
          color: containerBg,
          boxShadow: shadows,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Obx(
          () => Row(
            children: navBar.elements.map(
              (e) {
                final isSelected = navBar.currentElement.value != null &&
                    e.name == navBar.currentElement.value!.name;
                final color = isSelected ? accent : grey;
                return Expanded(
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () => navBar.onNewSelection(e),
                      splashColor: accent.withOpacity(0.25),
                      borderRadius: BorderRadius.circular(20),
                      highlightColor: Colors.transparent,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(e.icon,
                              size: isSelected ? 25 : 20, color: color),
                          Text(
                            e.name,
                            style: !isSelected
                                ? TextStyles.w500(10, color)
                                : TextStyles.w700(12, accent),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ).toList(),
          ),
        ),
      ),
    );
  }
}
