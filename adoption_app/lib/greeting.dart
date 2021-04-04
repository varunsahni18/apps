import 'package:flutter/material.dart';

class Greetings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      width: 400,
      child: ListTile(
        title: Text(
          'Welcome Back,\nJosh',
          style: TextStyle(
            fontSize: 20,
            fontFamily: 'Futura',
            color: Colors.black,
          ),
        ),
        trailing: Icon(
          Icons.switch_account,
          color: Colors.blue,
          size: 40,
        ),
      ),
    );
  }
}
