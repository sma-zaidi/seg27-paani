import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  dynamic pastorders;
  Future<void> getorders() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String id = pref.getString("userid");
    var response = await http
        .get('https://seg27-paani-backend.herokuapp.com/orders/history/22');
    var message = json.decode(response.body);
    if (message['msg'] is String) {
      pastorders = "No";
      Navigator.popAndPushNamed(context, '/orderhistory', arguments: {
        'messagetype': 'String',
        'messagebody': pastorders,
      });
    } else {
      pastorders = message['msg'];
      Navigator.popAndPushNamed(context, '/orderhistory', arguments: {
        'messagetype': 'List',
        'messagebody': pastorders,
      });
      // for (int i; i < message['msg'].length; i++) {
      //   pastorders.add(message['msg'].length);
      // }
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
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
