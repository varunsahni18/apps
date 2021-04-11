import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NotePage extends StatefulWidget {
  final String name;

  NotePage(
    this.name,
  );

  @override
  _NotePageState createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  Map data;

  addData() {
    Map<String, dynamic> demoData = {
      "Title": "Demo Title",
      "body": "This is a demo text"
    };
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('data');
    collectionReference.add(demoData);
  }

  fetchData() {
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('data');

    collectionReference.snapshots().listen((snapshot) {
      setState(() {
        data = snapshot.docs[0].data();
      });
    });
    //snapshorts is the packets of data that I am acessing from cloud firestore
    //it is a stream of data.
  }

  deleteData() async {
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('data');
    QuerySnapshot querySnapshot = await collectionReference.get();
    querySnapshot.docs[0].reference.delete();
  }

  updateData() async {
    Map<String, dynamic> upData = {
      "Title": "Varun Sahni",
      "body": "This is a demo text"
    };
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('data');
    QuerySnapshot querySnapshot = await collectionReference.get();
    querySnapshot.docs[0].reference.update(upData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 35,
          ),
          Center(
            child: Container(
              child: Text(
                'Welcome ${widget.name}',
                textAlign: TextAlign.center,
                style: GoogleFonts.openSans(
                    color: Colors.grey[800],
                    fontSize: 18,
                    fontWeight: FontWeight.w400),
              ),
            ),
          ),
          SizedBox(height: 25),
          Container(
            width: 300,
            color: Colors.lime,
            child: TextButton(
              onPressed: fetchData,
              child: Text(
                'Fetch Data',
              ),
            ),
          ),
          SizedBox(height: 15),
          Container(
            width: 300,
            color: Colors.pink,
            child: TextButton(
              onPressed: addData,
              child: Text(
                'Add Data',
              ),
            ),
          ),
          SizedBox(height: 15),
          Container(
            width: 300,
            color: Colors.amber,
            child: TextButton(
              onPressed: updateData,
              child: Text(
                'Update Data',
              ),
            ),
          ),
          SizedBox(height: 15),
          Container(
            width: 300,
            color: Colors.orange,
            child: TextButton(
              onPressed: deleteData,
              child: Text(
                'Delete Data',
              ),
            ),
          ),
          SizedBox(height: 15),
          Text(
            data.toString(),
            style: GoogleFonts.openSans(
                color: Colors.grey[800],
                fontSize: 18,
                fontWeight: FontWeight.w400),
          )
        ],
      ),
    );
  }
}
