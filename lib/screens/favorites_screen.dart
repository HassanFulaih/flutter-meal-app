import 'package:flutter/material.dart';
import '../widgets/meal_item.dart';
import '../models/meal.dart';
import 'package:provider/provider.dart';
import 'package:restaurant/providers/meal_provider.dart';

class FavoritesScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    final List<Meal> favoriteMeals = Provider.of<MealProvider>(context, listen: true).favoriteMeals;
    if (favoriteMeals.isEmpty) {
      return Center(
        child: Text("You have no favorites yet - start adding some!", style: Theme.of(context).textTheme.headline6),
      );
    } else {
      return ListView.builder(
        itemBuilder: (ctx, index) {
          return MealItem(
            id: favoriteMeals[index].id,
            imageUrl: favoriteMeals[index].imageUrl,
            title: favoriteMeals[index].title,
            duration: favoriteMeals[index].duration,
            complexity: favoriteMeals[index].complexity,
            affordability: favoriteMeals[index].affordability,
          );
        },
        itemCount: favoriteMeals.length,
      );
    }
  }
}
