import 'package:flutter/material.dart';

// learn how to pass info regarding Icon to be used
class Box extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Card(
        child: InkWell(
          splashColor: Colors.blue.withAlpha(30),
          onTap: () {
            print('Card tapped.');
          },
          child: Column(
            children: [
              Image.network(
                  'https://www.cdc.gov/healthypets/images/pets/cute-dog-headshot.jpg',
                  // width: 300,
                  height: 150,
                  fit: BoxFit.fill),
              Container(
                width: 200,
                child: ListTile(
                  title: Text(
                    'Poodle',
                    style: TextStyle(
                      fontSize: 24,
                      fontFamily: 'Futura',
                      color: Colors.blue,
                    ),
                  ),
                  trailing: Icon(
                    Icons.verified_outlined,
                    color: Colors.green,
                    size: 30,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
