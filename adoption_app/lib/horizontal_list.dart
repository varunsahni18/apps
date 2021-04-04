import 'package:adoption_app/Image.dart';
import 'package:flutter/material.dart';

class HorizontalList extends StatelessWidget {
  final double phnwidth;
  HorizontalList(this.phnwidth);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      height: 220.0,
      width: phnwidth,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          Box(),
          Box(),
          Box(),
          Box(),
        ],
      ),
    );
  }
}
