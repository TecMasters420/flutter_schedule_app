import 'package:flutter/material.dart';
import 'package:schedulemanager/constants/constants.dart';
import 'package:schedulemanager/utils/text_styles.dart';
import 'package:schedulemanager/widgets/custom_button.dart';
import 'package:schedulemanager/widgets/login_page_information.dart';

import '../utils/responsive_util.dart';
import '../widgets/dot_indicator.dart';

class InitialInformationPage extends StatefulWidget {
  const InitialInformationPage({super.key});

  @override
  State<InitialInformationPage> createState() => _InitialInformationPageState();
}

class _InitialInformationPageState extends State<InitialInformationPage> {
  static const int _elements = 4;

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
              itemCount: _elements,
              itemBuilder: (context, x) {
                final bool isFinalElement = x == _elements - 1;
                final double scale = (x - _pageProgress).abs() < 0.2 ? 1 : 0.9;
                final double opacity =
                    (x - _pageProgress).abs() < 0.2 ? 1 : 0.25;

                return LoginPageInformation(
                  withImage: !isFinalElement,
                  scale: scale,
                  opacity: opacity,
                  title: 'New Scheduling and routing options',
                  description:
                      'We also updated the format of podcasts and rewards.',
                  extraWidget: !isFinalElement
                      ? null
                      : Column(
                          children: [
                            SizedBox(height: resp.hp(1)),
                            CustomButton(
                              color: tempAccent,
                              height: resp.hp(5),
                              style:
                                  TextStyles.w800(resp.dp(1.25), Colors.white),
                              width: resp.wp(40),
                              text: 'Join',
                              onTap: () => Navigator.pushReplacementNamed(
                                context,
                                'loginPage',
                              ),
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
              children: List.generate(_elements, (x) {
                final bool isCurrentPage = x == _currentPage;
                final bool isFinalElement = x == _elements - 1;

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
