import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:meal_planner/models/user.dart';
import 'package:meal_planner/screens/signin_screen.dart';
import 'package:meal_planner/services/auth.dart';
import 'package:meal_planner/widgets/main_drawer.dart';
=======
import 'package:meal_planner/screens/sign_in_screen.dart';
>>>>>>> 8de3b4eb098985d162541d2818f497cdfd90c3f4
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../providers/firebase_provider.dart';

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

final AuthService auth = AuthService();

class _FavoritesScreenState extends State<FavoritesScreen> {
  AuthService uath = AuthService();
  bool haveUser = false;

  void getUser() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        print(user.uid);
        haveUser = true;
      } else {
        haveUser = false;
      }
    });
  }

  @override
  void initState() {
    setState(() {
      getUser();
    });
  }

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    TheUser? user = Provider.of<TheUser?>(context);
    return user != null ? FavScreen() : SigninScreen();
=======
    var user = Provider.of<authService>(context);
    print(user.getUser);

    return user.getUser == false ? SignInScreen() : FavScreen();
>>>>>>> 8de3b4eb098985d162541d2818f497cdfd90c3f4
  }
}

Widget FavScreen() {
  return Scaffold(
<<<<<<< HEAD
    appBar: AppBar(title: Text('Favorites')),
    drawer: MainDrawer(),
=======
>>>>>>> 8de3b4eb098985d162541d2818f497cdfd90c3f4
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
<<<<<<< HEAD
      onPressed: () {
        auth.signout();
      },
=======
      onPressed: () {},
>>>>>>> 8de3b4eb098985d162541d2818f497cdfd90c3f4
      child: Icon(Icons.get_app),
    ),
  );
}
