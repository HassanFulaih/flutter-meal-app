import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/language_provider.dart';
import '../providers/theme_provider.dart';
import '../screens/themes_screen.dart';
import '../screens/filters_screen.dart';
import '../screens/tabs_screen.dart';

class MainDrawer extends StatefulWidget {
  @override
  _MainDrawerState createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  Widget buildListTile(
      String title, IconData icon, Function() tapHandler, BuildContext ctx) {
    return ListTile(
      leading: Icon(icon, size: 26, color: Theme.of(ctx).splashColor),
      title: Text(
        title,
        style: TextStyle(
          color: Theme.of(ctx).textTheme.bodyText1!.color,
          fontSize: 24,
          fontFamily: 'RobotoCondensed',
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: tapHandler,
    );
  }

  @override
  Widget build(BuildContext context) {
    var lan = Provider.of<LanguageProvider>(context, listen: true);
    return Directionality(
      textDirection: lan.isEn ? TextDirection.ltr : TextDirection.rtl,
      child: Drawer(
        elevation: 0,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 120,
                width: double.infinity,
                padding: EdgeInsets.all(20),
                alignment:
                    lan.isEn ? Alignment.centerLeft : Alignment.centerRight,
                color: Theme.of(context).colorScheme.secondary,
                child: Text(
                  lan.getTexts('drawer_name').toString(),
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w900,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
              SizedBox(height: 20),
              buildListTile(
                  lan.getTexts('drawer_item1').toString(), Icons.restaurant,
                  () {
                Navigator.of(context)
                    .pushReplacementNamed(TabsScreen.routeName);
              }, context),
              buildListTile(
                  lan.getTexts('drawer_item2').toString(), Icons.settings, () {
                Navigator.of(context)
                    .pushReplacementNamed(FiltersScreen.routeName);
              }, context),
              buildListTile(
                  lan.getTexts('drawer_item3').toString(), Icons.color_lens,
                  () {
                Navigator.of(context)
                    .pushReplacementNamed(ThemesScreen.routeName);
              }, context),
              Divider(
                height: 10,
                color: Colors.black54,
              ),
              SizedBox(height: 10),
              Text(
                lan.getTexts('drawer_switch_title').toString(),
                style: Theme.of(context).textTheme.headline6,
                textAlign: TextAlign.center,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(lan.getTexts('drawer_switch_item2').toString(),
                      style: Theme.of(context).textTheme.headline6),
                  Switch(
                    value: lan.isEn,
                    onChanged: (newValue) {
                      lan.changeLan(newValue);
                      Navigator.of(context).pop();
                    },
                    inactiveTrackColor:
                        Provider.of<ThemeProvider>(context, listen: true).tm ==
                                ThemeMode.light
                            ? null
                            : Colors.black,
                  ),
                  Text(lan.getTexts('drawer_switch_item1').toString(),
                      style: Theme.of(context).textTheme.headline6),
                ],
              ),
              SizedBox(height: 10),
              Divider(
                height: 10,
                color: Colors.black54,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
