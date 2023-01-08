import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../app/config/constants.dart';
import 'controllers/home_controller.dart';
import 'widgets/home_header_widget.dart';
import '../../widgets/custom_circular_progress.dart';

import '../../app/utils/responsive_util.dart';

import '../../app/utils/text_styles.dart';
import 'widgets/widgets.dart';

class HomePage extends GetView {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final ResponsiveUtil resp = ResponsiveUtil.of(context);
    final HomeController home = Get.find();

    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.only(
                left: 32,
                right: 32,
                top: 50,
                bottom: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: resp.hp(5)),
                  const HomeHeaderWidget(),
                  SizedBox(height: resp.hp(2)),
                  SizedBox(
                    height: resp.hp(20),
                    width: resp.width,
                    child: const HomeActivitiesShow(),
                  ),
                  // Text(
                  //   'Group events:',
                  //   style: TextStyles.w700(20),
                  // ),
                  // SizedBox(height: resp.hp(2.5)),
                  // const GroupEventsListWidget(),
                  SizedBox(height: resp.hp(2.5)),
                  Obx(
                    () => home.isLoading.value
                        ? const CustomCircularProgress(color: accent)
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Select the event type:',
                                style: TextStyles.w700(20),
                              ),
                              SizedBox(height: resp.hp(2.5)),
                              ActivitiesTypes(
                                initialTabIndex: 1,
                                remindersPerType: {
                                  'Expired': home.expiredEvents,
                                  'Today': home.currentEvents,
                                  'Upcoming': home.nextEvents,
                                },
                              ),
                            ],
                          ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
