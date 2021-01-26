import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:herewego/pages/home_page.dart';
import 'package:herewego/pages/signin_page.dart';
import 'package:herewego/services/pref_service.dart';
import 'package:herewego/services/utils_service.dart';

class AuthService {
  static final _auth = FirebaseAuth.instance;

  static signUpUser(BuildContext context,String name, String email, String password) async {
    try {
      final newUser = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      print("User email: " + newUser.user.email + '  user uid: ' + newUser.user.uid);

      if(newUser != null) {
        Pref.saveUserId(newUser.user.uid);
        Navigator.pushReplacementNamed(context, HomePage.id);
      } else {
        Utils.fireToast('Check your information');
      }

    } catch (e) {
      print(e.toString());
    }
  }

  static getCurrentUser() async {
    try{
      final user = await _auth.currentUser();
      print("User email: " + user.email + '  user uid: ' + user.uid);
    } catch (e) {
      print(e.toString());
    }
  }

  static signInUser(BuildContext context, String email, String password) async {
    try {
      var authResult = await _auth.signInWithEmailAndPassword(email: email, password: password);
      final FirebaseUser user = authResult.user;
      print("User email: " + user.email + '  user uid: ' + user.uid);
      if(user != null) {
        Pref.saveUserId(user.uid);
        Navigator.pushReplacementNamed(context, HomePage.id);
      } else {
        Utils.fireToast('Check your email or password');
      }
    } catch(e) {
      print(e.toString());
    }
  }


  // static Future<FirebaseUser> signInUser(BuildContext context, String email, String password) async {
  //   try{
  //     _auth.signInWithEmailAndPassword(email: email, password: password);
  //     final FirebaseUser user = await _auth.currentUser();
  //     print(user.toString());
  //     return user;
  //   } catch (e) {
  //     print(e.toString());
  //   }
  //   return null;
  // }
  //
  // static Future<FirebaseUser> signUpUser(BuildContext context, String name, String email, String password) async {
  //   try{
  //     var authResult = await _auth.createUserWithEmailAndPassword(email: email, password: password);
  //     final FirebaseUser user = authResult.user;
  //     print(user.toString());
  //     return user;
  //   } catch (e) {
  //     print(e.toString());
  //   }
  //   return null;
  // }
  //
  static signOutUser(BuildContext context) {
    _auth.signOut();
    Pref.removeUserId().then((value) => {
      Navigator.pushReplacementNamed(context, SignInPage.id)
    });
  }
}