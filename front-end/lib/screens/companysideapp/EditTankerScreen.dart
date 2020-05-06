import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'Tankers_details.dart';
import 'package:sweetalert/sweetalert.dart';

class EditTankerScreen extends StatefulWidget {
  var data;
  EditTankerScreen({this.data});
  @override
  _EditTankerScreenState createState() => _EditTankerScreenState(data: data);
}

class _EditTankerScreenState extends State<EditTankerScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  var data;
  _EditTankerScreenState({this.data});
  var capController = TextEditingController();
  var baseController = TextEditingController();
  var KMController = TextEditingController();

  Future<http.Response> updatePackage(id, priceBase, pricePerKm, bowserCapacity) async {
    try {
      var response = await http.put(
        'https://seg27-paani-backend.herokuapp.com/packages',
        headers: {
            "Content-Type": "application/x-www-form-urlencoded",
            "Content-Type": "application/json",
        },
        body: jsonEncode({
          'package_id': id,
          'price_base': priceBase,
          'price_per_km': pricePerKm,
          'bowser_capacity': bowserCapacity,
        })
      );

      var message = jsonDecode(response.body);
      if(message['error'] == true) return null;
      else return response;
    } catch (error) {
      return null;
    }

  }

  Future<bool> _submit() async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance(); 

      var response = await updatePackage(
        Tankers[data]['id'],
        Tankers[data]['price_base'],
        Tankers[data]['price_per_km'],
        Tankers[data]['bowser_capacity'],
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
    capController.text = Tankers[data]['bowser_capacity'].toString();
    baseController.text = Tankers[data]['price_base'].toString();
    KMController.text = Tankers[data]['price_per_km'].toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('Edit Tanker'),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 70, left: 20),
            child: Text(
              'Capacity:',
              style: TextStyle(color: Colors.teal),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Card(
              margin: EdgeInsets.symmetric(vertical: 12),
              child: TextField(
                controller: capController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 20),
            child: Text(
              'Base Price:',
              style: TextStyle(color: Colors.teal),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Card(
              margin: EdgeInsets.symmetric(vertical: 12),
              child: TextField(
                controller: baseController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 20),
            child: Text(
              'Price/Km:',
              style: TextStyle(color: Colors.teal),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Card(
              margin: EdgeInsets.symmetric(vertical: 12),
              child: TextField(
                controller: KMController,
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
                              Tankers[data]['bowser_capacity'] =
                                  int.parse(capController.text);
                              Tankers[data]['price_base'] =
                                  int.parse(baseController.text);
                              Tankers[data]['price_per_km'] =
                                  int.parse(KMController.text);
                
                            });
                            Navigator.of(context, rootNavigator: true).pop();
                            if (await _submit()) {
                              _showSnackBar('Package updated');
                            } else {
                              _showSnackBar('Couldn\'t update package');
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
