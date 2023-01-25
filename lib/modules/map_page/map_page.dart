import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedulemanager/app/config/app_constants.dart';
import 'package:schedulemanager/app/utils/text_styles.dart';
import 'package:schedulemanager/modules/map_page/controller/map_page_controller.dart';
import 'package:schedulemanager/modules/map_page/widgets/map_widget.dart';
import 'package:schedulemanager/widgets/custom_button.dart';
import 'package:schedulemanager/widgets/custom_header_widget.dart';
import 'package:schedulemanager/widgets/loading_widget.dart';
import '../../app/utils/responsive_util.dart';
import '../../app/config/constants.dart';

class MapPage extends StatelessWidget {
  const MapPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ResponsiveUtil resp = ResponsiveUtil.of(context);
    final MapPageController map = Get.find();

    return Scaffold(
      body: Padding(
        padding: AppConstants.bodyPadding,
        child: Obx(
          () {
            if (map.isLoading.value) {
              return SizedBox(
                height:
                    resp.height - AppConstants.tPadding - AppConstants.tPadding,
                child: const LoadingWidget(),
              );
            }
            final address = map.currentLoc.value.address ?? 'No address';
            return Column(
              children: [
                const CustomHeaderWidget(title: 'Select locations'),
                SizedBox(height: resp.hp(2.5)),
                Expanded(
                  flex: 5,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: const MapWidget(),
                  ),
                ),
                SizedBox(height: resp.hp(2.5)),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        address,
                        style: TextStyles.w700(16),
                      ),
                      SizedBox(height: resp.hp(0.5)),
                      Text(
                        '150 m for you',
                        style: TextStyles.w500(14, grey),
                      ),
                      const Spacer(),
                      CustomButton(
                        text: 'Pin to this location',
                        color: accent,
                        expand: true,
                        padding: const EdgeInsets.symmetric(
                          vertical: 20,
                          horizontal: 20,
                        ),
                        prefixWidget: const Icon(
                          Icons.location_on,
                          color: Colors.white,
                        ),
                        style: TextStyles.w800(16, Colors.white),
                        onTap: () {},
                      ),
                    ],
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
