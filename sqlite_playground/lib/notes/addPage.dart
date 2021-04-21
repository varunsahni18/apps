import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sqlite_playground/database.dart';

class AddPage extends StatefulWidget {
  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  User user;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController title = TextEditingController();
  final TextEditingController content = TextEditingController();
  final dbHelper = DatabaseHelper.instance;

  void initState() {
    user = _auth.currentUser;
    super.initState();
  }

  @override
  void dispose() {
    title.dispose();
    content.dispose();
    super.dispose();
  }

  void _insert() async {
    // row to insert
    Map<String, dynamic> row = {
      DatabaseHelper.columnTitle: title.text,
      DatabaseHelper.columnContent: content.text,
    };
    final id = await dbHelper.insert(row);
    print('inserted row id: $id');
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference ref = FirebaseFirestore.instance.collection(user.email);
    return Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(
        backgroundColor: Colors.limeAccent[400],
        actions: [
          TextButton(
              onPressed: () async {
                await ref.add({
                  'title': title.text,
                  'content': content.text,
                }); //deleted .whenComplete(() => Navigator.pop(context))
                _insert();
                Navigator.pop(context);
              },
              child: Text(
                'Save',
                style: TextStyle(color: Colors.blue[900]),
              ))
        ],
        iconTheme: IconThemeData(color: Colors.blue[900]),
      ),
      body: Column(
        children: [
          Container(
            //decoration: BoxDecoration(border: Border.all()),
            margin: EdgeInsets.fromLTRB(10, 5, 5, 5),
            child: TextField(
              controller: title,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Title',
                //  border: OutlineInputBorder(borderSide: BorderSide.none),
              ),
              style: TextStyle(fontSize: 24),
            ),
          ),
          Expanded(
            child: Container(
              //decoration: BoxDecoration(border: Border.all()),
              margin: EdgeInsets.fromLTRB(10, 5, 5, 10),
              padding: EdgeInsets.all(10),
              child: TextField(
                controller: content,
                maxLines: null,
                expands: true,
                keyboardType: TextInputType.multiline,
                textAlign: TextAlign.start,
                decoration: InputDecoration(
                  hintText: 'Content',
                  border: InputBorder.none,
                ),
                style: TextStyle(fontSize: 14),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
