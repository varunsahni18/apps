import 'dart:io';

import 'package:acm/Screens/loginScreen/login.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CaptureImage extends StatefulWidget {
  @override
  _CaptureImageState createState() => _CaptureImageState();
}

class _CaptureImageState extends State<CaptureImage> {
  File _image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Picker Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _image == null
                ? Text('No image selected.')
                : Container(
                    height: 300,
                    width: 300,
                    margin: EdgeInsets.all(10),
                    child: Image.file(_image),
                  ),
            Container(
                child: Stack(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: 1.0, horizontal: 12.0),
                  margin: const EdgeInsets.fromLTRB(20.0, 30, 20, 20),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.white, Colors.lightBlue],
                      ),
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(10)),
                  child: TextButton(
                    onPressed: () {
                      if (_image == null) {
                        print('No file has been selected');
                      } else {
                        UploadFirebase(context);
                        print('file has been uploaded');
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LogIn()),
                        );
                      }
                    },
                    child: Text(
                      'Upload Image',
                      style: TextStyle(color: Colors.blue[900]),
                    ),
                  ),
                )
              ],
            ))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: getImage,
        tooltip: 'Pick Image',
        child: Icon(Icons.add_a_photo),
      ),
    );
  }

  Future UploadFirebase(BuildContext context) async {
    String fileName = "Image${DateTime.now().toString()}";
    var url;
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference ref = storage.ref().child(fileName);
    UploadTask uploadTask = ref.putFile(_image);
    uploadTask.whenComplete(() async {
      url = await ref.getDownloadURL();
    }).catchError((onError) {
      print(onError);
    });
  }
}
