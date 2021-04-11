import 'package:acm/GetStarted/error.dart';
import 'package:acm/Screens/Signup/signup.dart';
import 'package:acm/Screens/loginScreen/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class GetStarted extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(child: Text('This is the Get Started Page')),
          TextButton(
              onPressed: () {
                FirebaseAuth.instance.authStateChanges().listen((User user) {
                  if (user == null) {
                    print('User is currently signed out!');
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignUp()),
                    );
                  } else if (user.emailVerified) {
                    print('User is signed in ^-^');
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LogIn()),
                    );
                  } else {
                    print("I don't know what is happening");
                    print(user.email);
                    print('${user.emailVerified}');
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => (ErrorPage())),
                    );
                  }
                });
              },
              child: Text('Get Started')),
        ],
      ),
    );
  }
}
