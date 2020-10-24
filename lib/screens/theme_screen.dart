import 'package:flutter/material.dart';
import 'package:restaurant/providers/theme_provider.dart';
import '../widgets/main_drawer.dart';
import 'package:provider/provider.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class ThemeScreen extends StatelessWidget {
  static const routeName = '/themes';

  final List<Color> _defaultColors = [
    Colors.red,
    Colors.pink,
    Colors.purple,
    Colors.deepPurple,
    Colors.indigo,
    Colors.blue,
    Colors.lightBlue,
    Colors.cyan,
    Colors.teal,
    Colors.green,
    Colors.lightGreen,
    Colors.lime,
    Colors.yellow,
    Colors.amber,
    Colors.orange,
    Colors.deepOrange,
    Colors.brown,
    Colors.grey,
    Colors.blueGrey,
  ];

  @override
  Widget build(BuildContext context) {
    var tm = Provider.of<ThemeProvider>(context, listen: true).tm;
    return Scaffold(
      appBar: AppBar(title: Text("Your Themes")),
      body: ListView(
        padding: EdgeInsets.all(15),
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Text("Adjust your theme selection.",
                style: Theme.of(context).textTheme.headline5,
                textAlign: TextAlign.center),
          ),
          SizedBox(height: 20),
          ListTile(
            title: Text("Switch your theme mode",
                style: Theme.of(context).textTheme.headline5),
            subtitle: Text(
                "You are now in ${Provider.of<ThemeProvider>(context, listen: true).themeText} theme",
                style: Theme.of(context).textTheme.headline6),
            trailing: Icon(
                tm == ThemeMode.dark
                    ? Icons.wb_sunny_outlined
                    : Icons.nights_stay_outlined,
                color: Theme.of(context).buttonColor),
            onTap: Provider.of<ThemeProvider>(context, listen: false)
                .themeModeChange,
          ),
          SizedBox(height: 20),
          Container(
            padding: EdgeInsets.all(20),
            child: Text("Choose your primary color",
                style: Theme.of(context).textTheme.headline5),
          ),
          SizedBox(height: 20),
          BlockPicker(
            availableColors: _defaultColors,
            pickerColor:
                Provider.of<ThemeProvider>(context, listen: true).currentColor,
            onColorChanged: (newColor) =>
                Provider.of<ThemeProvider>(context, listen: false)
                    .onChanged(newColor),
            layoutBuilder: (context, colors, child) {
              Orientation orientation = MediaQuery.of(context).orientation;
              return Container(
                width: double.infinity,
                height: orientation == Orientation.portrait ? 400 : 200,
                child: GridView.count(
                  padding: EdgeInsets.all(10),
                  scrollDirection: orientation == Orientation.portrait ? Axis.vertical:Axis.horizontal,
                  crossAxisCount: orientation == Orientation.portrait ? 4 : 2,
                  crossAxisSpacing: 5.0,
                  mainAxisSpacing: 5.0,
                  children: colors.map((Color color) => child(color)).toList(),
                ),
              );
            },
          ),
        ],
      ),
      drawer: MainDrawer(),
    );
  }
}
