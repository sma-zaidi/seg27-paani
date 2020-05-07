import 'package:flutter/material.dart';
import 'package:paani/screens/customersideapp/order_receipt.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Order_Confirmation extends StatefulWidget {
  @override
  _Order_Confirmation_State createState() => _Order_Confirmation_State();
}

class _Order_Confirmation_State extends State<Order_Confirmation> {
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

  Map data;
  bool orderinprogress = false;
  bool datasent = false;
  void _submit() async {
    data.remove('companyname');
    data.remove('tankersize');
    if (data['delivery_location'] == null) {
      data['estimated_cost'] = null;
      data['cost'] = null;
    }
    try {
      this.setState(() {
        datasent = true;
      });
      var response = await http.post(
        'https://seg27-paani-backend.herokuapp.com/orders',
        body: jsonEncode(data),
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
          "Content-Type": "application/json",
        },
      );
      print(response.body);
      var message = json.decode(response.body);
      this.setState(() {
        datasent = false;
      });
      if (message["error"] == "Another order is in progress.") {
        this.setState(() {
          orderinprogress = true;
        });
      } else if (message["error"] == false) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => Order_Receipt()),
            (_) => false);
      } else {
        _showSnackBar(message["error"]);
      }
    } catch (e) {
      _showSnackBar("Network Issue, Your order could not be placed");
    }
  }

  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context).settings.arguments;
    print(data);
    return orderinprogress
        ? Scaffold(
            key: scaffoldKey,
            resizeToAvoidBottomPadding: false,
            appBar: AppBar(
              centerTitle: true,
              backgroundColor: Colors.teal,
              title: Text(
                "MY ORDER",
                style: TextStyle(fontSize: 23.0, letterSpacing: 1.5),
              ),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 180.0, 0.0, 20.0),
                child: Container(
                  margin: EdgeInsets.all(50.0),
                  child: Column(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Order Cannot be placed. \nAnother order is already in Progress!",
                          // textAlign: TextAlign.center,
                          style: TextStyle(
                            height: 1.3,
                            letterSpacing: 1.0,
                            color: Colors.grey[700],
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        : Scaffold(
            resizeToAvoidBottomPadding: false,
            key: scaffoldKey,
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                "MY ORDER",
                style: TextStyle(
                  fontSize: 23.0,
                  letterSpacing: 1.5,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 60.0, 0.0, 20.0),
                child: Container(
                  padding: EdgeInsets.fromLTRB(25.0, 40.0, 25.0, 30.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey[400]),
                    borderRadius: BorderRadius.circular(20.0),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  margin: EdgeInsets.all(30.0),
                  child: Column(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Company Name: ${data["companyname"]}",
                          // textAlign: TextAlign.center,
                          style: TextStyle(
                            letterSpacing: 1.0,
                            color: Colors.black,
                            fontSize: 17.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 40.0),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Address: ${data["delivery_address"]}",
                          // textAlign: TextAlign.center,
                          style: TextStyle(
                            letterSpacing: 1.0,
                            color: Colors.black,
                            fontSize: 17.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 40.0),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Estimated Cost: ${data["estimated_cost"]}",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            letterSpacing: 1.0,
                            color: Colors.black,
                            fontSize: 17.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 40.0),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Tanker Size: ${data["tankersize"]} Litres",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            letterSpacing: 1.0,
                            color: Colors.black,
                            fontSize: 17.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 120.0),
                      ButtonTheme(
                        minWidth: double.infinity,
                        height: 50.0,
                        buttonColor: Colors.teal,
                        child: RaisedButton(
                          color: Colors.teal,
                          onPressed: datasent ? null : _submit,
                          child: Text("Confirm Order",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  letterSpacing: 0.8,
                                  fontSize: 22.0)),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
