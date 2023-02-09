import 'package:flutter/material.dart';
import 'package:meal_planner/models/meal.dart';
import 'package:meal_planner/screens/meal_detail_screen.dart';

class MealItem extends StatelessWidget {
  const MealItem({
    super.key,
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.duration,
    required this.complexity,
    required this.affordability,
  });

  final String id;
  final String title;
  final String imageUrl;
  final int duration;
  final String complexity;
  final String affordability;

  // String get complexityText {
  //   switch (complexity) {
  //     case Complexity.Simple:
  //       return "simple";
  //       break;
  //     case Complexity.Challenging:
  //       return "Challenging";
  //       break;
  //     case Complexity.Hard:
  //       return "Hard";
  //       break;
  //     default:
  //       return "Unknown";
  //   }
  // }

  // String get afforabilityText {
  //   switch (affordability) {
  //     case Affordability.Afforable:
  //       return "Affordable";
  //       break;
  //     case Affordability.Pricey:
  //       return "Pricey";
  //       break;
  //     case Affordability.Luxurious:
  //       return "Expensive";
  //       break;
  //     default:
  //       return "Unknown";
  //   }
  // }

  void selectMeal(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(
            builder: (context) => MealDetailScreen(
                  id: id,
                )))
        .then((result) {
      print(result);
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        selectMeal(context);
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 4,
        margin: EdgeInsets.all(10),
        child: Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15)),
                  child: Image.network(
                    imageUrl,
                    height: 250,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  bottom: 20,
                  right: 10,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                    color: Colors.black54,
                    width: 300,
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: 26,
                        color: Colors.white,
                      ),
                      softWrap: true,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      Icon(Icons.schedule),
                      SizedBox(
                        width: 6,
                      ),
                      Text('$duration min'),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.work),
                      SizedBox(
                        width: 6,
                      ),
                      Text(complexity),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.attach_money),
                      SizedBox(
                        width: 6,
                      ),
                      Text(affordability),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
