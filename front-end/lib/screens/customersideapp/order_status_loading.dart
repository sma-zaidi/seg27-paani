import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class OrderStatusLoading extends StatefulWidget {
  @override
  _OrderStatusLoadingState createState() => _OrderStatusLoadingState();
}

class _OrderStatusLoadingState extends State<OrderStatusLoading> {
  bool nodatafound = false;
  dynamic status;
  Future<void> getorders() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String id = pref.getString("userid");
    var response =
        await http.get('https://seg27-paani-backend.herokuapp.com/orders/22');
    var message = json.decode(response.body);
    if (message['msg'] is String) {
      setState(() {
        nodatafound = true;
      });
    } else {
      status = message['msg'];
      if (status['status'] == 'completed') {
        Navigator.popAndPushNamed(context, '/ordercompleted');
      } else if (status['status'] == 'dispatched') {
        Navigator.popAndPushNamed(context, '/orderdispatched');
      } else if (status['status'] == 'confirmed') {
        Navigator.popAndPushNamed(context, '/orderconfirmed');
      } else if (status['status'] == 'declined') {
        Navigator.popAndPushNamed(context, '/orderdeclined');
      } else if (status['status'] == 'pending') {
        Navigator.popAndPushNamed(context, '/orderpending');
      } else {
        Navigator.pop(context);
      }
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
    return nodatafound
        ? Scaffold(
            body: AlertDialog(
                backgroundColor: Colors.white,
                title: Center(child: Text('Order Status')),
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        'No recent Order Record Found',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      ),
                    )
                  ],
                ),
                actions: <Widget>[
                  FlatButton(
                      color: Colors.teal,
                      child: Text('Ok',
                          style: TextStyle(
                            color: Colors.white,
                          )),
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pop(context);
                      }),
                ]),
          )
        : Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
  }
}
