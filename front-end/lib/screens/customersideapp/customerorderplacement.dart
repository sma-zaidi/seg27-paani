import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:paani/screens/customersideapp/orderplacementpackage.dart';
import 'package:paani/screens/customersideapp/order_confirmation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:paani/screens/customersideapp/googlemaps/G_Map.dart';

class Place_Order_Screen extends StatefulWidget {
  var data;
  Place_Order_Screen({this.data});
  @override
  _Place_Order_ScreenState createState() =>
      _Place_Order_ScreenState(data: data);
}

class _Place_Order_ScreenState extends State<Place_Order_Screen> {
  var data;
  String delDate;
  _Place_Order_ScreenState({this.data});
  final ctrl1 = TextEditingController();
  final ctrl2 = TextEditingController();
  final ctrl3 = TextEditingController();
  var menuItems;
  var selected;
  void onChange() {
    if (ctrl3.text.length == 8) {
      String days = ctrl3.text.substring(0, 2);
      String month = ctrl3.text.substring(2, 4);
      String year = ctrl3.text.substring(4);
      String modifiedDate = days + "-" + month + "-" + year;
      ctrl3.text = modifiedDate;
    }
  }

  List<String> pkgIDs = [];
  String companyName;
  bool showDetails = false;

  @override
  void initState() {
    companyName = data['name'];
    menuItems = data['packages'];
    for (int i = 0; i < menuItems.length; i++) {
      pkgIDs.add(menuItems[i]['id'].toString());
    }
    print(data);
    // TODO: implement initState
    super.initState();
    // you can have different listner functions if you wish
    ctrl3.addListener(onChange);
  }

  int getPkgDetails(int pkg_id) {
    for (int i = 0; i < menuItems.length; i++) {
      if (pkg_id == menuItems[i]['id']) {
        return i;
      }
    }
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
                decoration: InputDecoration(
                  hintText: 'Address',
                  border: InputBorder.none,
                ),
                controller: ctrl1,
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
              child: FlatButton(
                onPressed: () async {
                  final position = await Geolocator().getCurrentPosition(
                      desiredAccuracy: LocationAccuracy.high);
                  dynamic result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              G_Map(position.latitude, position.longitude)));
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
                  border: InputBorder.none,
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
              child: ListTile(
                title: TextField(
                  decoration: InputDecoration(
                    hintText: 'DD-MM-YYYY',
                    border: InputBorder.none,
                  ),
                  controller: ctrl3,
                ),
                trailing: FlatButton(
                  child: Icon(
                    Icons.calendar_today,
                    color: Colors.teal,
                  ),
                  onPressed: () {
                    showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2020),
                            lastDate: DateTime(2021))
                        .then((date) {
                      if (date != null) {
                        String dateString = date.toString().substring(0, 10);
                        String day = dateString.substring(8, 10);
                        String month = dateString.substring(5, 7);
                        String year = dateString.substring(0, 4);
                        delDate = day + "-" + month + "-" + year;
                        print(delDate);
                        setState(() {
                          ctrl3.text = delDate;
                        });
                      }
                    });
                  },
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
            child: Center(
              child: DropdownButton<String>(
                items: pkgIDs.map((String pkg) {
                  return DropdownMenuItem<String>(
                    value: pkg,
                    child: Center(
                      child: Center(child: Text('Package: ${pkg}')),
                    ),
                  );
                }).toList(),
                hint: Text('Select Package'),
                onChanged: (String val) {
                  setState(() {
                    selected = val;
                    showDetails = true;
                  });
                  print(selected);
                },
                value: selected,
              ),
            ),
          ),
          showDetails == true
              ? Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Center(
                    child: Container(
                      width: 200,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                              'Capacity: ${menuItems[getPkgDetails(int.parse(selected))]['bowser_capacity']} litres'),
                          Text(
                              'Base Price: ${menuItems[getPkgDetails(int.parse(selected))]['price_base']} Rupees'),
                          Text(''
                              'Price per Km: ${menuItems[getPkgDetails(int.parse(selected))]['price_per_km']} Rupees'),
                        ],
                      ),
                    ),
                  ),
                )
              : Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Center(
                    child: Text('Please Select a Package to Proceed'),
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
                  Navigator.pushNamed(context, '/order_confirmation');
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}

