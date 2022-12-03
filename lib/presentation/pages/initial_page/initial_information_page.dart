import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedulemanager/presentation/controllers/initial_announcements_controller.dart';
import '../../../app/config/constants.dart';
import '../../../app/services/initial_announcements_service.dart';

import 'widgets/widgets.dart';
import '../../../app/utils/responsive_util.dart';

class InitialInformationPage extends GetWidget {
  const InitialInformationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ResponsiveUtil resp = ResponsiveUtil.of(context);
    final InitialAnnouncementsController initialAnnouncementsController =
        Get.find<InitialAnnouncementsController>();
    final InitialAnnouncementsService announcesService =
        Get.find<InitialAnnouncementsService>();

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
                announcements: announcesService.announces.value,
                isLoaded: announcesService.isLoaded.value,
                onNewPageCallback: (newPage) =>
                    initialAnnouncementsController.setNewIndex(newPage),
              ),
            ),
          ),
          // Dots
          Positioned.fill(
            top: resp.hp(95),
            child: Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                    announcesService.announcementsQuantity + 1, (x) {
                  final bool isCurrentPage =
                      x == initialAnnouncementsController.currentIndex.value;
                  final bool isFinalElement =
                      x == announcesService.announcementsQuantity;

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
