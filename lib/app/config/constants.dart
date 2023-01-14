import 'package:flutter/material.dart';

const Color accent = Color(0xff2d76f1);
const Color darkAccent = Color(0xff045cfb);
const Color backgroundColor = Color(0xfffcfbff);
const Color containerBg = Color.fromARGB(255, 244, 242, 248);

const Color black = Color(0xff192252);
const Color grey = Color(0xff9da1af);
const Color lightGrey = Color(0xffb9bfce);

const Color red = Color(0xffE0144C);

const LinearGradient accentGradient = LinearGradient(
  colors: [accent, darkAccent],
);

List<BoxShadow> shadows = [
  BoxShadow(
    color: black.withOpacity(0.08),
    blurRadius: 24,
    offset: const Offset(0, 8),
  )
];

const List<Color> colors = [
  Colors.red,
  Colors.blue,
  Colors.green,
  Colors.orange,
  Colors.yellow,
  Colors.teal
];
