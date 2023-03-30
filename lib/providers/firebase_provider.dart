import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import '../models/user_item.dart';

class authService with ChangeNotifier {
  bool get getUser {
    bool hasUser = false;
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
        hasUser = false;
      } else {
        hasUser = true;
      }
    });
    notifyListeners();
    return hasUser;
  }
}
