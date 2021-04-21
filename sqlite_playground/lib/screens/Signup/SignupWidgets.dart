import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

String emailID = '';

class Email extends StatefulWidget {
  @override
  _EmailState createState() => _EmailState();
}

TextEditingController email = TextEditingController();

class _EmailState extends State<Email> {
//  void dispose() {
//    email.dispose();
//    super.dispose();
//  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.blue)),
      margin: EdgeInsets.symmetric(horizontal: 30),
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: TextField(
        controller: email,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 10),
          labelText: "Email",
          labelStyle: TextStyle(color: Colors.black),
          icon: Icon(
            Icons.account_circle,
            color: Colors.black,
          ),
          border: InputBorder.none,
        ),
        keyboardType: TextInputType.emailAddress,
      ),
    );
  }
}

class Password extends StatefulWidget {
  @override
  _PasswordState createState() => _PasswordState();
}

TextEditingController password = TextEditingController();

class _PasswordState extends State<Password> {
//  void dispose() {
//    password.dispose();
//    super.dispose();
//  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.blue)),
      margin: EdgeInsets.symmetric(horizontal: 30),
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: TextField(
        controller: password,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 10),
          labelText: 'Password',
          labelStyle: TextStyle(color: Colors.black),
          icon: Icon(
            Icons.lock,
            color: Colors.black,
          ),
          border: InputBorder.none,
        ),
        keyboardType: TextInputType.text,
        obscureText: true,
      ),
    );
  }
}

class SignUpButton extends StatefulWidget {
  @override
  _SignUpButtonState createState() => _SignUpButtonState();
}

class _SignUpButtonState extends State<SignUpButton> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(
              onPressed: () async {
                setState(() {
                  emailID = email.text;
                });
                try {
                  // ignore: unused_local_variable
                  UserCredential userCredential;
                  userCredential = await FirebaseAuth.instance
                      .createUserWithEmailAndPassword(
                          email: email.text, password: password.text);
                } on FirebaseAuthException catch (e) {
                  if (e.code == 'weak-password') {
                    print('The password provided is too weak.');
                  } else if (e.code == 'email-already-in-use') {
                    print('The account already exists for that email.');
                  }
                } catch (e) {
                  print(e);
                }
              },
              child: Text('Register')),
          TextButton(
              //Sign In
              onPressed: () async {
                setState(() {
                  emailID = email.text;
                });
                try {
                  // ignore: unused_local_variable
                  UserCredential userCredential = await FirebaseAuth.instance
                      .signInWithEmailAndPassword(
                          email: email.text, password: password.text);
                } on FirebaseAuthException catch (e) {
                  if (e.code == 'user-not-found') {
                    print('No user found for that email.');
                  } else if (e.code == 'wrong-password') {
                    print('Wrong password provided for that user.');
                  }
                }
              },
              child: Text('Sign In'))
        ],
      ),
    );
  }
}
