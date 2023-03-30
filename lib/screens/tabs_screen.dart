import 'package:flutter/material.dart';
import 'package:meal_planner/providers/firebase_provider.dart';
import 'package:meal_planner/screens/categories_screen.dart';
import 'package:meal_planner/widgets/main_drawer.dart';
import 'package:provider/provider.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
<<<<<<< HEAD
=======
  late List<Map<String, Object>> _pages;

  @override
  void initState() {
    _pages = [
      {"page": CatergoriesScreen(), "title": "Categories"},
      {"page": FavoritesScreen(), "title": "Favorites"},
    ];
    super.initState();
  }

  int selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      selectedPageIndex = index;
    });
  }

>>>>>>> 8de3b4eb098985d162541d2818f497cdfd90c3f4
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MainDrawer(),
      appBar: AppBar(
        title: const Text('Categories'),
      ),
      body: CatergoriesScreen(),
    );
  }
}
