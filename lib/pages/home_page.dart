import 'package:flutter/material.dart';
import 'package:herewego/pages/signin_page.dart';
import 'package:herewego/services/auth_service.dart';
import 'package:herewego/services/pref_service.dart';

class HomePage extends StatefulWidget {

  static final String id = 'home_page';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Firebase'),
        backgroundColor: Colors.red,
      ),
      body: Center(
        child: FlatButton(
          textColor: Colors.white,
          color: Colors.red,
          child: Text('Sign Out'),
          onPressed: () {
            AuthService.signOutUser(context);
            Pref.removeUserId().then((value) => {
              Navigator.pushReplacementNamed(context, SignInPage.id)
            });
          },
        ),
      ),
    );
  }
}
