import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:notes/Screens/pages/addPage.dart';
import 'package:notes/Screens/pages/editPage.dart';

class MainPage extends StatelessWidget {
  final String email;
  MainPage(this.email);
  @override
  Widget build(BuildContext context) {
    final ref = FirebaseFirestore.instance.collection(email);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add, color: Colors.white),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => AddPage(email)));
          }),
      body: StreamBuilder(
          stream: ref.snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemCount: snapshot.hasData ? snapshot.data.docs.length : 0,
                itemBuilder: (_, index) {
                  //here _ represents context
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditPage(
                            docToEdit: snapshot.data.docs[index],
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
                          Text(snapshot.data.docs[index].data()['content']),
                        ],
                      ),
                    ),
                  );
                });
          }),
    );
  }
}
