import 'package:flutter/cupertino.dart';

import '../../presentation/enums/devices_enum.dart';

class ResponsiveUtil {
  static final ResponsiveUtil _resp = ResponsiveUtil._internal();
  late double _height;
  late double _width;
  late DeviceType _device;

  double get height => _height;
  double get width => _width;
  DeviceType get device => _device;

  factory ResponsiveUtil.of(final BuildContext context) {
    final size = MediaQuery.of(context).size;
    _resp._height = size.height;
    _resp._width = size.width;
    _resp._device = _resp._width <= 480
        ? DeviceType.phone
        : _resp._width <= 1439
            ? DeviceType.tablet
            : _resp._width > 1439
                ? DeviceType.desktop
                : DeviceType.phone;

    return _resp;
  }

  double hp(final double percent) => _height * (percent / 100);
  double wp(final double percent) => _width * (percent / 100);
  ResponsiveUtil._internal();
}
