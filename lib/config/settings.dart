import 'package:flutter/material.dart';

class Settings with ChangeNotifier {
  bool _bIsThemeBlack = false;
  String _uiLocale = 'en';

  bool get isThemeBlack => _bIsThemeBlack;

  String get currentLocale => _uiLocale;

  void setTheme(bool value) {
    _bIsThemeBlack = value;
    notifyListeners();
  }

  void setLocale(String value) {
    _uiLocale = value;
    notifyListeners();
  }
}
