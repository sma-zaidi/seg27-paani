import 'package:flutter/material.dart';
import 'package:paani/screens/companysideapp/ViewDrivers.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AddDriverScreen extends StatefulWidget {
  @override
  _AddDriverScreenState createState() => _AddDriverScreenState();
}

class _AddDriverScreenState extends State<AddDriverScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
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

  Map packageData;
  var nameController = TextEditingController();
  var cnicController = TextEditingController();
  var contactController = TextEditingController();
  bool gettingdata = false;

  Future<bool> _senddata(String name, cnic, contact) async {
    this.setState(() {
      this.gettingdata = true;
    });
    SharedPreferences pref = await SharedPreferences.getInstance();
    String userid = pref.getString('username');
    packageData = {
      'company_id': userid,
      'name': name,
      'cnic': cnic,
      'contact': contact,
    };
    try {
      var response = await http.put(
        'https://seg27-paani-backend.herokuapp.com/drivers/',
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
          "Content-Type": "application/json",
        },
        body: jsonEncode(packageData),
      );
      print(response.body);
      if (json.decode(response.body)['error'] == false) {
        this.setState(() {
          this.gettingdata = false;
        });
        return true;
      } else {
        this.setState(() {
          this.gettingdata = false;
        });
        return false;
      }
    } catch (e) {
      this.setState(() {
        this.gettingdata = false;
      });
      return false;
    }
  }

  Future<void> _submit() async {
    if (contactController.text == "" ||
        nameController.text == "" ||
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
      if (await _senddata(
          nameController.text, cnicController.text, contactController.text)) {
        _showSnackBar('Driver Added Successfully');
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
      } else {
        _showSnackBar('Sorry, Driver Could not be added');
      }
    }
  }

  @override
  void initState() {
    nameController.text = "";
    cnicController.text = "";
    contactController.text = "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return this.gettingdata
        ? Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              centerTitle: true,
              title: Text('Add Driver', style: TextStyle(color: Colors.white)),
              leading: FlatButton(
                child: Icon(
                  Icons.keyboard_backspace,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => DriversScreen()));
                },
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
                    onPressed: _submit,
                  ),
                ),
                SizedBox(
                  height: 18.0,
                ),
                Center(
                  child: FlatButton(
                    color: Colors.teal,
                    child: Text(
                      'Done',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                )
              ],
            ),
          )
        : Scaffold(
            key: scaffoldKey,
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
  }
}
