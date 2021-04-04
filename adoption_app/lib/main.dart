import 'package:flutter/material.dart';
import 'package:adoption_app/horizontal_list.dart';
import 'package:adoption_app/search_box.dart';
import 'package:adoption_app/greeting.dart';
import 'package:adoption_app/near.dart';
import 'package:adoption_app/wishlist.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final title = 'MyApp';
    return MaterialApp(
      title: title,
      home: Builder(
        builder: (context) {
          final size = MediaQuery.of(context).size;
          return Scaffold(
            backgroundColor: Colors.pinkAccent[50],
            appBar: AppBar(
              title: Text(title),
            ),
            body: ListView(
              scrollDirection: Axis.vertical,
              children: [
                Searchbox(size),
                Greetings(),
                NearYou(),
                HorizontalList(size.width),
                Wishlist(),
                HorizontalList(size.width),
              ],
            ),
          );
        },
      ),
    );
  }
}
