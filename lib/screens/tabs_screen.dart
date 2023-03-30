import 'package:flutter/material.dart';
import 'package:meal_planner/providers/firebase_provider.dart';
import 'package:meal_planner/screens/categories_screen.dart';
import 'package:meal_planner/widgets/main_drawer.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
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
