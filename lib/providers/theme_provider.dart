import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  var primaryColor = Colors.pink;
  var accentColor = Colors.amber;

  var tm = ThemeMode.system;
  String themeText = "s";

  onChanged(newColor, n) async {
    n == 1
        ? primaryColor = _toMaterialColor(newColor.hashCode)
        : accentColor = _toMaterialColor(newColor.hashCode);
    notifyListeners();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt("primaryColor", primaryColor.value);
    prefs.setInt("accentColor", accentColor.value);
  }

  getThemeColors() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    primaryColor = _toMaterialColor(prefs.getInt("primaryColor") ?? 0xFFE91E63);
    accentColor = _toMaterialColor(prefs.getInt("accentColor") ?? 0xFFFFC107);
    notifyListeners();
  }

  MaterialColor _toMaterialColor(colorVal) {
    return MaterialColor(
      colorVal,
      <int, Color>{
        50: Color(0xFFFCE4EC),
        100: Color(0xFFF8BBD0),
        200: Color(0xFFF48FB1),
        300: Color(0xFFF06292),
        400: Color(0xFFEC407A),
        500: Color(colorVal),
        600: Color(0xFFD81B60),
        700: Color(0xFFC2185B),
        800: Color(0xFFAD1457),
        900: Color(0xFF880E4F),
      },
    );
  }

  void themeModeChange(newThemeVal) async {
    tm = newThemeVal;
    _getThemeText(tm);
    notifyListeners();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("themeText", themeText);
  }

  _getThemeText(ThemeMode tm) {
    if (tm == ThemeMode.dark)
      themeText = "d";
    else if (tm == ThemeMode.light)
      themeText = "l";
    else if (tm == ThemeMode.system) themeText = "s";
  }

  getThemeMode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    themeText = prefs.getString("themeText") ?? "s";
    if (themeText == "d")
      tm = ThemeMode.dark;
    else if (themeText == "l")
      tm = ThemeMode.light;
    else if (themeText == "s") tm = ThemeMode.system;
    notifyListeners();
  }
}
