import 'package:flutter/material.dart';

final light = ThemeData.light().copyWith(
  primaryColor: Colors.white,
  scaffoldBackgroundColor: Colors.white,
  accentColor: Colors.black,
  // bottomAppBarColor: Colors.grey[300],
  // bottomAppBarColor: Colors.white,
  // primaryColorDark: Colors.white,
);
final dark = ThemeData.dark().copyWith(
  primaryColor: Colors.black,
  scaffoldBackgroundColor: Colors.black,
  accentColor: Colors.white,
  // bottomAppBarColor: Colors.grey[850],
  // bottomAppBarColor: Colors.black,
  // primaryColorDark: Colors.black,
);

class ThemeChanger with ChangeNotifier {
  ThemeData _themeData;

  ThemeChanger(this._themeData);

  getTheme() => _themeData;
  setTheme(ThemeData theme) {
    _themeData = theme;

    notifyListeners();
  }
}
