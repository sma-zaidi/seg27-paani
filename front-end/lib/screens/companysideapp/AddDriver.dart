import 'package:flutter/material.dart';
import 'package:sweetalert/sweetalert.dart';
import 'package:paani/screens/companysideapp/ViewDrivers.dart';

class AddDriverScreen extends StatefulWidget {
  @override
  _AddDriverScreenState createState() => _AddDriverScreenState();
}

class _AddDriverScreenState extends State<AddDriverScreen> {
  var nameController = TextEditingController();
  var cnicController = TextEditingController();
  var contactController = TextEditingController();
  @override
  void initState() {
    nameController.text = "";
    cnicController.text = "";
    contactController.text = "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Add Driver',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.teal,
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 70, left: 20),
            child: Text(
              'Driver\'s Name:',
              style: TextStyle(color: Colors.teal),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Card(
              margin: EdgeInsets.symmetric(vertical: 12),
              child: TextField(
                controller: nameController,
                decoration: InputDecoration(
                  hintText: 'Name',
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 20),
            child: Text(
              'Contact:',
              style: TextStyle(color: Colors.teal),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Card(
              margin: EdgeInsets.symmetric(vertical: 12),
              child: TextField(
                controller: contactController,
                decoration: InputDecoration(
                  hintText: '0300-1234567',
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 20),
            child: Text(
              'CNIC:',
              style: TextStyle(color: Colors.teal),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Card(
              margin: EdgeInsets.symmetric(vertical: 12),
              child: TextField(
                controller: cnicController,
                decoration: InputDecoration(
                  hintText: '12345-1234567-1',
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          Center(
            child: FlatButton(
              color: Colors.teal,
              child: Text(
                'Add',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                if (contactController.text == "" &&
                    nameController.text == "" &&
                    cnicController.text == "") {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text(
                            'One or More fields missing',
                            style: TextStyle(color: Colors.teal),
                          ),
                          actions: <Widget>[
                            FlatButton(
                              child: Text(
                                'OK',
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              color: Colors.teal,
                            )
                          ],
                        );
                      });
                } else {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        backgroundColor: Colors.white,
                        title: Text(
                          'Add Driver?',
                          style: TextStyle(color: Colors.teal, fontSize: 25.0),
                        ),
                        actions: <Widget>[
                          FlatButton(
                            child: Card(
                              child: SizedBox(
                                height: 30.0,
                                width: 50.0,
                                child: Center(
                                  child: Text(
                                    'YES',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                              color: Colors.teal,
                            ),
                            onPressed: () {
                              setState(() {
                                drivers.add({
                                  'name': nameController.text,
                                  'contact': contactController.text,
                                  'CNIC': cnicController.text,
                                  'Available': true
                                });
                                nameController.text = "";
                                cnicController.text = "";
                                contactController.text = "";
                              });
                              Navigator.of(context).pop();
                              Navigator.of(context).pop();
                              SweetAlert.show(context,
                                  style: SweetAlertStyle.success);
                            },
                          ),
                          FlatButton(
                            child: Card(
                              child: SizedBox(
                                height: 30.0,
                                width: 50.0,
                                child: Center(
                                  child: Text(
                                    'NO',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                              color: Colors.teal,
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
