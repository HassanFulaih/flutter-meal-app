import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

import '../providers/language_provider.dart';
import './tabs_screen.dart';
import './filters_screen.dart';
import './themes_screen.dart';

class OnBoardingScreen extends StatefulWidget {
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    var primaryColor = Theme.of(context).primaryColor;
    var lan = Provider.of<LanguageProvider>(context, listen: true);
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            children: [
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: ExactAssetImage("assets/images/image.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      width: 300,
                      color: Theme.of(context).shadowColor,
                      padding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                      child: Text(
                        lan.getTexts("drawer_name").toString(),
                        style: Theme.of(context).textTheme.headline4,
                        softWrap: true,
                        overflow: TextOverflow.fade,
                      ),
                    ),
                    Container(
                      width: 350,
                      color: Theme.of(context).shadowColor,
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      margin: EdgeInsets.only(bottom: 20),
                      child: Column(
                        children: [
                          Text(
                            lan.getTexts('drawer_switch_title').toString(),
                            style: Theme.of(context).textTheme.headline5,
                            textAlign: TextAlign.center,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                  lan
                                      .getTexts('drawer_switch_item2')
                                      .toString(),
                                  style: Theme.of(context).textTheme.headline6),
                              Switch(
                                value: lan.isEn,
                                onChanged: (newValue) {
                                  Provider.of<LanguageProvider>(context,
                                          listen: false)
                                      .changeLan(newValue);
                                },
                              ),
                              Text(
                                  lan
                                      .getTexts('drawer_switch_item1')
                                      .toString(),
                                  style: Theme.of(context).textTheme.headline6),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              ThemesScreen(fromOnBoarding: true),
              FiltersScreen(fromOnBoarding: true),
            ],
            onPageChanged: (val) {
              setState(() {
                _currentIndex = val;
              });
            },
          ),
          Indicator(_currentIndex),
          Builder(
            builder: (ctx) => Align(
              alignment: Alignment(0, 0.85),
              child: Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: ElevatedButton(
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(
                        lan.isEn ? EdgeInsets.all(7) : EdgeInsets.all(0)),
                    backgroundColor: MaterialStateProperty.all(primaryColor),
                  ),
                  child: Text(lan.getTexts('start').toString(),
                      style: TextStyle(
                          color: useWhiteForeground(primaryColor)
                              ? Colors.white
                              : Colors.black,
                          fontSize: 25)),
                  onPressed: () async {
                    Navigator.of(ctx)
                        .pushReplacementNamed(TabsScreen.routeName);

                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.setBool('watched', true);
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Indicator extends StatelessWidget {
  final int index;

  Indicator(this.index);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          buildContainer(context, 0),
          buildContainer(context, 1),
          buildContainer(context, 2),
        ],
      ),
    );
  }

  Widget buildContainer(BuildContext ctx, int i) {
    return index == i
        ? Icon(Icons.star, color: Theme.of(ctx).primaryColor)
        : Container(
            margin: EdgeInsets.all(4),
            height: 15,
            width: 15,
            decoration: BoxDecoration(
              color: Theme.of(ctx).colorScheme.secondary,
              shape: BoxShape.circle,
            ),
          );
  }
}
