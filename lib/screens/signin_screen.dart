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
      appBar: AppBar(title: Text('Sign-in')),
      drawer: MainDrawer(),
      body: TextButton(
        onPressed: () async {
          var result = await auth.signInAnon();
          print(result.uid);
        },
        child: Text('Sign in'),
      ),
      floatingActionButton: TextButton(
        onPressed: () {
          auth.signout();
        },
        child: Text('sign out'),
      ),
    );
  }
}
