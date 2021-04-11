import 'package:acm/image/fetch.dart';
import 'package:acm/image/upload.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LogIn extends StatefulWidget {
  @override
  _LogInState createState() => _LogInState();
}

String nickname;
Map data;
User user;

class _LogInState extends State<LogIn> {
  fetchData() {
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection(user.email);

    collectionReference.snapshots().listen((snapshot) {
      setState(() {
        data = snapshot.docs[0].data();
      });
    });
  }

  @override
  void initState() {
    user = FirebaseAuth.instance.currentUser;
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return user == null
        ? Scaffold(
            body: Container(),
          )
        : Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              iconTheme: IconThemeData(color: Colors.black),
              actions: [
                TextButton(
                    onPressed: () async {
                      await FirebaseAuth.instance.signOut();
                    },
                    child: Text(
                      'Logout',
                      style: TextStyle(color: Colors.blue[900]),
                    ))
              ],
            ),
            body: Container(
              alignment: Alignment.topCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Welcome ${data['Nickname']}',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 40),
                  TextButton(
                      onPressed: () async {
                        // ignore: unused_local_variable
                        final url = await getUrl();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FetchImage(url)),
                        );
                      },
                      child: Text("Fetch Image")),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CaptureImage()),
                        );
                      },
                      child: Text("Upload Image")),
                ],
              ),
            ),
          );
  }
}
