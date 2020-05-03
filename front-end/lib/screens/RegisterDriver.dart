import 'package:flutter/material.dart';

import 'main.dart';

class RegisterDriver extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: RegisterDriverScreen(),
    );
  }
}

class RegisterDriverScreen extends StatefulWidget {
  @override
  _RegisterDriverScreenState createState() => _RegisterDriverScreenState();
}

class _RegisterDriverScreenState extends State<RegisterDriverScreen> {
  var driverData = [];
  var nameController = TextEditingController();
  var cnicController = TextEditingController();
  var contactController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 70, left: 20),
            child: Text(
              'Name:',
              style: TextStyle(color: Colors.teal),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Card(
              margin: EdgeInsets.symmetric(vertical: 12),
              child: TextField(
                controller: nameController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Name',
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10, left: 20),
            child: Text(
              'CNIC:',
              style: TextStyle(color: Colors.teal),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Card(
              margin: EdgeInsets.symmetric(vertical: 12),
              child: TextField(
                controller: cnicController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: '12345-1234567-1',
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10, left: 20),
            child: Text(
              'Contact:',
              style: TextStyle(color: Colors.teal),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Card(
              margin: EdgeInsets.symmetric(vertical: 12),
              child: TextField(
                controller: contactController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: '0300-1234567',
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 20),
            child: Center(
              child: FlatButton(
                child: Card(
                  color: Colors.teal,
                  margin: EdgeInsets.symmetric(vertical: 12, horizontal: 90),
                  child: ListTile(
                    title: Text(
                      'Add Driver',
                      style: TextStyle(color: Colors.white),
                    ),
                    trailing: Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                  ),
                ),
                onPressed: () {
                  driverData.add({
                    'name': nameController.text,
                    'CNIC': cnicController.text,
                    'contact': contactController.text
                  });
                  //TODO: Send POST request to Server with the DATA
                  setState(() {
                    nameController.text = "";
                    cnicController.text = "";
                    contactController.text = "";
                  });
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text(
                            'Driver Details Added Successfully',
                            style: TextStyle(color: Colors.teal),
                          ),
                          actions: <Widget>[
                            FlatButton(
                              child: Text(
                                'OK',
                                style: TextStyle(color: Colors.white),
                              ),
                              color: Colors.teal,
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            )
                          ],
                        );
                      });
                },
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: Center(
              child: Text(
                'or',
                style: TextStyle(color: Colors.teal),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: Center(
              child: FlatButton(
                child: Card(
                  color: Colors.teal,
                  margin: EdgeInsets.symmetric(vertical: 12, horizontal: 125),
                  child: ListTile(
                    title: Center(
                      child: Text(
                        'Done',
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
                            'Sign Up Completed!',
                            style: TextStyle(color: Colors.teal),
                          ),
                          actions: <Widget>[
                            FlatButton(
                              color: Colors.teal,
                              child: Text(
                                'OK',
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                                //TODO: Navigate to Company HomePage
                              },
                            ),
                          ],
                        );
                      });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
