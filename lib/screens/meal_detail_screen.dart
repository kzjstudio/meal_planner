import 'package:flutter/material.dart';
import 'package:meal_planner/dummy_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MealDetailScreen extends StatelessWidget {
  static const routName = "/MealDetailsscreen";
  MealDetailScreen({
    required this.id,
    super.key,
  });
  final String id;

  late List<String> favoriteList;

  void saveFavoriteMeal(String meal) async {
    String favorites = "favorites";
    final prefs = await SharedPreferences.getInstance();

    if (prefs.containsKey(favorites)) {
      var result = await prefs.getStringList(favorites);
      favoriteList = result as List<String>;
      favoriteList.add(meal);
      await prefs.setStringList(favorites, favoriteList);
      print("Updated");
    } else {
      List<String> list = [];
      list.add(meal);
      await prefs.setStringList('favorites', list);
      print("created");
    }
  }

  Widget buildSectionTitle(BuildContext context, String text) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Text(
        text,
        style: Theme.of(context).textTheme.titleLarge,
      ),
    );
  }

  Widget buildContainer(Widget child) {
    return Container(
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(10)),
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(10),
        height: 200,
        width: double.infinity,
        child: child);
  }

  @override
  Widget build(BuildContext context) {
    final selectedMeal = DUMMY_MEALS.firstWhere((meal) => meal.id == id);

    return Scaffold(
      appBar: AppBar(title: Text("${selectedMeal.title}")),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(
                selectedMeal.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            buildSectionTitle(context, "Ingredients"),
            buildContainer(
              ListView.builder(
                itemBuilder: (context, index) => Card(
                  color: Theme.of(context).colorScheme.secondary,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 5.0, horizontal: 10),
                    child: Text(
                      selectedMeal.ingredients[index],
                    ),
                  ),
                ),
                itemCount: selectedMeal.ingredients.length,
              ),
            ),
            buildSectionTitle(context, "Steps"),
            buildContainer(ListView.builder(
                itemCount: selectedMeal.steps.length,
                itemBuilder: ((context, index) => Column(
                      children: [
                        ListTile(
                          title: Text(selectedMeal.steps[index]),
                          leading:
                              CircleAvatar(child: Text('# ${(index + 1)}')),
                        ),
                        Divider(),
                      ],
                    )))),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          saveFavoriteMeal(selectedMeal.id);
        },
        child: Icon(Icons.star_border),
      ),
    );
  }
}
