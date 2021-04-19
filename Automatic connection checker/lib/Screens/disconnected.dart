import 'package:flutter/material.dart';

class Disconnected extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
          child: Text('Disconnected',
              style: Theme.of(context).textTheme.headline4)),
    );
  }
}
