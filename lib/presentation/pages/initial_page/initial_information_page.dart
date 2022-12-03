import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../app/config/constants.dart';
import '../../../app/services/initial_announcements_service.dart';

import 'widgets/widgets.dart';
import '../../../app/utils/responsive_util.dart';

class InitialInformationPage extends StatefulWidget {
  const InitialInformationPage({super.key});

  @override
  State<InitialInformationPage> createState() => _InitialInformationPageState();
}

class _InitialInformationPageState extends State<InitialInformationPage> {
  late int _currentPage;
  @override
  void initState() {
    super.initState();
    _currentPage = 0;
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
            child: AnnouncementsList(
              announcements: announcesService.announces,
              isLoaded: announcesService.isLoaded,
              onNewPageCallback: (newPage) {
                setState(() {
                  _currentPage = newPage;
                });
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
