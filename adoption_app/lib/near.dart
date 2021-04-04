import 'package:flutter/material.dart';

class NearYou extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 7),
      width: 400,
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Text(
        'Near You',
        style: TextStyle(
          fontSize: 20,
          fontFamily: 'Futura',
          color: Colors.black,
        ),
      ),
    );
  }
}
