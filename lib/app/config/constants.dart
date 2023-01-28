import 'package:flutter/material.dart';

const Color blueAccent = Color(0xff1253fe);
const Color darkBlueAccent = Color(0xff4085e6);
const Color darkAccent = Color(0xff1e1e1e);

const Color backgroundColor = Color(0xfff9f9fb);
const Color backgroundColorDark = Color(0xff1e1d22);
const Color textTitleColor = Color.fromARGB(255, 215, 215, 219);
const Color containerBg = Color(0xffffffff);
const Color containerBgDark = Color(0xff1f2123);

const Color black = Color(0xff192252);
const Color grey = Color(0xff9da1af);
const Color lightGrey = Color(0xffb9bfce);
const Color lightBlue = Color(0xffebf2ff);
const Color darkBlue = Color(0xff84acfa);

const Color red = Color(0xfff15556);
const Color orange = Color(0xfffb9b10);
const Color purple = Color(0xffb080ed);
const Color salmon = Color(0xfffa8989);
const Color green = Color.fromARGB(255, 76, 192, 112);

const LinearGradient accentGradient = LinearGradient(
  colors: [blueAccent, darkBlueAccent],
);

List<BoxShadow> shadows = [
  BoxShadow(
    color: black.withOpacity(0.05),
    blurRadius: 20,
    offset: const Offset(0, 0),
  )
];

const List<Color> colors = [
  red,
  blueAccent,
  green,
  orange,
  Colors.yellow,
  Colors.teal
];

const List<Color> colorsForBgs = [
  Color(0xff4697f6),
  Color(0xff52c635),
  salmon,
  orange,
  Color(0xffa5b0ba),
  purple
];
