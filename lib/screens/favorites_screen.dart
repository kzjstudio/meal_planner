import 'package:flutter/material.dart';
import 'package:meal_planner/screens/sign_in_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../providers/firebase_provider.dart';

class FavoritesScreen extends StatefulWidget {
  FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

void delete() async {
  final prefs = await SharedPreferences.getInstance();

  await prefs.remove('favorites');
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  Widget build(BuildContext context) {
    var user = Provider.of<authService>(context);
    print(user.getUser);

    return user.getUser == false ? SignInScreen() : FavScreen();
  }
}

Widget FavScreen() {
  return Scaffold(
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
      onPressed: () {},
      child: Icon(Icons.get_app),
    ),
  );
}
