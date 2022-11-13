import 'package:flutter/cupertino.dart';

class ResponsiveUtil {
  late final double _height;
  late final double _width;
  // late final double _diagonal;

  double get height => _height;
  double get width => _width;

  ResponsiveUtil({
    required BuildContext context,
  }) {
    final size = MediaQuery.of(context).size;
    _height = size.height;
    _width = size.width;
  }

  factory ResponsiveUtil.of(final BuildContext context) {
    return ResponsiveUtil(context: context);
  }

  double hp(final double percent) => height * (percent / 100);
  double wp(final double percent) => width * (percent / 100);
}
