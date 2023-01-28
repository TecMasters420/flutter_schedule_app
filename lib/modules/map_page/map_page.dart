import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedulemanager/app/config/app_constants.dart';
import 'package:schedulemanager/app/utils/text_styles.dart';
import 'package:schedulemanager/data/models/event_location_model.dart';
import 'package:schedulemanager/modules/map_page/controller/map_page_controller.dart';
import 'package:schedulemanager/modules/map_page/widgets/map_widget.dart';
import 'package:schedulemanager/widgets/custom_button.dart';
import 'package:schedulemanager/widgets/custom_header_widget.dart';
import 'package:schedulemanager/widgets/loading_widget.dart';
import '../../app/utils/responsive_util.dart';
import '../../app/config/constants.dart';

class MapPage extends StatelessWidget {
  final EventLocationModel? startLoc;
  final EventLocationModel? endLoc;
  const MapPage({
    super.key,
    this.startLoc,
    this.endLoc,
  });

  @override
  Widget build(BuildContext context) {
    final ResponsiveUtil resp = ResponsiveUtil.of(context);
    final MapPageController map = Get.find();
    map.setLocations(startLoc, endLoc);

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
                      Expanded(
                        child: Text(
                          'Start address: ',
                          style: TextStyles.w700(16),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(height: resp.hp(0.5)),
                      Flexible(
                        child: Text(
                          '150 m for you',
                          style: TextStyles.w500(14, grey),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const Spacer(),
                      CustomButton(
                        text: 'Pin to this location',
                        color: blueAccent,
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
