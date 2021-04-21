import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var screensize = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          Container(
            color: Colors.blue,
            padding: EdgeInsets.fromLTRB(5, 20, 10, 0),
            height: screensize.height * 0.1,
            width: screensize.width,
            alignment: Alignment.topRight,
            child: TextButton(
              child: Text(
                'Logout',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
              },
            ),
          )
        ],
      ),
    );
  }
}
