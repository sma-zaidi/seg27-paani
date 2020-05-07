import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:paani/screens/customersideapp/googlemaps/G_Map.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Place_Order_Screen extends StatefulWidget {
  var data;
  Place_Order_Screen({this.data});
  @override
  _Place_Order_ScreenState createState() =>
      _Place_Order_ScreenState(data: data);
}

class _Place_Order_ScreenState extends State<Place_Order_Screen> {
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

  var data;
  String delDate;
  _Place_Order_ScreenState({this.data});
  final ctrl1 = TextEditingController();
  final ctrl2 = TextEditingController();
  final ctrl3 = TextEditingController();
  var menuItems;
  var selected;
  var distance;
  void onChange() {
    if (ctrl3.text.length == 8) {
      String days = ctrl3.text.substring(0, 2);
      String month = ctrl3.text.substring(2, 4);
      String year = ctrl3.text.substring(4);
      String modifiedDate = days + "-" + month + "-" + year;
      ctrl3.text = modifiedDate;
    }
  }

  void checkdistance(double currlat, double currlong) async {
    Map s = json.decode(data['location']);
    distance = await new Geolocator().distanceBetween(
        currlat, currlong, s['latitude'].toDouble(), s['longitude'].toDouble());
  }

  List<String> pkgIDs = [];
  String companyName;
  bool showDetails = false;
  bool locationset = false;
  dynamic contact;
  dynamic address;
  dynamic _location;
  bool pageloading = false;

  double cost(double dis, int base_price, int price_per_km) {
    var cal_cost = base_price + (price_per_km * (dis / 1000)).round();
    return ((cal_cost + 4) / 5) * 5;
  }

