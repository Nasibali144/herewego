import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:herewego/pages/home_page.dart';
import 'package:herewego/pages/signin_page.dart';
import 'package:herewego/services/auth_service.dart';
import 'package:herewego/services/pref_service.dart';
import 'package:herewego/services/utils_service.dart';

class SingUpPage extends StatefulWidget {

  static final String id = 'signup_page';

  @override
  _SingUpPageState createState() => _SingUpPageState();
}

class _SingUpPageState extends State<SingUpPage> {

  var isLoading = false;
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  _doSignUp() {
    var name = nameController.text.toString().trim();
    var email = emailController.text.toString().trim();
    var password = passwordController.text.toString().trim();
    if(name.isEmpty || email.isEmpty || password.isEmpty) return;
    setState(() {
      isLoading = true;
    });

    AuthService.signUpUser(context, name, email, password).then((firebaseUser) => {
      _getFirebaseUser(firebaseUser)
    });
  }

  _getFirebaseUser(FirebaseUser firebaseUser) {
    setState(() {
      isLoading = false;
    });
    if(firebaseUser != null) {
      Pref.saveUserId(firebaseUser.uid);
      Navigator.pushReplacementNamed(context, HomePage.id);
    } else {
      Utils.fireToast('Check your information');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            margin: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    hintText: 'Fullname'
                  ),
                ),
                SizedBox(height: 10,),
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                      hintText: 'Email'
                  ),
                ),
                SizedBox(height: 10,),
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                      hintText: 'Password'
                  ),
                ),
                SizedBox(height: 10,),
                Container(
                  width: double.infinity,
                  height: 45,
                  child: FlatButton(
                    onPressed: _doSignUp,
                    child: Text('Sing Up'),
                    color: Colors.red,
                    textColor: Colors.white,
                  ),
                ),
                SizedBox(height: 10,),
                Container(
                  width: double.infinity,
                  alignment: Alignment.centerRight,
                  child: FlatButton(
                    child: Text("Already you have account? \t Sign In"),
                    textColor: Colors.black,
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, SignInPage.id);
                    },
                  ),
                ),
              ],
            ),
          ),

          isLoading ? Center(
            child: CircularProgressIndicator(),
          ) : SizedBox.shrink()
        ],
      ),
    );
  }
}
