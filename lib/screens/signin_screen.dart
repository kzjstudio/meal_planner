import 'package:flutter/material.dart';
import 'package:meal_planner/services/auth.dart';
import 'package:meal_planner/widgets/main_drawer.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

final AuthService auth = AuthService();

class _SigninScreenState extends State<SigninScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('Sign-in'),
        elevation: 0,
      ),
      drawer: MainDrawer(),
      body: ClipRRect(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(50), topRight: Radius.circular(50)),
        child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Form(
                    child: Column(children: [
                      SizedBox(
                        height: 200,
                      ),
                      TextFormField(
                        initialValue: 'Email',
                      ),
                    ]),
                  )
                ],
              ),
            )),
      ),
    );
  }
}
