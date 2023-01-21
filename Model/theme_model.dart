import 'package:flutter/material.dart';
import '/ViewModel/screen_values.dart';

class ThemeModel {
  /*colors=======================================*/
  //light//
  static const Color lightColorCanves = Colors.white;
  static const Color lightColorAppBarIcon = Color(0xff7163DF);
  static const Color lightColorNavBarUnIcon = Color.fromARGB(255, 97, 97, 97);
  static const Color lightColorNavBarIcon = Color(0xffC944F6);
  static const Color lightColorText = Colors.black;
  static const Color lightColorModel = Color(0xffF6F2FA);
  //dark//
  static const Color darkColorCanves = Color.fromARGB(255, 77, 75, 75);
  static const Color darkColorAppBarIcon = Colors.white;
  static const Color darkColorNavBarUnIcon = Colors.white;
  static const Color darkColorNavBarIcon = Color(0xff6A00FF);
  static const Color darkColorText = Colors.white;
  static const Color darkColorModel = Color(0xff1A0B6C);
  /*styles=======================================*/
  //light//
  TextStyle lightStyleAppBar =
      TextStyle(color: lightColorText, fontSize: Screen().width * 0.1);
  //dark//
  TextStyle darkStyleAppBar =
      TextStyle(color: darkColorText, fontSize: Screen().width * 0.1);
  /*Icons========================================*/
  //light//
  Widget lightIconPlay = CircleAvatar(
      backgroundColor: Colors.white38,
      radius: Screen().width * 0.1,
      child: Icon(
        Icons.play_arrow,
        color: Colors.black,
        size: Screen().width * 0.2,
      ));
  //dark//
  Widget darkIconPlay = CircleAvatar(
      backgroundColor: Colors.white38,
      radius: Screen().width * 0.1,
      child: Icon(
        Icons.play_arrow,
        color: Colors.black,
        size: Screen().width * 0.2,
      ));
  /*brightness===================================*/
  static const Brightness lightBrightness = Brightness.dark;
  static const Brightness darkBrightness = Brightness.light;
}
