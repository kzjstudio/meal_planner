import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:meal_planner/dummy_data.dart';
import 'package:meal_planner/widgets/meal_item.dart';
import '../models/meal.dart';

class CatergoryMealScreen extends StatefulWidget {
  static const routName = "/category-meals";
  final String id;
  final String title;
  const CatergoryMealScreen({super.key, required this.title, required this.id});

  @override
  State<CatergoryMealScreen> createState() => _CatergoryMealScreenState();
}

class _CatergoryMealScreenState extends State<CatergoryMealScreen> {
  // const CatergoryMealScreen(
  @override
  Widget build(BuildContext context) {
    final db = FirebaseFirestore.instance;
    final meal = db.collection('meals by id');

    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: FutureBuilder(
          future: meal.get(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text("Something went wrong");
            }

            if (snapshot.connectionState == ConnectionState.done) {
              final data = snapshot.data!.docs;
              final mealToDisplay = data.where((meal) {
                return meal["categories"].contains(widget.id);
              }).toList();

              return ListView.builder(
                  itemCount: mealToDisplay.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: MealItem(
                          id: mealToDisplay[index]["id"],
                          title: mealToDisplay[index]["title"],
                          imageUrl: mealToDisplay[index]["imageUrl"],
                          duration: mealToDisplay[index]["duration"],
                          complexity: mealToDisplay[index]["complexity"],
                          affordability: mealToDisplay[index]["affordability"]),
                    );
                  });
            }

            return Center(
              child: LoadingAnimationWidget.fourRotatingDots(
                  color: Colors.green, size: 50),
            );
          }),
    );
  }
}
