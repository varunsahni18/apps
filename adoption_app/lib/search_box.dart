import 'package:flutter/material.dart';

class Searchbox extends StatelessWidget {
  final size;
  Searchbox(this.size);
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(
          horizontal: size.width * 0.06, vertical: size.height * 0.02),
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
      height: 54,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
              offset: Offset(0, 10), blurRadius: 50, color: Colors.black12),
        ],
      ),
      child: TextField(
        decoration: InputDecoration(
            hintText: 'Find',
            hintStyle: TextStyle(color: Colors.black45),
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            suffixIcon: Icon(Icons.search_outlined)),
      ),
    );
  }
}
