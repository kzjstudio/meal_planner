import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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
    final displayedMeals = DUMMY_MEALS.where((meal) {
      return meal.categories.contains(widget.id);
    }).toList();
    final docRef =
        FirebaseFirestore.instance.collection('meals').doc('meals by category');
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: FutureBuilder(
          future: docRef.get(),
          builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text("Something went wrong");
            }
            if (snapshot.connectionState == ConnectionState.done) {
              Map<String, dynamic> data =
                  snapshot.data!.data() as Map<String, dynamic>;
              final listdata = data["meal"];
              return ListView.builder(
                itemBuilder: (context, index) {
                  return MealItem(
                      id: listdata[index]["id"],
                      title: listdata[index]["title"],
                      imageUrl: listdata[index]["imageUrl"],
                      duration: listdata[index]["duration"],
                      complexity: listdata[index]["complexity"],
                      affordability: listdata[index]["affordability"]);
                },
                itemCount: displayedMeals.length,
              );
            }

            return Text("loading");
          }),
    );
  }
}
