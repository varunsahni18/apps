import 'package:flutter/material.dart';
import 'package:sqlite_playground/database.dart';

class Offline extends StatefulWidget {
  @override
  _OfflineState createState() => _OfflineState();
}

class _OfflineState extends State<Offline> {
  final dbHelper = DatabaseHelper.instance;
  @override
  Widget build(BuildContext context) {
    var screensize = MediaQuery.of(context).size;
    return Scaffold(
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: dbHelper.queryAllRows(),
        initialData: null,
        builder: (context, snapshot) => Column(
          children: [
            SizedBox(
              height: screensize.height * 0.08,
            ),
            Container(
              height: screensize.height * 0.065,
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(color: Colors.green[100]),
              padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
              child: Text('Notes',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 32,
                      fontWeight: FontWeight.w500)),
            ),
            Container(
              height: screensize.height * 0.83,
              child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemCount: snapshot.data.length,
                  itemBuilder: (_, index) {
                    return Container(
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.all(10),
                      height: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.yellow[200],
                      ),
                      child: Column(
                        children: [
                          Text(
                            snapshot.data[index]['title'],
                            style: TextStyle(fontSize: 18),
                          ),
                          SizedBox(height: 5),
                          Text(snapshot.data[index]['content'])
                        ],
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
