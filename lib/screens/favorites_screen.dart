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

void delete() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove('favorites');
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  Widget build(BuildContext context) {
    TheUser? user = Provider.of<TheUser?>(context);
    print(user);

    return user != null ? FavScreen() : SigninScreen();
  }
}

Widget FavScreen() {
  AuthService auth = AuthService();
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
