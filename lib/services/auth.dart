import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:meal_planner/models/user.dart';

class AuthService with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
// creat user object base on firebase user

  Stream<TheUser> get user {
    return _auth
        .authStateChanges()
        .map((User? user) => (user != null) ? TheUser(uid: user.uid) : null!);
  }

  //signin anon
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  void signout() {
    _auth.signOut();
    notifyListeners();
  }
  // sign in wih email and password
}
