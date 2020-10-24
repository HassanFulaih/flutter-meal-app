import 'package:flutter/material.dart';
import '../widgets/main_drawer.dart';
import 'package:provider/provider.dart';
import 'package:restaurant/providers/meal_provider.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = '/filters';

  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  Widget buildSwitchListTile(String title, String description,
      bool currentValue, Function updateValue) {
    return SwitchListTile(
      title: Text(title, style: Theme.of(context).textTheme.headline5),
      value: currentValue,
      subtitle: Text(description, style: Theme.of(context).textTheme.headline6),
      onChanged: updateValue,
      inactiveTrackColor: Theme.of(context).shadowColor,
    );
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, bool> currentFilters =
        Provider.of<MealProvider>(context, listen: true).filters;

    return Scaffold(
      appBar: AppBar(title: Text("Your Filters")),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Text("Adjust your meal selection.",
                style: Theme.of(context).textTheme.headline5),
          ),
          Expanded(
            child: ListView(
              children: [
                buildSwitchListTile(
                  'Gluten-free',
                  "Only include gluten-free meals.",
                  currentFilters['gluten'],
                  (newValue) {
                    setState(() {
                      currentFilters['gluten'] = newValue;
                    });
                    Provider.of<MealProvider>(context, listen: false)
                        .setFilters();
                  },
                ),
                buildSwitchListTile(
                  'Lactose-free',
                  "Only include lactose-free meals.",
                  currentFilters['lactose'],
                  (newValue) {
                    setState(() {
                      currentFilters['lactose'] = newValue;
                    });
                    Provider.of<MealProvider>(context, listen: false)
                        .setFilters();
                  },
                ),
                buildSwitchListTile(
                  'Vegetarian',
                  "Only include vegetarian meals.",
                  currentFilters['vegetarian'],
                  (newValue) {
                    setState(() {
                      currentFilters['vegetarian'] = newValue;
                    });
                    Provider.of<MealProvider>(context, listen: false)
                        .setFilters();
                  },
                ),
                buildSwitchListTile(
                  'Vegan',
                  "Only include vegan meals.",
                  currentFilters['vegan'],
                  (newValue) {
                    setState(() {
                      currentFilters['vegan'] = newValue;
                    });
                    Provider.of<MealProvider>(context, listen: false)
                        .setFilters();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
      drawer: MainDrawer(),
    );
  }
}
