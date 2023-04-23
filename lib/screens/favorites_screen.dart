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

class _FavoritesScreenState extends State<FavoritesScreen> {
  List<String> favoritesRetrived = [];
  List<Map<String, dynamic>> tempList = [];

  late List<Map<String, dynamic>> mealToDisplay;
  bool isLoaded = false;

  void getFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? favorites = prefs.getStringList('favorites');
    favoritesRetrived.addAll(favorites!);
  }

  _displayData() async {
    final db = FirebaseFirestore.instance.collection('meals by id');
    List<Map<String, dynamic>> newList = [];
    var data = await db.get();
    data.docs.forEach((element) {
      tempList.add(element.data());
    });
    setState(() {
      mealToDisplay = newList;
      isLoaded = true;
    });
  }

  @override
  void initState() {
    getFavorites();
    _displayData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Favorites')),
        drawer: const MainDrawer(),
        body: !isLoaded
            ? Center(
                child: const Text("You need to add favorites"),
              )
            : ListView.builder(
                itemCount: mealToDisplay.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: MealItem(
                        id: mealToDisplay[index]['id'],
                        title: mealToDisplay[index]["title"],
                        imageUrl: mealToDisplay[index]["imageUrl"],
                        duration: mealToDisplay[index]["duration"],
                        complexity: mealToDisplay[index]["complexity"],
                        affordability: mealToDisplay[index]["affordability"]),
                  );
                }));
  }
}
