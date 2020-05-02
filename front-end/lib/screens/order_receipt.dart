import 'package:flutter/material.dart';

class Order_Receipt extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text(
              "MY ORDER",
              style: TextStyle(fontSize: 23.0, letterSpacing: 1.5),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(0.0, 60.0, 0.0, 20.0),
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
                      color: Colors.black,
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
                      color: Colors.black,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 70.0),
                ButtonTheme(
                  minWidth: double.infinity,
                  height: 50.0,
                  buttonColor: Colors.blue,
                  child: RaisedButton.icon(
                    icon: Icon(Icons.hourglass_empty),
                    onPressed: null,
                    label: Text("Order Status",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            letterSpacing: 0.8,
                            fontSize: 22.0)),
                  ),
                ),
                SizedBox(height: 50.0),
                ButtonTheme(
                  minWidth: double.infinity,
                  height: 50.0,
                  buttonColor: Colors.blue,
                  child: RaisedButton.icon(
                    icon: Icon(Icons.home),
                    onPressed: null,
                    label: Text("Home",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            letterSpacing: 0.8,
                            fontSize: 22.0)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
