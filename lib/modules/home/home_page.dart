import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedulemanager/app/config/app_constants.dart';
import 'package:schedulemanager/modules/auth/controllers/auth_controller.dart';
import 'package:schedulemanager/widgets/custom_nav_bar_widget.dart';
import 'controllers/home_controller.dart';
import 'widgets/home_header_widget.dart';

import '../../app/utils/responsive_util.dart';

import '../../app/utils/text_styles.dart';
import 'widgets/widgets.dart';

class HomePage extends GetView {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final ResponsiveUtil resp = ResponsiveUtil.of(context);
    final HomeController home = Get.find();
    final AuthController auth = Get.find();

    return Scaffold(
      bottomNavigationBar: const CustomNavBarWidget(),
      body: SingleChildScrollView(
        clipBehavior: Clip.none,
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: AppConstants.bodyPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HomeHeaderWidget(
                name:
                    '${auth.currentUser!.data.name} ${auth.currentUser!.data.lastName}',
                userImage: auth.currentUser!.data.imageUrl ?? '',
              ),
              SizedBox(height: resp.hp(2.5)),
              Text(
                'Statistics',
                style: TextStyles.w700(20),
              ),
              SizedBox(height: resp.hp(2.5)),
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
                () => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Select the event type',
                      style: TextStyles.w700(20),
                    ),
                    SizedBox(height: resp.hp(2.5)),
                    ActivitiesTypes(
                      initialTabIndex: 1,
                      isLoading: home.isLoading.value,
                      eventsPerType: {
                        'Expired': home.expiredEvents,
                        'Today': home.currentEvents,
                        'Upcoming': home.nextEvents,
                      },
                      onTapNew: () async {
                        await home.getFilteredEvents();
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
