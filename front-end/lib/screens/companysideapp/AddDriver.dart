import 'package:flutter/material.dart';
import 'package:paani/screens/companysideapp/ViewDrivers.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/services.dart';

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
  var nameController = TextEditingController(); //Name Field Editing Controller
  var cnicController = TextEditingController(); //CNIC Field Editing Controller
  var contactController = TextEditingController(); //Contact Number Field Editing Controller
  bool gettingdata = false; //If true: displays loading icon, else: shows data

  Future<bool> _senddata(String name, cnic, contact) async {
    //Send Data to Server
    this.setState(() {
      this.gettingdata = true;
    });
    SharedPreferences pref = await SharedPreferences.getInstance();
    String userid = pref.getString('userid');
    packageData = {
      'company_id': userid,
      'name': name,
      'cnic': cnic,
      'contact_number': contact,
    };
    try {
      print(packageData);
      var response = await http.post(
        'https://seg27-paani-backend.herokuapp.com/drivers/',
        body: packageData,
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
    //Submitting Data
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
        setState(() {
          //After Data is Sent, fields are reset to empty
          nameController.text = "";
          cnicController.text = "";
          contactController.text = "";
        });
        _showSnackBar('Driver Added Successfully');
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
    return !this.gettingdata
        ? Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              centerTitle: true,
              title: Text('Add Driver', style: TextStyle(color: Colors.white)),
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
                        hintText: '03001234567',
                        border: InputBorder.none,
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        WhitelistingTextInputFormatter.digitsOnly
                      ],
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
                          hintText: '1234512345671',
                          border: InputBorder.none,
                        ),
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          WhitelistingTextInputFormatter.digitsOnly
                        ]),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Center(
                    child: FlatButton(
                      child: Card(
                        color: Colors.teal,
                        margin:
                            EdgeInsets.symmetric(vertical: 12, horizontal: 85),
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
                      onPressed: _submit,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 5),
                  child: Center(
                    child: FlatButton(
                      child: Card(
                        color: Colors.teal,
                        margin:
                            EdgeInsets.symmetric(vertical: 12, horizontal: 85),
                        child: ListTile(
                          title: Text(
                            'Done',
                            style: TextStyle(color: Colors.white),
                          ),
                          trailing: Icon(
                            Icons.done,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      onPressed: () {
                        Navigator.popAndPushNamed(
                            context, '/viewdriverstankerloading',
                            arguments: {'required': 'editdrivers'});
                      },
                    ),
                  ),
                ),
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
