import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:meal_planner/widgets/main_drawer.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/meal_item.dart';

class FavoritesScreen extends StatefulWidget {
  static const routeName = '/favorites';
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

List<String> favoritesRetrived = [];
final db = FirebaseFirestore.instance;
final meal = db.collection('meals by id');

void getFavorites() async {
  final prefs = await SharedPreferences.getInstance();
  final List<String>? favorites = prefs.getStringList('favorites');
  favoritesRetrived.addAll(favorites!);
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  void initState() {
    getFavorites();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Favorites')),
      drawer: const MainDrawer(),
      body: FutureBuilder(
          future: meal.get(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return const Text("Something went wrong");
            }

            if (snapshot.connectionState == ConnectionState.done) {
              final data = snapshot.data!.docs;
              var mealToDisplay;

              for (var id in favoritesRetrived) {
                mealToDisplay =
                    data.where((meal) => meal["title"].contains(id)).toList();
              }

              print(mealToDisplay.isEmpty);

              return mealToDisplay.isEmpty
                  ? Center(
                      child: Text("You need to add favorites"),
                    )
                  : ListView.builder(
                      itemCount: mealToDisplay.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: MealItem(
                              id: mealToDisplay[index]["id"],
                              title: mealToDisplay[index]["title"],
                              imageUrl: mealToDisplay[index]["imageUrl"],
                              duration: mealToDisplay[index]["duration"],
                              complexity: mealToDisplay[index]["complexity"],
                              affordability: mealToDisplay[index]
                                  ["affordability"]),
                        );
                      });
            }

            return Center(
              child: LoadingAnimationWidget.fourRotatingDots(
                  color: Theme.of(context).primaryColor, size: 50),
            );
          }),
    );
  }
}
