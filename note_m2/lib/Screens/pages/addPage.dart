import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddPage extends StatelessWidget {
  final TextEditingController title = TextEditingController();
  final TextEditingController content = TextEditingController();
  final String email;
  AddPage(this.email);

  @override
  Widget build(BuildContext context) {
    CollectionReference ref = FirebaseFirestore.instance.collection(email);
    return Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(
        backgroundColor: Colors.limeAccent[400],
        actions: [
          TextButton(
              onPressed: () {
                ref.add({
                  'title': title.text,
                  'content': content.text,
                }).whenComplete(() => Navigator.pop(context));
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
