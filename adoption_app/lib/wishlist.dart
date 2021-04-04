import 'package:flutter/material.dart';

class Wishlist extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: ListTile(
        title: Text(
          'Wishlist',
          style: TextStyle(
            fontSize: 20,
            fontFamily: 'Futura',
            color: Colors.black,
          ),
        ),
        trailing: Icon(
          Icons.favorite_outlined,
          color: Colors.red,
          size: 30,
        ),
      ),
    );
  }
}
