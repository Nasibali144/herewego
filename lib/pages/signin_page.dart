import 'package:flutter/material.dart';
import 'package:herewego/pages/signup_page.dart';
import 'package:herewego/services/auth_service.dart';

class SignInPage extends StatefulWidget {

  static final String id = 'singin_page';

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  var isLoading = false;
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  _doSignIn() {
    var email = emailController.text.toString().trim();
    var password = passwordController.text.toString().trim();
    if(email.isEmpty || password.isEmpty) return;

    setState(() {
      isLoading = true;
    });

    AuthService.signInUser(context, email, password);
    setState(() {
      isLoading = false;
    });
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
                    onPressed: _doSignIn,
                    child: Text('Sing In'),
                    color: Colors.red,
                    textColor: Colors.white,
                  ),
                ),
                SizedBox(height: 10,),
                Container(
                  width: double.infinity,
                  alignment: Alignment.centerRight,
                  child: FlatButton(
                    child: Text("Don't have an account? \t Sign Up"),
                    textColor: Colors.black,
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, SingUpPage.id);
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
