import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:paani/screens/companysideapp/ViewDrivers.dart';

class EditScreen extends StatefulWidget {
  var data;
  EditScreen({this.data});
  @override
  _EditScreenState createState() => _EditScreenState(data: data);
}

class _EditScreenState extends State<EditScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  var data;
  _EditScreenState({this.data});
  var nameController = TextEditingController();
  var cnicController = TextEditingController();
  var contactController = TextEditingController();

  Future<http.Response> updateDriver(id, name, cnic, contactNumber) async {
    try {
      var response =
          await http.put('https://seg27-paani-backend.herokuapp.com/drivers',
              headers: {
                "Content-Type": "application/x-www-form-urlencoded",
                "Content-Type": "application/json",
              },
              body: jsonEncode({
                'driver_id': id,
                'name': name,
                'cnic': cnic,
                'contact_number': contactNumber,
              }));

      var message = jsonDecode(response.body);
      if (message['error'] == true)
        return null;
      else
        return response;
    } catch (error) {
      return null;
    }
  }

  Future<bool> _submit() async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();

      var response = await updateDriver(
        drivers[data]['id'],
        drivers[data]['name'],
        drivers[data]['CNIC'],
        drivers[data]['contact'],
      );

      if (response == null) return false; // edit failed
      return true;
    } catch (error) {
      print(error);
      return false;
    }
  }

  void _showSnackBar(String text) {
    scaffoldKey.currentState.hideCurrentSnackBar();
    scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(text),
      action: SnackBarAction(
        label: 'Dismiss',
        onPressed: () {
          scaffoldKey.currentState.hideCurrentSnackBar();
        },
      ),
    ));
  }

  @override
  void initState() {
    nameController.text = drivers[data]['name'];
    cnicController.text = drivers[data]['CNIC'];
    contactController.text = drivers[data]['contact'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.teal,
        centerTitle: true,
        title: Text(
          'Edit Driver',
          style: TextStyle(color: Colors.white),
        ),
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
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          Center(
            child: FlatButton(
              color: Colors.teal,
              child: Text(
                'Save',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      backgroundColor: Colors.white,
                      title: Text(
                        'Save Changes?',
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
                          onPressed: () async {
                            setState(() {
                              drivers[data]['name'] = nameController.text;
                              drivers[data]['contact'] = contactController.text;
                              drivers[data]['CNIC'] = cnicController.text;
                            });
                            Navigator.of(context, rootNavigator: true).pop();
                            if (await _submit()) {
                              _showSnackBar("Driver details updated");
                            } else {
                              _showSnackBar('Couldn\'t update driver details');
                            }
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
              },
            ),
          )
        ],
      ),
    );
  }
}
