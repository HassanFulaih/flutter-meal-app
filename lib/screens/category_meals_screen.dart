import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/meal.dart';
import '../providers/meal_provider.dart';
import '../widgets/meal_item.dart';
import '/providers/language_provider.dart';

class CategoryMealsScreen extends StatefulWidget {
  static const routeName = 'category_meals';

  @override
  _CategoryMealsScreenState createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  String categoryId = '';
  List<Meal> displayedMeals = <Meal>[];

  @override
  void didChangeDependencies() {
    final List<Meal> availableMeals =
        Provider.of<MealProvider>(context, listen: true).availableMeals;
    final routeArg =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    categoryId = routeArg['id']!;
    displayedMeals = availableMeals.where((meal) {
      return meal.categories.contains(categoryId);
    }).toList();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    var dw = MediaQuery.of(context).size.width;
    var lan = Provider.of<LanguageProvider>(context, listen: true);
    return Directionality(
      textDirection: lan.isEn ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(title: Text(lan.getTexts('cat-$categoryId').toString())),
        body: GridView.builder(
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: dw <= 400 ? 400 : 500,
            childAspectRatio: isLandscape ? dw / (dw * 0.8) : dw / (dw * 0.75),
            crossAxisSpacing: 0,
            mainAxisSpacing: 0,
          ),
          itemBuilder: (ctx, index) {
            return MealItem(
              id: displayedMeals[index].id,
              imageUrl: displayedMeals[index].imageUrl,
              duration: displayedMeals[index].duration,
              complexity: displayedMeals[index].complexity,
              affordability: displayedMeals[index].affordability,
            );
          },
          itemCount: displayedMeals.length,
        ),
      ),
    );
  }
}
