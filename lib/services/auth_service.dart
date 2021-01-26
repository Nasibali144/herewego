import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:herewego/pages/signin_page.dart';
import 'package:herewego/services/pref_service.dart';

class AuthService {
  static final _auth = FirebaseAuth.instance;

  static Future<AuthResult> signUpUser(String name, String email, String password) async {
    try {
      final newUser = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      print(newUser.user.email + '\n' + newUser.user.uid);
      return newUser;
    } catch (e) {
      print(e.toString());
    }
  }

  static Future<FirebaseUser> getCurrentUser() async {
    try{
      final user = await _auth.currentUser();
      if(user != null) {
        print(user.email + '\n' + user.uid);
        return user;
      } else {
        return null;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  static Future<FirebaseUser> signInUser(String email, String password) async {
    try {
      var authResult = await _auth.signInWithEmailAndPassword(email: email, password: password);
      final FirebaseUser user = authResult.user;
      print(user.email + '\n' + user.uid);
      return user;
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