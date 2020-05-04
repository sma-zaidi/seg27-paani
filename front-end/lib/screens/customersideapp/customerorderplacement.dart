import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:paani/screens/customersideapp/orderplacementpackage.dart';
import 'package:paani/screens/customersideapp/order_confirmation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:paani/screens/customersideapp/googlemaps/G_Map.dart';
import 'package:paani/globals.dart' as globals;

class Place_Order_Screen extends StatefulWidget {
  var data;
  Place_Order_Screen({this.data});
  @override
  _Place_Order_ScreenState createState() =>
      _Place_Order_ScreenState(data: data);
}

class _Place_Order_ScreenState extends State<Place_Order_Screen> {
  var data;
  _Place_Order_ScreenState({this.data});
  static Package pkg1 = Package.forPractice(1, 1001, 50, 3500, 3.5);
  static Package pkg2 = Package.forPractice(2, 1001, 25, 2000, 3.3);
  static Package pkg3 = Package.forPractice(3, 1001, 30, 2300, 3.6);
  // final ctrl1 = TextEditingController();
  final ctrl2 = TextEditingController();
  final ctrl3 = TextEditingController();
  String address;
  String contact;
  bool locationset = false;
  List<DropdownMenuItem<Package>> menuItems =
      [pkg1, pkg2, pkg3].map<DropdownMenuItem<Package>>((Package pkg) {
    return DropdownMenuItem<Package>(
      value: pkg,
      child: Center(child: Text(pkg.tankerCap.toString())),
    );
  }).toList();
  Package selectedPkg;
  void onChange() {
    if (ctrl3.text.length == 8) {
      String days = ctrl3.text.substring(0, 2);
      String month = ctrl3.text.substring(2, 4);
      String year = ctrl3.text.substring(4);
      String modifiedDate = days + "-" + month + "-" + year;
      ctrl3.text = modifiedDate;
    }
  }

  String companyName;

  @override
  void initState() {
    companyName = data;
    // TODO: implement initState
    super.initState();
    // you can have different listner functions if you wish
    ctrl2.addListener(() {
      contact = ctrl2.text;
    });
    ctrl3.addListener(onChange);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: FlatButton(
          child: Icon(
            Icons.keyboard_backspace,
            color: Colors.white,
            size: 22.0,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          'My Order',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22.0,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
            child: Text(
              '${companyName}',
              style: TextStyle(
                fontSize: 18.0,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
            child: Text('Address'),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Card(
              margin: EdgeInsets.symmetric(vertical: 12.0),
              child: TextField(
                enabled: locationset ? false : true,
                decoration: InputDecoration(
                  hintText: 'Address',
                ),
                // controller: ctrl1,
                onChanged: (text) {
                  address = text;
                },
              ),
            ),
          ),
          Center(
            child: Text('or'),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
            child: Card(
              color: Colors.teal,
              child: Column(
                children: <Widget>[
                  FlatButton(
                    onPressed: () async {
                      final position = await Geolocator().getCurrentPosition(
                          desiredAccuracy: LocationAccuracy.high);
                      dynamic result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => G_Map(
                                  position.latitude, position.longitude)));
                      if (result != null) {
                        setState(() {
                          address = result.toString();
                          locationset = true;
                        });
                      }
                    },
                    child: ListTile(
                      title: Center(
                        child: Text(
                          'Current Location',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      trailing: Icon(
                        Icons.location_on,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  locationset
                      ? Padding(
                          padding:
                              const EdgeInsets.fromLTRB(20.0, 8.0, 20.0, 8.0),
                          child: Text("Your location has been set"),
                        )
                      : null,
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
            child: Text('Contact Number'),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Card(
              margin: EdgeInsets.symmetric(vertical: 12.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: '03001234567',
                ),
                controller: ctrl2,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
            child: Text('Delivery Date'),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Card(
              margin: EdgeInsets.symmetric(vertical: 12.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'DD/MM/YYYY',
                ),
                controller: ctrl3,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
            child: Center(
              child: DropdownButton<Package>(
                items: menuItems,
                hint: Text('Select Tanker Capacity'),
                onChanged: (Package pkg) {
                  setState(() {
                    selectedPkg = pkg;
                  });
                },
                value: selectedPkg,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
            child: Card(
              color: Colors.teal,
              margin: EdgeInsets.symmetric(vertical: 12.0),
              child: FlatButton(
                child: Text(
                  'Place Order',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onPressed: () async {
                  Map<String, dynamic> requestBody = {
                    "customer_id": 1,
                    "package_id": 1,
                  };
                  http.Response response = await http.post(
                    'https://seg27-paani-backend.herokuapp.com/orders',
                    body: jsonEncode(requestBody),
                    headers: {
                      "Content-Type": "application/x-www-form-urlencoded",
                      "Content-Type": "application/json",
                    },
                  );
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Order_Confirmation()));
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
