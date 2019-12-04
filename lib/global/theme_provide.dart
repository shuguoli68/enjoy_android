import 'package:flutter/material.dart';

class ThemeProvide with ChangeNotifier{

  int _themeIndex;

  int get value => _themeIndex;

  ThemeProvide();

  setTheme(int index){
    _themeIndex = index;
    notifyListeners();
  }

}