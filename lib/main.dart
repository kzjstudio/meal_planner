import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:meal_planner/dummy_data.dart';
import 'package:meal_planner/models/user.dart';
import 'package:meal_planner/screens/favorites_screen.dart';
import 'package:meal_planner/screens/filters_screen.dart';
import 'package:meal_planner/screens/meal_detail_screen.dart';
import 'package:meal_planner/screens/tabs_screen.dart';
import 'package:meal_planner/services/auth.dart';
import 'package:provider/provider.dart';

import 'models/meal.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    "gluten": false,
    "lactose": false,
    "vegan": false,
    "vegetarian": false,
  };

  List<Meal> _availableMeals = DUMMY_MEALS;

  void _setFilters(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;

      _availableMeals = DUMMY_MEALS.where((meal) {
        if (_filters['gluten']! && !meal.isGlutenFree) {
          return false;
        }
        if (_filters['lactose']! && !meal.isLactoseFree) {
          return false;
        }
        if (_filters['vegan']! && !meal.isVegan) {
          return false;
        }
        if (_filters['vegetarian']! && !meal.isVegetarian) {
          return false;
        }

        return true;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamProvider<TheUser?>.value(
      catchError: (_, __) => null,
      initialData: null,
      value: AuthService().user,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Meals App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        // home: const TabsScreen(),
        initialRoute: '/',
        routes: {
          '/': (ctx) => TabsScreen(),
          MealDetailScreen.routName: (context) => MealDetailScreen(
                id: "",
              ),
          FiltersScreen.routeName: (context) =>
              FiltersScreen(_setFilters, _filters),
          FavoritesScreen.routeName: (context) => FavoritesScreen(),
        },
      ),
    );
  }
}
