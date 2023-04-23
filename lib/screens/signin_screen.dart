import 'package:flutter/material.dart';
import 'package:meal_planner/services/auth.dart';
import 'package:meal_planner/widgets/main_drawer.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});
  static const routeName = "/signin";

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

final AuthService auth = AuthService();

class _SigninScreenState extends State<SigninScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
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
              padding: const EdgeInsets.all(15.0),
              child: Form(
                child: ListView(children: [
                  const SizedBox(
                    height: 200,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(label: Text('Email')),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(label: Text('Password')),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                          onPressed: () {},
                          child: const Text('Forgot your password?'))
                    ],
                  ),
                  FilledButton(onPressed: () {}, child: Text('Login'))
                ]),
              ),
            )),
      ),
    );
  }
}
