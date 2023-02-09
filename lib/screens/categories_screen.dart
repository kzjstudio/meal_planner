import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:meal_planner/screens/category_meals_screen.dart';
import 'package:meal_planner/widgets/category_item.dart';
import '../dummy_data.dart';

class CatergoriesScreen extends StatefulWidget {
  CatergoriesScreen({super.key});

  @override
  State<CatergoriesScreen> createState() => _CatergoriesScreenState();
}

class _CatergoriesScreenState extends State<CatergoriesScreen> {
  final docRef =
      FirebaseFirestore.instance.collection('meals').doc('Categories');
  final Color color = Colors.orange;

  final colors = const [
    Colors.purple,
    Colors.red,
    Colors.orange,
    Colors.amber,
    Colors.green,
    Colors.lightBlue,
    Colors.lightGreen,
    Colors.pink,
    Colors.teal,
    Colors.amberAccent,
    Colors.cyan,
    Colors.redAccent
  ];

  void selectCategory(BuildContext context, String id, String title) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CatergoryMealScreen(
                  id: id,
                  title: title,
                )));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: docRef.get(),
        builder: ((context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text("Something went wrong");
          }

          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            final listData = data["Category"];

            return GridView.builder(
              itemCount: listData.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    selectCategory(context, listData[index]["id"],
                        listData[index]["title"]);
                  },
                  child: Container(
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          color: colors[index],
                          borderRadius: BorderRadius.circular(15)),
                      child: Text(
                        listData[index]["title"],
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                );
              },
              padding: const EdgeInsets.all(25),
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200.0,
                  childAspectRatio: 3 / 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20),
            );
          }

          return Text("loading");
        }));
  }
}
