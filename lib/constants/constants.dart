import 'package:flutter/material.dart';

//main colors for the app
class ColorsScheme {
  static const Color purple = Color(0xff6200ee);
  static const Color brightPurple = Color(0xffEAE6FC);
  static const Color midPurple = Color(0xffb380ff);
  static const Color grey = Color(0xfff0f2f7);
  static const Color darkGrey = Color(0xffabafc3);
  static const Color blue = Color(0xff4668fd);
  static const Color white = Colors.white;
}

// app bar text style
const appBarTextStyle = TextStyle(color: ColorsScheme.purple, fontSize: 18);

//text stroke
const double offset = 1;
const textBorder = [
  Shadow(
      // bottomLeft
      offset: Offset(-offset, -offset),
      color: ColorsScheme.purple),
  Shadow(
      // bottomRight
      offset: Offset(offset, -offset),
      color: ColorsScheme.purple),
  Shadow(
      // topRight
      offset: Offset(offset, offset),
      color: ColorsScheme.purple),
  Shadow(
      // topLeft
      offset: Offset(-offset, offset),
      color: ColorsScheme.purple),
];
