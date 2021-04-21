import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sqlite_playground/database.dart';

class EditPage extends StatefulWidget {
  final DocumentSnapshot docToEdit;
  final int index;
  EditPage({this.docToEdit, this.index});
  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  TextEditingController title = TextEditingController();
  TextEditingController content = TextEditingController();
  final dbHelper = DatabaseHelper.instance;

  @override
  void initState() {
    title = TextEditingController(text: widget.docToEdit.data()['title']);
    content = TextEditingController(text: widget.docToEdit.data()['content']);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    void _update(int number) async {
      // row to update
      Map<String, dynamic> row = {
        DatabaseHelper.columnId: number + 1,
        DatabaseHelper.columnTitle: title.text,
        DatabaseHelper.columnContent: content.text
      };
      final rowsAffected = await dbHelper.update(row);
      print('updated $rowsAffected row(s)');
    }

    void _delete(int number) async {
      // Assuming that the number of rows is the id for the last row.
      final id = number + 1;
      final rowsDeleted = await dbHelper.delete(id);
      print('deleted $rowsDeleted row(s): row $id');
    }

    return Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(
        backgroundColor: Colors.limeAccent[400],
        actions: [
          TextButton(
            onPressed: () async {
              await widget.docToEdit.reference.update({
                'title': title.text,
                'content': content.text,
              }); //deleted .whenComplete(() => Navigator.pop(context))
              _update(widget.index);
              Navigator.pop(context);
            },
            child: Text(
              'Save',
              style: TextStyle(color: Colors.blue[900]),
            ),
          ),
          TextButton(
            onPressed: () {
              widget.docToEdit.reference.delete();
              //deleted .whenComplete(() => Navigator.pop(context))
              _delete(widget.index);
              Navigator.pop(context);
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
