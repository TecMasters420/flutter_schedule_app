import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import '../../../app/utils/responsive_util.dart';

import '../../../app/config/constants.dart';
import '../../../data/models/initial_announcement_model.dart';
import '../../../app/utils/text_styles.dart';
import '../../../routes/app_routes.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_circular_progress.dart';
import 'initial_page_information.dart';

class AnnouncementsList extends StatefulWidget {
  final List<InitialAnnouncementModel> announcements;
  final bool isLoaded;
  final void Function(int newPage) onNewPageCallback;
  const AnnouncementsList({
    super.key,
    required this.announcements,
    required this.isLoaded,
    required this.onNewPageCallback,
  });

  @override
  State<AnnouncementsList> createState() => _AnnouncementsListState();
}

class _AnnouncementsListState extends State<AnnouncementsList> {
  late final PageController _pageController;

  int _currentPage = 0;
  double _pageProgress = 0;

  @override
  void initState() {
    _pageController = PageController(initialPage: _currentPage)
      ..addListener(_pageListener);
    super.initState();
  }

  void _pageListener() {
    setState(() {
      final int newPage = _pageController.page!.round();
      if (newPage != _currentPage) widget.onNewPageCallback(newPage);
      _currentPage = newPage;
      _pageProgress = _pageController.page!;
    });
  }

  @override
  Widget build(BuildContext context) {
    final ResponsiveUtil resp = ResponsiveUtil.of(context);
    final int announcesQuantity = widget.announcements.length;
    return widget.isLoaded
        ? PageView.builder(
            physics: const BouncingScrollPhysics(),
            controller: _pageController,
            itemCount: announcesQuantity + 1,
            itemBuilder: (context, x) {
              final bool isFinalElement = x >= announcesQuantity;
              final InitialAnnouncementModel announce = !isFinalElement
                  ? widget.announcements[x]
                  : const InitialAnnouncementModel(
                      id: 0,
                      title: 'Welcome to\nSchedule App',
                      description: 'Press button to join!',
                      imageUrl: '',
                    );
              final progress = (_pageProgress - x).abs();
              final quantity = 1 - progress;
              final opacity = progress < 0.10 ? 1.0 : 0.05;

              return LoginPageInformation(
                withImage: !isFinalElement,
                scale: quantity,
                opacity: opacity,
                imageUrl: announce.imageUrl,
                title: announce.title,
                description: announce.description,
                extraWidget: !isFinalElement
                    ? CustomButton(
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 20),
                        color: blueAccent,
                        style: TextStyles.w800(16, Colors.white),
                        text: 'Next',
                        expand: true,
                        onTap: () => _pageController.animateToPage(
                          _currentPage + 1,
                          duration: const Duration(milliseconds: 250),
                          curve: Curves.ease,
                        ),
                      )
                    : CustomButton(
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 20),
                        color: blueAccent,
                        style: TextStyles.w800(16, Colors.white),
                        text: 'Join',
                        expand: true,
                        onTap: () => Get.toNamed(AppRoutes.login),
                      ),
              );
            },
          )
        : Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CustomCircularProgress(color: blueAccent),
                SizedBox(height: resp.hp(2)),
                Text(
                  'Loading announcements',
                  style: TextStyles.w800(16),
                ),
              ],
            ),
          );
  }
}
