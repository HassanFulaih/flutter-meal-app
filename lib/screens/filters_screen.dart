import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/language_provider.dart';
import '../providers/meal_provider.dart';
import '../providers/theme_provider.dart';
import '../widgets/main_drawer.dart';

class FiltersScreen extends StatelessWidget {
  static const routeName = '/filters';

  final bool fromOnBoarding;

  FiltersScreen({this.fromOnBoarding = false});

  Widget buildSwitchListTile(String title, String description,
      bool currentValue, Function updateValue, BuildContext ctx) {
    return SwitchListTile(
      title: Text(title),
      value: currentValue,
      subtitle: Text(description),
      onChanged: updateValue,
      inactiveTrackColor:
          Provider.of<ThemeProvider>(ctx, listen: true).tm == ThemeMode.light
              ? null
              : Colors.black,
    );
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, bool> currentFilters =
        Provider.of<MealProvider>(context, listen: true).filters;
    var lan = Provider.of<LanguageProvider>(context, listen: true);
    return Directionality(
      textDirection: lan.isEn ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        appBar: fromOnBoarding
            ? AppBar(
                backgroundColor: Theme.of(context).canvasColor, elevation: 0)
            : AppBar(title: Text(lan.getTexts('filters_appBar_title'))),
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.all(20),
              child: Text(lan.getTexts('filters_screen_title'),
                  style: Theme.of(context).textTheme.headline6),
            ),
            Expanded(
              child: ListView(
                children: [
                  buildSwitchListTile(
                    lan.getTexts('Gluten-free'),
                    lan.getTexts('Gluten-free-sub'),
                    currentFilters['gluten'],
                    (newValue) {
                      currentFilters['gluten'] = newValue;
                      Provider.of<MealProvider>(context, listen: false)
                          .setFilters();
                    },
                    context,
                  ),
                  buildSwitchListTile(
                    lan.getTexts('Lactose-free'),
                    lan.getTexts('Lactose-free_sub'),
                    currentFilters['lactose'],
                    (newValue) {
                      currentFilters['lactose'] = newValue;

                      Provider.of<MealProvider>(context, listen: false)
                          .setFilters();
                    },
                    context,
                  ),
                  buildSwitchListTile(
                    lan.getTexts('Vegetarian'),
                    lan.getTexts('Vegetarian-sub'),
                    currentFilters['vegetarian'],
                    (newValue) {
                      currentFilters['vegetarian'] = newValue;
                      Provider.of<MealProvider>(context, listen: false)
                          .setFilters();
                    },
                    context,
                  ),
                  buildSwitchListTile(
                    lan.getTexts('Vegan'),
                    lan.getTexts('Vegan-sub'),
                    currentFilters['vegan'],
                    (newValue) {
                      currentFilters['vegan'] = newValue;
                      Provider.of<MealProvider>(context, listen: false)
                          .setFilters();
                    },
                    context,
                  ),
                ],
              ),
            ),
            SizedBox(height: fromOnBoarding ? 80 : 0),
          ],
        ),
        drawer: fromOnBoarding ? null : MainDrawer(),
      ),
    );
  }
}
