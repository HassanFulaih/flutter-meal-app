import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import '../providers/language_provider.dart';
import '../dummy_data.dart';
import '../providers/meal_provider.dart';

class MealDetailScreen extends StatefulWidget {
  static const routeName = 'meal_detail';

  @override
  _MealDetailScreenState createState() => _MealDetailScreenState();
}

class _MealDetailScreenState extends State<MealDetailScreen> {
  Widget buildSectionTitle(BuildContext context, String text) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Text(text, style: Theme.of(context).textTheme.headline6),
    );
  }

  Widget buildContainer(Widget child) {
    bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    var dw = MediaQuery.of(context).size.width;
    var dh = MediaQuery.of(context).size.height;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white70,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.all(15),
      padding: EdgeInsets.all(10),
      height: isLandscape ? dh * 0.5 : dh * 0.25,
      width: isLandscape ? (dw * 0.5 - 30) : dw,
      child: child,
    );
  }

  String mealId = '';

  @override
  void didChangeDependencies() {
    mealId = ModalRoute.of(context)!.settings.arguments as String;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final selectedMeal = DUMMY_MEALS.firstWhere((meal) => meal.id == mealId);
    var accentColor = Theme.of(context).colorScheme.secondary;
    var lan = Provider.of<LanguageProvider>(context, listen: true);

    List<String> stepsLi = lan.getTexts('steps-$mealId') as List<String>;
    var liSteps = ListView.builder(
      itemBuilder: (ctx, index) => Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              child: Text("# ${index + 1}"),
            ),
            title: Text(
              stepsLi[index],
              style: TextStyle(color: Colors.black),
            ),
          ),
          Divider(),
        ],
      ),
      itemCount: stepsLi.length,
    );
    List<String> liIngredientLi =
        lan.getTexts('ingredients-$mealId') as List<String>;
    var liIngredients = ListView.builder(
      itemBuilder: (ctx, index) => Card(
        color: accentColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          child: Text(
            liIngredientLi[index],
            style: TextStyle(
              color:
                  useWhiteForeground(accentColor) ? Colors.white : Colors.black,
            ),
          ),
        ),
      ),
      itemCount: liIngredientLi.length,
    );

    return Directionality(
      textDirection: lan.isEn ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(title: Text(lan.getTexts('meal-$mealId').toString())),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 300,
                width: double.infinity,
                child: Hero(
                    tag: mealId,
                    child: Image.network(selectedMeal.imageUrl,
                        fit: BoxFit.cover)),
              ),
              if (isLandscape)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        buildSectionTitle(
                            context, lan.getTexts('Ingredients').toString()),
                        buildContainer(liIngredients),
                      ],
                    ),
                    Column(
                      children: [
                        buildSectionTitle(
                            context, lan.getTexts('Steps').toString()),
                        buildContainer(liSteps),
                      ],
                    ),
                  ],
                ),
              if (!isLandscape)
                buildSectionTitle(
                    context, lan.getTexts('Ingredients').toString()),
              if (!isLandscape) buildContainer(liIngredients),
              if (!isLandscape)
                buildSectionTitle(context, lan.getTexts('Steps').toString()),
              if (!isLandscape) buildContainer(liSteps),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Provider.of<MealProvider>(context, listen: false)
              .toggleFavorite(mealId),
          child: Icon(
            Provider.of<MealProvider>(context, listen: true).isFavorite(mealId)
                ? Icons.star
                : Icons.star_border,
          ),
        ),
      ),
    );
  }
}
