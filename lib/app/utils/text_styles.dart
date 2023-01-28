import 'package:flutter/material.dart';

class TextStyles {
  static final TextStyles _styles = TextStyles._internal();

  late Color? _defaultColor;

  factory TextStyles.of(final BuildContext context) {
    _styles._defaultColor = Theme.of(context).textTheme.titleLarge!.color;
    return _styles;
  }
  TextStyles._internal();

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

  TextStyle w400(final double size, [final Color? color]) {
    return _getCopy(size, FontWeight.w400, color ?? _styles._defaultColor!);
  }

  TextStyle w500(final double size, [final Color? color]) {
    return _getCopy(size, FontWeight.w500, color ?? _styles._defaultColor!);
  }

  TextStyle w600(final double size, [final Color? color]) {
    return _getCopy(size, FontWeight.w600, color ?? _styles._defaultColor!);
  }

  TextStyle w700(final double size, [final Color? color]) {
    return _getCopy(size, FontWeight.w700, color ?? _styles._defaultColor!);
  }

  TextStyle w800(final double size, [final Color? color]) {
    return _getCopy(size, FontWeight.w800, color ?? _styles._defaultColor!);
  }

  TextStyle w900(final double size, [final Color? color]) {
    return _getCopy(size, FontWeight.w900, color ?? _styles._defaultColor!);
  }
}
