import 'package:flutter/material.dart';
import 'package:restaurant/screens/theme_screen.dart';
import '../screens/filters_screen.dart';

class MainDrawer extends StatelessWidget {
  Widget buildListTile(String title, IconData icon, Function tapHandler, BuildContext ctx) {
    return ListTile(
      leading: Icon(icon, size: 26, color: Theme.of(ctx).buttonColor),
      title: Text(
        title,
        style: TextStyle(
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
    return Drawer(
      child: Column(
        children: [
          Container(
            height: 120,
            width: double.infinity,
            padding: EdgeInsets.all(20),
            alignment: Alignment.centerLeft,
            color: Theme.of(context).accentColor,
            child: Text(
              'Cooking Up!',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w900,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
          SizedBox(height: 20),
          buildListTile("Meal", Icons.restaurant, () {
            Navigator.of(context).pushReplacementNamed('/');
          }, context),
          buildListTile("Filters", Icons.settings, () {
            Navigator.of(context).pushReplacementNamed(FiltersScreen.routeName);
          }, context),
          buildListTile("Themes", Icons.color_lens, () {
            Navigator.of(context).pushReplacementNamed(ThemeScreen.routeName);
          }, context),
        ],
      ),
    );
  }
}
