import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Driver_Tanker_Loading extends StatefulWidget {
  @override
  _Driver_Tanker_LoadingState createState() => _Driver_Tanker_LoadingState();
}

class _Driver_Tanker_LoadingState extends State<Driver_Tanker_Loading> {
  Map data;
  dynamic driversTankersData;
  Future<void> getorders() async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      String id = pref.getString("userid");
      if (data['required'] == "editdrivers") {
        var response = await http
            .get('https://seg27-paani-backend.herokuapp.com/drivers/$id');
        var message = json.decode(response.body);
        print(message);
        if (message['error'] == false && !message['msg'].isEmpty) {
          driversTankersData = message['msg'];
          Navigator.popAndPushNamed(context, '/viewdrivers', arguments: {
            'list': driversTankersData,
          });
        } else {
          Navigator.popAndPushNamed(context, '/viewdrivers', arguments: {
            'list': "No",
          });
        }
      } else if (data['required'] == "tankers") {
        var response = await http
            .get('https://seg27-paani-backend.herokuapp.com/packages/$id');
        var message = json.decode(response.body);
        // print(message);
        if (message['error'] == false && !message['msg'].isEmpty) {
          driversTankersData = message['msg'];
          Navigator.popAndPushNamed(context, '/viewtankers', arguments: {
            'list': driversTankersData,
          });
        } else {
          Navigator.popAndPushNamed(context, '/viewtankers', arguments: {
            'list': "No",
          });
        }
      } else if (data['required'] == "assigndrivers") {
        var response = await http
            .get('https://seg27-paani-backend.herokuapp.com/drivers/$id');
        var message = json.decode(response.body);
        if (message['error'] == false && !message['msg'].isEmpty) {
          driversTankersData = message['msg'];
          Navigator.popAndPushNamed(context, '/assigndriver', arguments: {
            'list': driversTankersData,
          });
        } else {
          Navigator.popAndPushNamed(context, '/assigndriver', arguments: {
            'list': "No",
          });
        }
      } else {
        Navigator.pop(context);
      }
    } catch (e) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(
                'Can not connect to the server!',
                style: TextStyle(color: Colors.teal),
              ),
              actions: <Widget>[
                FlatButton(
                  color: Colors.teal,
                  child: Text(
                    'YES',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getorders();
  }

  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
