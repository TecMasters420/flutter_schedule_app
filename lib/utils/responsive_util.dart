import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:schedulemanager/enums/devices_enum.dart';

class ResponsiveUtil {
  static final ResponsiveUtil _resp = ResponsiveUtil._internal();
  late double _height;
  late double _width;
  late double _diagonal;
  late DeviceType _device;

  double get height => _height;
  double get width => _width;
  DeviceType get device => _device;

  // Font sizes
  double get sp40 => dp(4.0); // Big titles
  double get sp30 => dp(3.0); // Middle titles
  double get sp20 => dp(2.0); // Page titles
  double get sp16 => dp(1.6); // Data titles
  double get sp14 => dp(1.4); // Body

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

    _resp._diagonal = sqrt((pow(_resp._height, 2) + pow(_resp._width, 2)));
    return _resp;
  }

  double hp(final double percent) => _height * (percent / 100);
  double wp(final double percent) => _width * (percent / 100);
  double dp(final double percent) => _diagonal * (percent / 100);
  ResponsiveUtil._internal();
}

class Singleton {
  static final Singleton _singleton = Singleton._internal();

  factory Singleton() {
    return _singleton;
  }

  Singleton._internal();
}
