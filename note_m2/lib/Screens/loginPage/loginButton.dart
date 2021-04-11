import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notes/Screens/NotesPage/note.dart';
import 'package:notes/Screens/loginPage/home.dart';

class LoginButton extends StatefulWidget {
  @override
  _LoginButtonState createState() => _LoginButtonState();
}

class _LoginButtonState extends State<LoginButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 40),
      width: 3000,
      decoration: BoxDecoration(
        color: Colors.greenAccent,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
              offset: Offset(0, 10), blurRadius: 50, color: Colors.black12),
        ],
      ),
      child: TextButton(
        onPressed: () async {
          User user;
          firebaseAuth
              .signInWithEmailAndPassword(
                  email: 'demo@gmail.com', password: 'demo123')
              // ignore: non_constant_identifier_names
              .then((UserCredential) {
            setState(() {
              user = UserCredential.user;
            });
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => NotePage(user.email)));
            print(user.email);
          });
        },
        child: Text(
          'Login',
          style: GoogleFonts.openSans(
              color: Colors.white, fontSize: 24, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
