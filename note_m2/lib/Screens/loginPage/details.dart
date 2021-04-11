import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:notes/Screens/pages/MainPage.dart';

class Details extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();
  deleteDoc(DocumentSnapshot docToDelete) {
    return docToDelete.reference
        .delete()
        .then((value) => print('User Deleted'));
  }

  final String email;
  Details(this.email);
  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection(email);
    return StreamBuilder(
        stream: users.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                iconTheme: IconThemeData(color: Colors.black),
              ),
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Enter Your Nickname",
                      style: TextStyle(fontSize: 22),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.blue)),
                      margin: EdgeInsets.symmetric(horizontal: 30),
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: TextField(
                        controller: _controller,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 10),
                          labelText: "nickname",
                          labelStyle: TextStyle(color: Colors.black),
                          icon: Icon(
                            Icons.account_circle,
                            color: Colors.black,
                          ),
                          border: InputBorder.none,
                        ),
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        print(_controller.text);
                        print('Details : email : $email');
                        print(snapshot.data.docs.length);
                        deleteDoc(
                            snapshot.data.docs[snapshot.data.docs.length - 1]);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MainPage(email)));
                      },
                      child: Text(
                        'Click to continue',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ],
                ),
              ));
        });
  }
}
