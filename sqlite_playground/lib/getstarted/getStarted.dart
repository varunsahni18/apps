import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sqlite_playground/notes/mainPage.dart';
import 'package:sqlite_playground/offline/Offline.dart';
import 'package:sqlite_playground/screens/Signup/SignupPage.dart';

class GetStarted extends StatefulWidget {
  @override
  _GetStartedState createState() => _GetStartedState();
}

class _GetStartedState extends State<GetStarted> {
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
            MaterialPageRoute(builder: (context) => MainPage()),
          );
          break;
        case DataConnectionStatus.disconnected:
          print('You are disconnected from the internet.');
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Offline()),
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(child: Text('This is the Get Started Page')),
          TextButton(
              onPressed: () {
                FirebaseAuth.instance.authStateChanges().listen((User user) {
                  if (user == null) {
                    print('User is currently signed out!');
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignupPage()),
                    );
                  } else {
                    print('User is signed in ^-^');
                    checkConnection();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MainPage()),
                    );
                  }
                });
              },
              child: Text('Get Started')),
        ],
      ),
    );
  }
}
