import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:schedulemanager/enums/devices_enum.dart';

// ! Breakpoints
// xs: < 576
// sm: >= 576
// md: >= 768
// lg: >= 992
// xl: >= 1200
// xxl: >= 1400

class ResponsiveUtil {
  late final double _height;
  late final double _width;
  late final double _diagonal;
  late final DeviceType _device;

  double get height => _height;
  double get width => _width;
  DeviceType get device => _device;

  ResponsiveUtil({
    required BuildContext context,
  }) {
    final size = MediaQuery.of(context).size;
    _height = size.height;
    _width = size.width;
    _device = _width <= 480
        ? DeviceType.phone
        : _width <= 1439
            ? DeviceType.tablet
            : _width > 1439
                ? DeviceType.desktop
                : DeviceType.phone;

    print(_width);

    _diagonal = sqrt((pow(_height, 2) + pow(_width, 2)));
  }

  factory ResponsiveUtil.of(final BuildContext context) {
    return ResponsiveUtil(context: context);
  }

  double hp(final double percent) => _height * (percent / 100);
  double wp(final double percent) => _width * (percent / 100);
  double dp(final double percent) => _diagonal * (percent / 100);
}
