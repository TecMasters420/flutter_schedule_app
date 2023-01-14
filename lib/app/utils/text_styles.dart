import 'package:flutter/material.dart';

import '../config/constants.dart';

class TextStyles {
  static TextStyle _getCopy(
    final double size,
    final FontWeight weight,
    final Color color,
  ) {
    return TextStyle(
      fontFamily: 'OpenSans',
      fontSize: size,
      fontWeight: weight,
      color: color,
    );
  }

  static TextStyle w100(final double size, [final Color color = black]) {
    return _getCopy(size, FontWeight.w100, color);
  }

  static TextStyle w200(final double size, [final Color color = black]) {
    return _getCopy(size, FontWeight.w200, color);
  }

  static TextStyle w300(final double size, [final Color color = black]) {
    return _getCopy(size, FontWeight.w300, color);
  }

  static TextStyle w400(final double size, [final Color color = black]) {
    return _getCopy(size, FontWeight.w400, color);
  }

  static TextStyle w500(final double size, [final Color color = black]) {
    return _getCopy(size, FontWeight.w500, color);
  }

  static TextStyle w600(final double size, [final Color color = black]) {
    return _getCopy(size, FontWeight.w600, color);
  }

  static TextStyle w700(final double size, [final Color color = black]) {
    return _getCopy(size, FontWeight.w700, color);
  }

  static TextStyle w800(final double size, [final Color color = black]) {
    return _getCopy(size, FontWeight.w800, color);
  }

  static TextStyle w900(final double size, [final Color color = black]) {
    return _getCopy(size, FontWeight.w900, color);
  }
}
