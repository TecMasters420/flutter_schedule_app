import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedulemanager/app/config/app_constants.dart';
import 'package:schedulemanager/app/utils/text_styles.dart';
import 'package:schedulemanager/modules/navbar/controllers/navbar_controller.dart';
import 'package:schedulemanager/widgets/responsive_container_widget.dart';

import '../app/config/constants.dart';

class CustomNavBarWidget extends StatelessWidget {
  const CustomNavBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final NavBarController navBar = Get.find();
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppConstants.hPadding,
        vertical: AppConstants.bPadding,
      ),
      child: ResponsiveContainerWidget(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 15,
        ),
        child: Obx(
          () {
            return Row(
              children: navBar.elements.map(
                (e) {
                  if (navBar.currentElement.value != null &&
                      navBar.currentElement.value!.route != Get.currentRoute) {
                    final elementFound = navBar.elements.firstWhereOrNull(
                        (route) => '/${route.route}' == Get.currentRoute);
                    if (elementFound != null) {
                      navBar.currentElement.value = elementFound;
                      // navBar.onNewSelection(elementFound);
                    }
                  }
                  final isSelected = navBar.currentElement.value != null &&
                      e.name == navBar.currentElement.value!.name &&
                      '/${navBar.currentElement.value!.route}' ==
                          Get.currentRoute;

                  return Expanded(
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () => navBar.onNewSelection(e),
                        splashColor: accent.withOpacity(0.25),
                        borderRadius: BorderRadius.circular(20),
                        highlightColor: Colors.transparent,
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 150),
                          transitionBuilder: (child, animation) {
                            return ScaleTransition(
                              scale: animation,
                              child: child,
                            );
                          },
                          child: isSelected
                              ? Column(
                                  key: Key(true.toString()),
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(e.icon, size: 25, color: accent),
                                    Text(
                                      e.name,
                                      style: TextStyles.w500(12, accent),
                                    ),
                                  ],
                                )
                              : Column(
                                  key: Key(false.toString()),
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(e.icon, size: 20, color: grey),
                                    Text(
                                      e.name,
                                      style: TextStyles.w500(10, grey),
                                    ),
                                  ],
                                ),
                        ),
                      ),
                    ),
                  );
                },
              ).toList(),
            );
          },
        ),
      ),
    );
  }
}
