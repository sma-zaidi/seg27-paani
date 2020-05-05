import 'package:flutter/material.dart';
import 'package:paani/screens/customersideapp/order_receipt.dart';

class Order_Confirmation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Order_Confirmation_scaff());
  }
}

class Order_Confirmation_scaff extends StatelessWidget {
  var _baseprice = 5;
  var _priceperkm = 20;
  var _estimatedcost = 20;
  var _tankersize = 5;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                alignment: Alignment.centerLeft,
                child: Text(
                  "Base Price:  $_baseprice",
                  // textAlign: TextAlign.center,
                  style: TextStyle(
                    letterSpacing: 1.0,
                    color: Colors.black,
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 50.0),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Price/km:  $_priceperkm",
                  // textAlign: TextAlign.center,
                  style: TextStyle(
                    letterSpacing: 1.0,
                    color: Colors.black,
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 50.0),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Estimated Cost:  $_estimatedcost",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    letterSpacing: 1.0,
                    color: Colors.black,
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 50.0),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Tanker Size:  $_tankersize",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    letterSpacing: 1.0,
                    color: Colors.black,
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 70.0),
              ButtonTheme(
                minWidth: double.infinity,
                height: 50.0,
                buttonColor: Colors.blue,
                child: RaisedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Order_Receipt()));
                  },
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
    );
  }
}
