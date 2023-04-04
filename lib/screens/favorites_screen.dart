import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:meal_planner/models/user.dart';
import 'package:meal_planner/screens/signin_screen.dart';
import 'package:meal_planner/services/auth.dart';
import 'package:meal_planner/widgets/main_drawer.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritesScreen extends StatefulWidget {
  static const routeName = '/favorites';
  FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

List<String> favoritesRetrived = [];
final db = FirebaseFirestore.instance;

void delete() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove('favorites');
}

void getFavorites() async {
  final prefs = await SharedPreferences.getInstance();
  final List<String>? favorites = prefs.getStringList('favorites');
  favoritesRetrived.addAll(favorites!);
  print(favoritesRetrived);
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
      appBar: AppBar(title: Text('Favorites')),
      drawer: MainDrawer(),
      body: Center(
        child: Column(
          children: [
            IconButton(
                onPressed: () {
                  delete();
                },
                icon: Icon(Icons.delete)),
            Text("You have no favorites. Please add some!"),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          auth.signout();
        },
        child: Icon(Icons.get_app),
      ),
    );
  }
}
