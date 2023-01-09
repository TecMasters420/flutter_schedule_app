import 'package:flutter/material.dart';
import 'package:schedulemanager/widgets/custom_header_widget.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
          left: 32,
          right: 32,
          top: 70,
          bottom: 20,
        ),
        child: Column(
          children: const [
            CustomHeaderWidget(title: 'Notifications'),
          ],
        ),
      ),
    );
  }
}
