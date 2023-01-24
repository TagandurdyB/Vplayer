import 'package:flutter/material.dart';
import '/Model/theme_model.dart';

bool _isLight = false;

class ProviderTheme extends ChangeNotifier {
  void tongleTheme() {
    _isLight = !_isLight;
    notifyListeners();
  }

  bool get isLight => _isLight;

  Color get colorCanvas =>
      isLight ? ThemeModel.lightColorCanves : ThemeModel.darkColorCanves;
  Color get colorAppBarIcon => isLight
      ? ThemeModel.lightColorAppBarIcon
      : ThemeModel.darkColorAppBarIcon;
  Color get colorNavBarUnSelectIcon => isLight
      ? ThemeModel.lightColorNavBarUnIcon
      : ThemeModel.darkColorNavBarUnIcon;
  Color get colorNavBarSelectIcon => isLight
      ? ThemeModel.lightColorNavBarIcon
      : ThemeModel.darkColorNavBarIcon;
  Color get colorText =>
      isLight ? ThemeModel.lightColorText : ThemeModel.darkColorText;
  Color get colorModel =>
      isLight ? ThemeModel.lightColorModel : ThemeModel.darkColorModel;

  TextStyle get styleAppBar =>
      isLight ? ThemeModel().lightStyleAppBar : ThemeModel().darkStyleAppBar;

  Widget get iconMainPlay =>
      isLight ? ThemeModel().lightIconPlay : ThemeModel().darkIconPlay;

  Brightness get brightnessStatusBar =>
      isLight ? ThemeModel.lightBrightness : ThemeModel.darkBrightness;

  Text get titleMainPage =>
      isLight ? ThemeModel.lightMainTitle : ThemeModel.darkMainTitle;
}
