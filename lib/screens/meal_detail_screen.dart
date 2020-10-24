import 'package:flutter/material.dart';
import '../dummy_data.dart';
import 'package:provider/provider.dart';
import 'package:restaurant/providers/meal_provider.dart';

class MealDetailScreen extends StatefulWidget {
  static const routeName = 'meal_detail';

  @override
  _MealDetailScreenState createState() => _MealDetailScreenState();
}

class _MealDetailScreenState extends State<MealDetailScreen> {
  Widget buildSectionTitle(BuildContext context, String text) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      // ignore: deprecated_member_use
      child: Text(text, style: Theme.of(context).textTheme.title),
    );
  }

  Widget buildContainer(Widget child) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      height: 150,
      width: 300,
      child: child,
    );
  }

  String mealId;

  @override
  void didChangeDependencies() {
    mealId = ModalRoute.of(context).settings.arguments as String;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final selectedMeal = DUMMY_MEALS.firstWhere((meal) => meal.id == mealId);
    var accentColor = Theme.of(context).accentColor;

    return Scaffold(
      appBar: AppBar(title: Text(selectedMeal.title)),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(selectedMeal.imageUrl, fit: BoxFit.cover),
            ),
            buildSectionTitle(context, "Ingredients"),
            buildContainer(ListView.builder(
              itemBuilder: (ctx, index) => Card(
                color: accentColor,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: Text(selectedMeal.ingredients[index],
                      style: TextStyle(
                        color: accentColor==Colors.amber|| accentColor==Colors.teal[100]? Colors.black:Colors.white,
                      )),
                ),
              ),
              itemCount: selectedMeal.ingredients.length,
            )),
            buildSectionTitle(context, "Steps"),
            buildContainer(ListView.builder(
              itemBuilder: (ctx, index) => Column(
                children: [
                  ListTile(
                    leading: CircleAvatar(
                      child: Text("# ${index + 1}"),
                    ),
                    title: Text(selectedMeal.steps[index]),
                  ),
                  Divider(),
                ],
              ),
              itemCount: selectedMeal.steps.length,
            )),
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
    );
  }
}
