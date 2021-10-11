import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/meal_detail_screen.dart';
import '../models/meal.dart';
import '../providers/language_provider.dart';

class MealItem extends StatelessWidget {
  final String id;
  final String imageUrl;
  final int duration;
  final Complexity complexity;
  final Affordability affordability;

  const MealItem({
    required this.id,
    required this.imageUrl,
    required this.duration,
    required this.complexity,
    required this.affordability,
  });

  void selectMeal(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(
      MealDetailScreen.routeName,
      arguments: id,
    );
  }

  @override
  Widget build(BuildContext context) {
    var lan = Provider.of<LanguageProvider>(context, listen: true);
    return InkWell(
      onTap: () => selectMeal(context),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 2,
        margin: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        child: Column(
          children: [
            Expanded(
              flex: 7,
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                    child: Hero(
                      tag: id,
                      child: Image.network(imageUrl,
                          width: double.infinity, fit: BoxFit.cover),
                    ),
                  ),
                  Positioned(
                    bottom: 20,
                    right: 10,
                    child: Container(
                      width: 300,
                      color: Colors.black54,
                      padding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                      child: Text(
                        lan.getTexts("meal-$id").toString(),
                        style: TextStyle(fontSize: 26, color: Colors.white),
                        softWrap: true,
                        overflow: TextOverflow.fade,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.schedule,
                            color: Theme.of(context).splashColor),
                        SizedBox(width: 6),
                        if (duration <= 10)
                          Text("$duration " + lan.getTexts("min2").toString()),
                        if (duration > 10)
                          Text("$duration " + lan.getTexts("min").toString()),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.work, color: Theme.of(context).splashColor),
                        SizedBox(width: 6),
                        Text(lan.getTexts('$complexity').toString()),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.attach_money,
                            color: Theme.of(context).splashColor),
                        SizedBox(width: 6),
                        Text(lan.getTexts('$affordability').toString()),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
