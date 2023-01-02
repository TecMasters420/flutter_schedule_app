import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedulemanager/modules/initial_page/controllers/announcements_carrousel_controller.dart';
import 'package:schedulemanager/modules/initial_page/controllers/initial_announcements_controller.dart';
import '../../app/config/constants.dart';

import 'widgets/widgets.dart';
import '../../app/utils/responsive_util.dart';

class InitialInformationPage extends GetWidget {
  const InitialInformationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ResponsiveUtil resp = ResponsiveUtil.of(context);
    final AnnouncementsCarrouselController carrouselController = Get.find();
    final InitialAnnouncementsController announcesController = Get.find();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: accent,
      body: Stack(
        children: [
          SizedBox(
            height: resp.height,
            width: resp.width,
            child: Obx(
              () => AnnouncementsList(
                announcements: announcesController.announces,
                isLoaded: !announcesController.isLoading.value,
                onNewPageCallback: (newPage) =>
                    carrouselController.setNewIndex(newPage),
              ),
            ),
          ),
          // Dots
          Positioned.fill(
            top: resp.hp(95),
            child: Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(announcesController.quantity + 1, (x) {
                  final bool isCurrentPage =
                      x == carrouselController.currentIndex.value;
                  final bool isFinalElement = x == announcesController.quantity;

                  return DotIndicator(
                    isFinalElement: isFinalElement,
                    isCurrentPage: isCurrentPage,
                  );
                }),
              ),
            ),
          )
        ],
      ),
    );
  }
}
