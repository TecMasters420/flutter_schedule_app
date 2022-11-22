import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../constants/constants.dart';
import '../../models/initial_announcement_model.dart';
import '../../services/initial_announcements_service.dart';
import '../../utils/text_styles.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_circular_progress.dart';

import 'widgets/widgets.dart';
import '../../utils/responsive_util.dart';

class InitialInformationPage extends StatefulWidget {
  const InitialInformationPage({super.key});

  @override
  State<InitialInformationPage> createState() => _InitialInformationPageState();
}

class _InitialInformationPageState extends State<InitialInformationPage> {
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
      _currentPage = _pageController.page!.round();
      _pageProgress = _pageController.page!;
    });
  }

  @override
  Widget build(BuildContext context) {
    final ResponsiveUtil resp = ResponsiveUtil.of(context);
    final InitialAnnouncementsService announcesService =
        Provider.of<InitialAnnouncementsService>(context);
    final int announcesQuantity = announcesService.announces.length;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: accent,
      body: Stack(
        children: [
          SizedBox(
            height: resp.height,
            width: resp.width,
            child: PageView.builder(
              physics: const BouncingScrollPhysics(),
              controller: _pageController,
              itemCount: announcesQuantity + 1,
              itemBuilder: (context, x) {
                final bool isFinalElement = x >= announcesQuantity;
                final InitialAnnouncementModel announce = !isFinalElement
                    ? announcesService.announces[x]
                    : const InitialAnnouncementModel(
                        title: 'Welcome!',
                        subtitle: 'Press button to join!',
                        imageUrl: '',
                      );
                final double scale = (x - _pageProgress).abs() < 0.2 ? 1 : 0.9;
                final double opacity =
                    (x - _pageProgress).abs() < 0.2 ? 1 : 0.25;

                return announcesService.isLoaded
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
                                    style: TextStyles.w800(
                                        resp.sp14, Colors.white),
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
            ),
          ),
          // Dots
          Positioned.fill(
            top: resp.hp(95),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(announcesQuantity + 1, (x) {
                final bool isCurrentPage = x == _currentPage;
                final bool isFinalElement = x == announcesQuantity;

                return DotIndicator(
                  isFinalElement: isFinalElement,
                  isCurrentPage: isCurrentPage,
                );
              }),
            ),
          )
        ],
      ),
    );
  }
}
