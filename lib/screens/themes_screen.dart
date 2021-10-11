import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:provider/provider.dart';

import '../providers/language_provider.dart';
import '../providers/theme_provider.dart';
import '../widgets/main_drawer.dart';

class ThemesScreen extends StatelessWidget {
  static const routeName = '/themes';

  final bool fromOnBoarding;

  ThemesScreen({this.fromOnBoarding = false});

  Widget buildRadioListTile(
      ThemeMode themeVal, String txt, IconData? icon, BuildContext ctx) {
    return RadioListTile(
      secondary: Icon(icon, color: Theme.of(ctx).splashColor),
      value: themeVal,
      groupValue: Provider.of<ThemeProvider>(ctx, listen: true).tm,
      onChanged: (newThemeVal) => Provider.of<ThemeProvider>(ctx, listen: false)
          .themeModeChange(newThemeVal),
      title: Text(txt),
    );
  }

  @override
  Widget build(BuildContext context) {
    var lan = Provider.of<LanguageProvider>(context, listen: true);
    return Directionality(
      textDirection: lan.isEn ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        appBar: fromOnBoarding
            ? AppBar(
                backgroundColor: Theme.of(context).canvasColor, elevation: 0)
            : AppBar(
                title: Text(lan.getTexts('theme_appBar_title').toString())),
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.all(20),
              child: Text(lan.getTexts('theme_screen_title').toString(),
                  style: Theme.of(context).textTheme.headline6),
            ),
            Expanded(
              child: ListView(
                children: [
                  Container(
                    padding: EdgeInsets.all(20),
                    child: Text(lan.getTexts('theme_mode_title').toString(),
                        style: Theme.of(context).textTheme.headline6),
                  ),
                  buildRadioListTile(
                      ThemeMode.system,
                      lan.getTexts('System_default_theme').toString(),
                      null,
                      context),
                  buildRadioListTile(
                      ThemeMode.light,
                      lan.getTexts('light_theme').toString(),
                      Icons.wb_sunny_outlined,
                      context),
                  buildRadioListTile(
                      ThemeMode.dark,
                      lan.getTexts('dark_theme').toString(),
                      Icons.nights_stay_outlined,
                      context),
                  buildListTile(context, "primary"),
                  buildListTile(context, "accent"),
                  SizedBox(height: fromOnBoarding ? 80 : 0),
                ],
              ),
            ),
          ],
        ),
        drawer: fromOnBoarding ? null : MainDrawer(),
      ),
    );
  }

  ListTile buildListTile(BuildContext context, txt) {
    var primaryColor =
        Provider.of<ThemeProvider>(context, listen: true).primaryColor;
    var accentColor =
        Provider.of<ThemeProvider>(context, listen: true).accentColor;
    var lan = Provider.of<LanguageProvider>(context, listen: true);

    return ListTile(
      title: Text(
          txt == "primary"
              ? lan.getTexts('primary').toString()
              : lan.getTexts('accent').toString(),
          style: Theme.of(context).textTheme.headline6),
      trailing: CircleAvatar(
          backgroundColor: txt == "primary" ? primaryColor : accentColor),
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext ctx) {
            return AlertDialog(
              elevation: 4,
              titlePadding: const EdgeInsets.all(0.0),
              contentPadding: const EdgeInsets.all(0.0),
              content: SingleChildScrollView(
                child: ColorPicker(
                  pickerColor: txt == "primary"
                      ? Provider.of<ThemeProvider>(ctx, listen: true)
                          .primaryColor
                      : Provider.of<ThemeProvider>(ctx, listen: true)
                          .accentColor,
                  onColorChanged: (newColor) =>
                      Provider.of<ThemeProvider>(context, listen: false)
                          .onChanged(newColor, txt == "primary" ? 1 : 2),
                  colorPickerWidth: 300.0,
                  pickerAreaHeightPercent: 0.7,
                  enableAlpha: false,
                  displayThumbColor: true,
                  showLabel: false,
                ),
              ),
            );
          },
        );
      },
    );
  }
}
