import 'package:flutter/material.dart';
import 'RegisterDriver.dart';
import 'package:paani/screens/signup/account_created.dart';

class Optional extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: OptionalScreen(),
    );
  }
}

class OptionalScreen extends StatefulWidget {
  @override
  _OptionalScreenState createState() => _OptionalScreenState();
}

class _OptionalScreenState extends State<OptionalScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlatButton(
              child: Card(
                color: Colors.teal,
                margin: EdgeInsets.symmetric(vertical: 12.0, horizontal: 90),
                child: ListTile(
                  title: Center(
                    child: Text(
                      'Register Drivers',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => RegisterDriver()));
              },
            ),
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: Text(
                'or',
                style: TextStyle(color: Colors.teal, fontSize: 20),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: FlatButton(
                child: Card(
                  color: Colors.teal,
                  margin: EdgeInsets.symmetric(vertical: 12.0, horizontal: 130),
                  child: ListTile(
                    title: Center(
                      child: Text(
                        'Skip',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text(
                            'Are you sure you want to skip adding drivers right now?',
                            style: TextStyle(color: Colors.teal),
                          ),
                          actions: <Widget>[
                            FlatButton(
                              child: Text(
                                'YES',
                                style: TextStyle(color: Colors.white),
                              ),
                              color: Colors.teal,
                              onPressed: () {
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Accountcreated()),
                                    ModalRoute.withName('/'));
                              },
                            ),
                            FlatButton(
                              color: Colors.teal,
                              child: Text(
                                'NO',
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            )
                          ],
                        );
                      });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
