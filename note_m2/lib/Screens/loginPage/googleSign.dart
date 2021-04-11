import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:notes/Screens/loginPage/details.dart';

// this function requires the googleSignIn function as a parameter.
// to call this function: use => GoogleSign(_signInWithGoogle)
//
class GoogleSign extends StatefulWidget {
  final Function _signInWithGoogle;
  final String email;
  addUser(String email) {
    print("debug 2 : $email");
    CollectionReference users = FirebaseFirestore.instance.collection(email);
    return users
        .add({'full_name': 'demo'})
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  GoogleSign(this._signInWithGoogle, this.email);

  @override
  _GoogleSignState createState() => _GoogleSignState();
}

class _GoogleSignState extends State<GoogleSign> {
  CollectionReference users = FirebaseFirestore.instance.collection('user');
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: users.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 40),
            width: 300,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                    offset: Offset(0, 10),
                    blurRadius: 50,
                    color: Colors.black12),
              ],
            ),
            child: ListTile(
                title: Text(
                  'Sign-in with Google',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                  ),
                ),
                leading: Image(
                  image: NetworkImage(
                      'https://i.pinimg.com/originals/7e/a2/a0/7ea2a086cc5082330324a94c52a66531.png'),
                  height: 40,
                  width: 40,
                ),
                onTap: () async {
                  await widget._signInWithGoogle();
                  print("##############debug############${widget.email}");
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Details(widget.email)));
                }),
          );
        });
  }
}
