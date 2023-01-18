import 'package:flutter/material.dart';

const Color accent = Color(0xff2d76f1);
const Color darkAccent = Color(0xff045cfb);
const Color backgroundColor = Color(0xfff8f6fa);
const Color containerBg = Color(0xffffffff);

const Color black = Color(0xff192252);
const Color grey = Color(0xff9da1af);
const Color lightGrey = Color(0xffb9bfce);

const Color red = Color.fromARGB(255, 207, 89, 93);
const Color orange = Color.fromARGB(255, 244, 145, 99);
const Color green = Color.fromARGB(255, 110, 195, 110);

const LinearGradient accentGradient = LinearGradient(
  colors: [accent, darkAccent],
);

List<BoxShadow> shadows = [
  BoxShadow(
    color: black.withOpacity(0.08),
    blurRadius: 10,
    offset: const Offset(0, 2),
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
