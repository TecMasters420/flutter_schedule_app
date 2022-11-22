import 'package:flutter/material.dart';
import '../../../utils/responsive_util.dart';

import '../../../constants/constants.dart';
import '../../../models/initial_announcement_model.dart';
import '../../../utils/text_styles.dart';
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
      if (newPage != _currentPage) {
        widget.onNewPageCallback(newPage);
      }
      _currentPage = newPage;
      _pageProgress = _pageController.page!;
    });
  }

  @override
  Widget build(BuildContext context) {
    final ResponsiveUtil resp = ResponsiveUtil.of(context);
    final int announcesQuantity = widget.announcements.length;
    return PageView.builder(
      physics: const BouncingScrollPhysics(),
      controller: _pageController,
      itemCount: announcesQuantity + 1,
      itemBuilder: (context, x) {
        final bool isFinalElement = x >= announcesQuantity;
        final InitialAnnouncementModel announce = !isFinalElement
            ? widget.announcements[x]
            : const InitialAnnouncementModel(
                title: 'Welcome!',
                subtitle: 'Press button to join!',
                imageUrl: '',
              );
        final double scale = (x - _pageProgress).abs() < 0.2 ? 1 : 0.9;
        final double opacity = (x - _pageProgress).abs() < 0.2 ? 1 : 0.25;

        return widget.isLoaded
            ? LoginPageInformation(
                withImage: !isFinalElement,
                scale: scale,
                opacity: opacity,
                imageUrl: announce.imageUrl,
                title: announce.title,
                description: announce.subtitle,
                extraWidget: !isFinalElement
                    ? null
                    : Column(
                        children: [
                          SizedBox(height: resp.hp(1)),
                          CustomButton(
                            color: tempAccent,
                            height: resp.hp(5),
                            style: TextStyles.w800(resp.sp14, Colors.white),
                            width: resp.wp(40),
                            text: 'Join',
                            onTap: () => Navigator.pushReplacementNamed(
                              context,
                              'loginPage',
                            ),
                          ),
                        ],
                      ),
              )
            : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CustomCircularProgress(),
                    SizedBox(height: resp.hp(2)),
                    Text(
                      'Loading announcements',
                      style: TextStyles.w800(resp.sp16, Colors.white),
                    ),
                  ],
                ),
              );
      },
    );
  }
}
