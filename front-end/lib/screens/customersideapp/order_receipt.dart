//Shows Details and estimated Cost of an order

import 'package:flutter/material.dart';

class Order_Receipt extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          backgroundColor: Colors.teal,
          title: Center(
            child: Text(
              "MY ORDER",
              style: TextStyle(fontSize: 23.0, letterSpacing: 1.5),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 80.0, 0.0, 20.0),
            child: Container(
              margin: EdgeInsets.all(50.0),
              child: Column(
                children: <Widget>[
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Your order request has been sent!",
                      // textAlign: TextAlign.center,
                      style: TextStyle(
                        letterSpacing: 1.0,
                        color: Colors.grey[700],
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 50.0),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Please await confirmation",
                      // textAlign: TextAlign.center,
                      style: TextStyle(
                        letterSpacing: 1.0,
                        color: Colors.grey[800],
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 120.0),
                  ButtonTheme(
                    minWidth: 250,
                    height: 50.0,
                    buttonColor: Colors.blue,
                    child: RaisedButton.icon(
                      color: Colors.teal,
                      icon: Icon(
                        Icons.home,
                        color: Colors.white,
                        size: 40.0,
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, '/customerhomescreen');
                        // Navigator.popUntil(
                        //     context, ModalRoute.withName('/customerhomescreen'));
                      },
                      label: Text("Home",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              letterSpacing: 0.8,
                              fontSize: 28.0)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
