import 'package:flutter/material.dart';
import 'package:schedulemanager/enums/devices_enum.dart';

class ResponsiveWidget extends StatelessWidget {
  final DeviceType device;
  final Widget? phoneWidget;
  final Widget? tabletWidget;
  final Widget? desktopWidget;
  const ResponsiveWidget({
    super.key,
    required this.device,
    this.phoneWidget,
    this.tabletWidget,
    this.desktopWidget,
  });

  @override
  Widget build(BuildContext context) {
    final Widget? currentWidget = device == DeviceType.phone
        ? phoneWidget
        : device == DeviceType.tablet
            ? tabletWidget
            : device == DeviceType.desktop
                ? desktopWidget
                : phoneWidget;
    print(device);
    return currentWidget ?? const Text('No responsive widget.');
  }
}
