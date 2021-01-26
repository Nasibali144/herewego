import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:herewego/pages/detail_page.dart';
import 'package:herewego/pages/home_page.dart';
import 'package:herewego/pages/signin_page.dart';
import 'package:herewego/pages/signup_page.dart';
import 'package:herewego/services/pref_service.dart';

void main() {
  runApp(MyApp());
}



class MyApp extends StatelessWidget {

  static final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();

  Widget _startPage() {
    return StreamBuilder(
      stream: FirebaseAuth.instance.onAuthStateChanged,
      builder: (BuildContext context, snapshot) {
        if(snapshot.hasData) {
          Pref.saveUserId(snapshot.data.uid);
          return HomePage();
        } else {
          Pref.removeUserId();
          return SignInPage();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: _startPage(),
      routes: {
        HomePage.id: (context) => HomePage(),
        SignInPage.id : (context) => SignInPage(),
        SingUpPage.id: (context) => SingUpPage(),
        DetailPage.id: (context) => DetailPage()
      },
    );
  }
}