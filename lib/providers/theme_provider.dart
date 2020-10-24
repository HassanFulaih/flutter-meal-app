import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  Color currentColor = Colors.blueGrey;
  Color accentColor = Colors.teal[100];

  ThemeMode tm = ThemeMode.system;
  String themeText = "light";

  void onChanged(newColor) async {
    currentColor = newColor;
    _getAccentColor(Color(newColor.value));
    notifyListeners();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt("currentColor", currentColor.value);
  }

  getColor() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var c = prefs.getInt("currentColor") ?? 0xFF607D8B;

    currentColor = MaterialColor(
      c,
      <int, Color>{
        50: Color(c),
        100: Color(c),
        200: Color(c),
        300: Color(c),
        400: Color(c),
        500: Color(c),
        600: Color(c),
        700: Color(c),
        800: Color(c),
        900: Color(c),
      },
    );

    _getAccentColor(Color(c));
  }

  _getAccentColor(Color pColor) {
    if (pColor == Color(0xFF8BC34A) ||
        pColor == Color(0xFFCDDC39) ||
        pColor == Color(0xFFFFEB3B) ||
        pColor == Color(0xFFFFC107) || pColor == Color(0xFFFF9800)) {
      accentColor = Colors.purple;
    } else if (pColor == Color(0xFF03A9F4) ||
        pColor == Color(0xFF00BCD4) ||
        pColor == Color(0xFF4CAF50)) {
      accentColor = Colors.brown;
    } else if (pColor == Color(0xFF9E9E9E)) {
      accentColor = Colors.indigo[700];
    } else if (pColor == Color(0xFF607D8B)) {
      accentColor = Colors.teal[100];
    } else {
      accentColor = Colors.amber;
    }
    notifyListeners();
  }

  void themeModeChange() async {
    if (tm == ThemeMode.dark) {
      tm = ThemeMode.light;
      themeText = "light";
    } else {
      tm = ThemeMode.dark;
      themeText = "dark";
    }
    notifyListeners();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("themeText", themeText);
  }

  getTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    themeText = prefs.getString("themeText");

    if (themeText == null) {
      tm = ThemeMode.system;
      themeText = "system default";
    } else {
      tm = (themeText == "light") ? ThemeMode.light : ThemeMode.dark;
    }

    notifyListeners();
  }
}