  void _submit() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var userid = pref.getString('userid');
    if (_formKey.currentState.validate()) {
      if ((ctrl3.text != null || ctrl3.text != "") && selected != null) {
        var requestbody = {
          "companyname": companyName,
          "tankersize": menuItems[getPkgDetails(int.parse(selected))]
                  ['bowser_capacity']
              .toString(),
          "customer_id": userid,
          "package_id": selected,
          "delivery_address": ctrl1.text,
          "delivery_location": _location,
          "delivery_time": ctrl3.text,
          "estimated_cost": _location == null
              ? "N/A. To get estimated cost, set your current location."
              : cost(
                          distance,
                          menuItems[getPkgDetails(int.parse(selected))]
                              ['price_base'],
                          menuItems[getPkgDetails(int.parse(selected))]
                              ['price_per_km'])
                      .toString() +
                  " Rps",
          "cost": _location == null
              ? "N/A. To get estimated cost, set your current location."
              : cost(
                          distance,
                          menuItems[getPkgDetails(int.parse(selected))]
                              ['price_base'],
                          menuItems[getPkgDetails(int.parse(selected))]
                              ['price_per_km'])
                      .toString() +
                  " Rps",
        };
        Navigator.pushNamed(context, '/order_confirmation',
            arguments: requestbody);
      } else {
        _showSnackBar("One or more fields are empty");
      }
    }
  }

  @override
  void initState() {
    companyName = data['name'];
    menuItems = data['packages'];
    for (int i = 0; i < menuItems.length; i++) {
      pkgIDs.add(menuItems[i]['id'].toString());
    }
    // TODO: implement initState
    super.initState();
    // you can have different listner functions if you wishs
    ctrl3.addListener(onChange);
  }

  int getPkgDetails(int pkg_id) {
    for (int i = 0; i < menuItems.length; i++) {
      if (pkg_id == menuItems[i]['id']) {
        return i;
      }
    }
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          alignment: Alignment.center,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          'My Order',
          style: TextStyle(
            color: Colors.white,
            letterSpacing: 1.5,
            fontSize: 18.0,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30, top: 20),
              child: Text(
                '${companyName}',
                style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.black54,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30, top: 20),
              child: Card(
                child: TextFormField(
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return 'Address is required';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: 'Address',
                    labelText: 'Address',
                    suffixIcon: const Icon(

                      Icons.view_compact,
                      color: Colors.teal,
                    ),
                    border: OutlineInputBorder(
                      borderSide: new BorderSide(color: Colors.teal),
                    ),
                  ),
                  controller: ctrl1,
                ),
              ),
            ),
            Center(
              child: Text(
                'OR',
                style: TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30, top: 8),
              child: Card(
                color: Colors.teal,
                child: FlatButton(
                  onPressed: pageloading
                      ? null
                      : () async {
                          this.setState(() {
                            pageloading = true;
                          });
                          final position = await Geolocator()
                              .getCurrentPosition(
                                  desiredAccuracy: LocationAccuracy.high);
                          dynamic result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => G_Map(
                                      position.latitude, position.longitude)));
                          this.setState(() {
                            pageloading = false;
                          });
                          if (result != null) {
                            setState(() {
                              _location = result.toString();
                              locationset = true;
                              checkdistance(
                                  result['latitude'], result['longitude']);
                            });
                          }
                          // }
                        },
                  child: ListTile(
                    title: Center(
                      child: Text(
                        'CURRENT LOCATION',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.5,
                            fontSize: 16),
                      ),
                    ),
                    trailing: Align(
                      widthFactor: 0,
                      child: Icon(
                        Icons.location_on,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            locationset
                ? Padding(
                    padding: EdgeInsets.all(0.0),
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 30.0,
                            bottom: 0,
                            right: 30.0,
                          ),
                          child: Text(
                            "Your location has been set",
                            style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(width: 47.0),
                        IconButton(
                            icon: Icon(
                              Icons.cancel,
                              color: Colors.red,
                            ),
                            onPressed: () {
                              setState(() {
                                _location = null;
                                locationset = false;
                              });
                            })
                      ],
                    ),
                  )
                : SizedBox(height: 0.0),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30, top: 20),
              child: Card(
                child: TextFormField(
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return ("Contact Number is required");
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: '03001234567',
                    labelText: 'Contact Number',
                    suffixIcon: const Icon(
                      Icons.call,
                      color: Colors.teal,
                    ),
                    border: OutlineInputBorder(
                        borderSide: new BorderSide(color: Colors.teal)),
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    WhitelistingTextInputFormatter.digitsOnly
                  ],
                  controller: ctrl2,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30, top: 20),
              child: Card(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'DD-MM-YYYY',
                    border: OutlineInputBorder(
                        borderSide: new BorderSide(color: Colors.teal)),
                    labelText: 'Delivery Date',
                    suffixIcon: ButtonTheme(
                      minWidth: 0,
                      child: FlatButton(
                        child: const Icon(
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
                              String dateString =
                                  date.toString().substring(0, 10);
                              String day = dateString.substring(8, 10);
                              String month = dateString.substring(5, 7);
                              String year = dateString.substring(0, 4);
                              delDate = day + "-" + month + "-" + year;
                              setState(() {
                                ctrl3.text = delDate;
                              });
                            }
                          });
                        },
                      ),
                    ),
                  ),
                  controller: ctrl3,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 40, right: 30, top: 10),
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
                  hint: Text(
                    'Select Package',
                    style: TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5),
                  ),
                  onChanged: (String val) {
                    setState(() {
                      selected = val;
                      showDetails = true;
                    });
                    return Text(
                      selected,
                      style: TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.5),
                    );
                  },
                  value: selected,
                ),
              ),
            ),
            showDetails == true
                ? Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Center(
                      child: Container(
                        width: 200,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'Capacity: ${menuItems[getPkgDetails(int.parse(selected))]['bowser_capacity']} litres',
                              style: TextStyle(
                                color: Colors.black54,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Base Price: ${menuItems[getPkgDetails(int.parse(selected))]['price_base']} Rupees',
                              style: TextStyle(
                                color: Colors.black54,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              ''
                              'Price per Km: ${menuItems[getPkgDetails(int.parse(selected))]['price_per_km']} Rupees',
                              style: TextStyle(
                                color: Colors.black54,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                : Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Center(
                      child: Text(
                        'Please Select a Package to Proceed',
                        style: TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                    ),
                  ),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30, top: 10),
              child: Card(
                color: Colors.teal,
                child: FlatButton(
                  child: Text(
                    'PLACE ORDER',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5,
                        fontSize: 16),
                  ),
                  onPressed: _submit,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
