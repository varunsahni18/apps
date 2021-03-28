import 'package:flutter/material.dart';

int bill, tip;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _controller = TextEditingController();
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _controller.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tip Calculator'),
      ),
      body: Column(
        children: [
          Container(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                alignLabelWithHint: true,
                hintText: "Enter Amount",
                labelText: "Billing Amount",
                border: InputBorder.none,
                fillColor: Colors.blue[100],
                filled: true,
                //prefixIcon: Icon(Icon.name_of_Icon) - to add an icon
              ),
              keyboardType: TextInputType.number,
            ),
          ),
          TextButton(
              onPressed: () {
                bill = int.parse(_controller.text);
                print(bill);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NextPage()),
                );
              },
              child: Text('next page'))
        ],
      ),
    );
  }
}

class NextPage extends StatefulWidget {
  @override
  _NextPageState createState() => _NextPageState();
}

class _NextPageState extends State<NextPage> {
  TextEditingController _controller2 = TextEditingController();
  int check = 0;
  double calculate() {
    return (bill + bill * (tip / 100));
  }

  void dispose2() {
    // Clean up the controller when the widget is disposed.
    _controller2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Result'),
      ),
      body: Column(
        children: [
          Container(
            child: TextField(
              controller: _controller2,
              decoration: InputDecoration(
                alignLabelWithHint: true,
                hintText: "Enter Tip",
                labelText: "Tip Percentage",
                border: InputBorder.none,
                fillColor: Colors.blue[100],
                filled: true,
              ),
              keyboardType: TextInputType.number,
            ),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                tip = int.parse(_controller2.text);
                print(tip);
                check = 1;
                print(check);
              });
            },
            child: Text('Calculate'),
          ),
          check == 0
              ? Container()
              : Container(
                  child: Text('Your Total Amout is equal\n to ${calculate()}')),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
              );
              check = 0;
            },
            child: Text('return'),
          )
        ],
      ),
    );
  }
}
