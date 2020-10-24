import 'package:flutter/material.dart';
import 'package:restaurant/screens/theme_screen.dart';
import './screens/filters_screen.dart';
import './screens/tabs_screen.dart';
import './screens/meal_detail_screen.dart';
import './screens/category_meals_screen.dart';
import 'package:provider/provider.dart';
import 'providers/meal_provider.dart';
import 'providers/theme_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<MealProvider>(
          create: (ctx) => MealProvider(),
        ),
        ChangeNotifierProvider<ThemeProvider>(
          create: (ctx) => ThemeProvider(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var currentColor = Provider.of<ThemeProvider>(context).currentColor;
    var accentColor = Provider.of<ThemeProvider>(context).accentColor;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      themeMode: Provider.of<ThemeProvider>(context, listen: true).tm,
      darkTheme: ThemeData(
        primarySwatch: currentColor,
        accentColor: accentColor,
        canvasColor: Color.fromRGBO(14, 22, 33, 1),
        cardColor: Color.fromRGBO(35, 34, 39, 1),
        buttonColor: Colors.white,
        shadowColor: Colors.white60,
        textTheme: ThemeData.light().textTheme.copyWith(
              bodyText1: TextStyle(
                color: Color.fromRGBO(200, 230, 230, 1),
              ),
              headline5: TextStyle(
                fontSize: 20,
                color: Colors.white70,
                fontFamily: 'RobotoCondensed',
                fontWeight: FontWeight.bold,
              ),
              headline6: TextStyle(
                fontSize: 18,
                color: Colors.white70,
                fontFamily: 'RobotoCondensed',
              ),
            ),
      ),
      theme: ThemeData(
        primarySwatch: currentColor,
        accentColor: accentColor,
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        cardColor: Colors.white,
        buttonColor: Colors.black87,
        shadowColor: Colors.black54,
        textTheme: ThemeData.light().textTheme.copyWith(
              bodyText1: TextStyle(
                color: Color.fromRGBO(20, 50, 50, 1),
              ),
              headline5: TextStyle(
                fontSize: 20,
                fontFamily: 'RobotoCondensed',
                fontWeight: FontWeight.bold,
              ),
              headline6: TextStyle(
                fontSize: 18,
                fontFamily: 'RobotoCondensed',
              ),
            ),
      ),
      routes: {
        '/': (ctx) => TabsScreen(),
        CategoryMealsScreen.routeName: (context) => CategoryMealsScreen(),
        MealDetailScreen.routeName: (context) => MealDetailScreen(),
        FiltersScreen.routeName: (context) => FiltersScreen(),
        ThemeScreen.routeName: (context) => ThemeScreen(),
      },
    );
  }
}
