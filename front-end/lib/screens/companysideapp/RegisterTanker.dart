import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import 'Tankers_details.dart';

class RegisterTankerScreen extends StatefulWidget {
  @override
  _RegisterTankerScreenState createState() => _RegisterTankerScreenState();
}

class _RegisterTankerScreenState extends State<RegisterTankerScreen> {
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
  var sizeController = TextEditingController();
  var baseController = TextEditingController();
  var KMController = TextEditingController();
  bool _sizevalidate = false;
  bool _basepricevalidate = false;
  bool _priceperkmvalidate = false;
  bool gettingdata = true;
  @override
  Future<bool> _senddata(String base, priceKM, size) async {
    this.setState(() {
      this.gettingdata = true;
    });
    SharedPreferences pref = await SharedPreferences.getInstance();
    String userid = pref.getString('username');
    packageData = {
      'company_id': userid,
      'price_base': base,
      'price_per_km': priceKM,
      'browser_capacity': size
    };
    try {
      var response = await http.put(
        'https://seg27-paani-backend.herokuapp.com/packages/',
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
    if (sizeController.text.isEmpty) {
      this.setState(() {
        _sizevalidate = true;
      });
    } else if (baseController.text.isEmpty) {
      this.setState(() {
        _basepricevalidate = true;
      });
    } else if (KMController.text.isEmpty) {
      this.setState(() {
        _priceperkmvalidate = true;
      });
    } else {
      String size = sizeController.text;
      String base = baseController.text;
      String priceKM = KMController.text;
      if (await _senddata(base, priceKM, size)) {
        _showSnackBar('Information added Successfully');
      } else {
        _showSnackBar("Sorry, Couldnot add the informatiion");
      }
      setState(() {
        sizeController.text = "";
        baseController.text = "";
        KMController.text = "";
      });
    }
  }

  Widget build(BuildContext context) {
    return !this.gettingdata
        ? Scaffold(
            key: scaffoldKey,
            body: ListView(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 70, left: 20),
                  child: Text(
                    'Tanker Size:',
                    style: TextStyle(color: Colors.teal),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Card(
                    margin: EdgeInsets.symmetric(vertical: 12),
                    child: TextField(
                      controller: sizeController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Litres',
                        errorText:
                            _sizevalidate ? "This value cannot be empty" : null,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10, left: 20),
                  child: Text(
                    'Base Price:',
                    style: TextStyle(color: Colors.teal),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Card(
                    margin: EdgeInsets.symmetric(vertical: 12),
                    child: TextField(
                      controller: baseController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Rs',
                        errorText: _basepricevalidate
                            ? "This value can not be empty"
                            : null,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10, left: 20),
                  child: Text(
                    'Price per Km:',
                    style: TextStyle(color: Colors.teal),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Card(
                    margin: EdgeInsets.symmetric(vertical: 12),
                    child: TextField(
                      controller: KMController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Rs/Km',
                        errorText: _priceperkmvalidate
                            ? "This value cannot be empty"
                            : null,
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
                        margin:
                            EdgeInsets.symmetric(vertical: 12, horizontal: 85),
                        child: ListTile(
                          title: Text(
                            'Add Tanker',
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
                  padding: EdgeInsets.only(top: 20),
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
                        Navigator.pop(context);
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
