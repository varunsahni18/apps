import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EditPage extends StatefulWidget {
  final DocumentSnapshot docToEdit;
  EditPage({this.docToEdit});
  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  TextEditingController title = TextEditingController();
  TextEditingController content = TextEditingController();

  @override
  void initState() {
    title = TextEditingController(text: widget.docToEdit.data()['title']);
    content = TextEditingController(text: widget.docToEdit.data()['content']);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(
        backgroundColor: Colors.limeAccent[400],
        actions: [
          TextButton(
            onPressed: () {
              widget.docToEdit.reference.update({
                'title': title.text,
                'content': content.text,
              }).whenComplete(() => Navigator.pop(context));
            },
            child: Text(
              'Save',
              style: TextStyle(color: Colors.blue[900]),
            ),
          ),
          TextButton(
            onPressed: () {
              widget.docToEdit.reference
                  .delete()
                  .whenComplete(() => Navigator.pop(context));
            },
            child: Text(
              'Delete',
              style: TextStyle(color: Colors.blue[900]),
            ),
          ),
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
