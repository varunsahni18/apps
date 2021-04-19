import 'package:flutter/material.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:play2/Screens/available.dart';
import 'package:play2/Screens/disconnected.dart';

class CheckInternet extends StatefulWidget {
  @override
  _CheckInternetState createState() => _CheckInternetState();
}

class _CheckInternetState extends State<CheckInternet> {
  checkConnection() async {
    print("The statement 'this machine is connected to the Internet' is: ");
    print(await DataConnectionChecker().hasConnection);
    // returns a bool

    // We can also get an enum value instead of a bool
    print("Current status: ${await DataConnectionChecker().connectionStatus}");
    // prints either DataConnectionStatus.connected
    // or DataConnectionStatus.disconnected

    // This returns the last results from the last call
    // to either hasConnection or connectionStatus
    print("Last results: ${DataConnectionChecker().lastTryResults}");

    // actively listen for status updates
    // this will cause DataConnectionChecker to check periodically
    // with the interval specified in DataConnectionChecker().checkInterval
    // until listener.cancel() is called

    // ignore: cancel_subscriptions
    var listener = DataConnectionChecker().onStatusChange.listen((status) {
      switch (status) {
        case DataConnectionStatus.connected:
          print('Data connection is available.');
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Available()),
          );
          break;
        case DataConnectionStatus.disconnected:
          print('You are disconnected from the internet.');
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Disconnected()),
          );
          break;
      }
    });

    // close listener after 30 seconds, so the program doesn't run forever
    //await Future.delayed(Duration(seconds: 30));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Check Internet',
              style: Theme.of(context).textTheme.headline4,
            ),
            TextButton(
                onPressed: () {
                  checkConnection();
                },
                child: Text(
                  'Click Here',
                  style: TextStyle(color: Colors.blueAccent, fontSize: 20),
                ))
          ],
        ),
      ),
    );
  }
}
