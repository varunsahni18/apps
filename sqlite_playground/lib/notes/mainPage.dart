import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sqlite_playground/notes/addPage.dart';
import 'package:sqlite_playground/notes/editPage.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  User user;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  void initState() {
    user = _auth.currentUser;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screensize = MediaQuery.of(context).size;
    final ref = FirebaseFirestore.instance.collection(user.email);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add, color: Colors.white),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => AddPage()));
          }),
      body: StreamBuilder(
          stream: ref.snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            return Column(
              children: [
                //add media query
                //
                SizedBox(
                  height: screensize.height * 0.08,
                ),
                Container(
                  height: screensize.height * 0.065,
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(color: Colors.green[100]),
                  padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                  child: Row(
                    children: [
                      Text('Notes',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 32,
                              fontWeight: FontWeight.w500)),
                      SizedBox(
                        width: screensize.width * 0.52,
                      ),
                      IconButton(
                          icon: Icon(Icons.logout),
                          onPressed: () async {
                            await FirebaseAuth.instance.signOut();
                          })
                    ],
                  ),
                ),
                Container(
                  height: screensize.height * 0.83,
                  child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2),
                      itemCount:
                          snapshot.hasData ? snapshot.data.docs.length : 0,
                      itemBuilder: (_, index) {
                        //here _ represents context
                        return GestureDetector(
                          onTap: () {
                            print('Index: $index');
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditPage(
                                  docToEdit: snapshot.data.docs[index],
                                  index: index,
                                ),
                              ),
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.all(10),
                            margin: EdgeInsets.all(10),
                            height: 150,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.yellow[200],
                            ),
                            child: Column(
                              children: [
                                Text(
                                  snapshot.data.docs[index].data()['title'],
                                  style: TextStyle(fontSize: 18),
                                ),
                                SizedBox(height: 5),
                                Text(snapshot.data.docs[index]
                                    .data()['content']),
                              ],
                            ),
                          ),
                        );
                      }),
                ),
              ],
            );
          }),
    );
  }
}
