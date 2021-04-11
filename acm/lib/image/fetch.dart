import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class FetchImage extends StatefulWidget {
  final link;
  FetchImage(this.link);
  @override
  _FetchImageState createState() => _FetchImageState();
}

class _FetchImageState extends State<FetchImage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Container(
        height: 200,
        width: 200,
        child: Image(image: NetworkImage(widget.link)),
      ),
    );
  }
}

getUrl() async {
  final ref = FirebaseStorage.instance.ref().child('profileIcon.png');
  var url = await ref.getDownloadURL();
  print(url);
  return url;
}
