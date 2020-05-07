import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:sweetalert/sweetalert.dart';
import 'package:paani/screens/companysideapp/CompanyHomeScreen.dart';
import 'package:http/http.dart' as http;
import 'package:paani/screens/companysideapp/drawer.dart';

import 'CompanyHomeScreen.dart';

//final List<int> ordersID = <int>[1584, 2459, 3842, 4443, 5042, 6213, 7456];
//final List<String> address = <String>[
//  "123 A block",
//  "456 B block",
//  "789 C Block",
//  "586 K Block",
//  "360-C D Block",
//  "45 Ali Housing Colony",
//  "33 Huma Block, Allama Iqbal Town"
//]; //Address of Customers
//final List<int> tankerSize = <int>[
//  10,
//  25,
//  20,
//  50,
//  60,
//  25,
//  30
//]; //Tanker size in Litres
//final List<String> delDates = <String>[
//  "26-4-2020",
//  "26-4-2020",
//  "28-4-2020",
//  "29-4-2020",
//  "30-4-2020",
//  "2-5-2020",
//  "2-5-2020"
//]

class NewReqs extends StatefulWidget {
  @override
  _NewReqsState createState() => _NewReqsState();
}

class _NewReqsState extends State<NewReqs> {
  var errorPending = false;
  var errorOngoing = false;
  @override
  Widget build(BuildContext context) {
    return errorOngoing == true || errorPending == true
        ? Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.teal,
              title: Text('New Requests'),
              centerTitle: true,
            ),
            body: ListView.separated(
              itemCount: newOrders.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      SizedBox(
                        width: 165.0,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('Order ID: ${newOrders[index]['orderid']}'),
                            Text(
                                'Address: ${newOrders[index]['delivery_address']}'),
                            Text(
                                'Tanker Size: ${newOrders[index]['bowser_capacity']} Gallons'),
                            Text(
                                'Delivery Date: ${newOrders[index]['delivery_time']}'),
                          ],
                        ),
                      ),
                      FlatButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  backgroundColor: Colors.white,
                                  title: Text(
                                    'Accept Request',
                                    style: TextStyle(
                                        color: Colors.teal, fontSize: 25.0),
                                  ),
                                  actions: <Widget>[
                                    FlatButton(
                                      child: Card(
                                        child: SizedBox(
                                          height: 30.0,
                                          width: 50.0,
                                          child: Center(
                                            child: Text(
                                              'YES',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                        color: Colors.teal,
                                      ),
                                      onPressed: () async {
                                        Navigator.of(context).pop();
                                        var queryBody = {
                                          "order_id": newOrders[index]
                                              ["orderid"],
                                          "status": "Confirmed"
                                        };
                                        var query = await http.put(
                                          'https://seg27-paani-backend.herokuapp.com/orders',
                                          body: jsonEncode(queryBody),
                                          headers: {
                                            "Content-Type":
                                                "application/x-www-form-urlencoded",
                                            "Content-Type": "application/json",
                                          },
                                        );
                                        var data = jsonDecode(query.body);
                                        if (data['error'] == false) {
                                          setState(() {
                                            errorOngoing = true;
                                            errorPending = true;
                                          });
                                          SharedPreferences pref =
                                              await SharedPreferences
                                                  .getInstance();
                                          print(pref.getString('userid'));
                                          var responsePending = await http.get(
                                              'https://seg27-paani-backend.herokuapp.com/orders/${pref.getString('userid')}/Pending');
                                          var dataPending =
                                              jsonDecode(responsePending.body);
                                          if (dataPending['error'] == false) {
                                            setState(() {
                                              newOrders = dataPending['msg'];
                                              errorPending = false;
                                            });
                                          } else {
                                            setState(() {
                                              newOrders = [];
                                              errorPending = false;
                                            });
                                          }
                                          var responseOngoing = await http.get(
                                              'https://seg27-paani-backend.herokuapp.com/orders/${pref.getString('userid')}/Confirmed');
                                          var dataOngoing =
                                              jsonDecode(responseOngoing.body);
                                          if (dataOngoing['error'] == false) {
                                            setState(() {
                                              ongoingOrders =
                                                  dataOngoing['msg'];
                                              errorOngoing = false;
                                            });
                                          } else {
                                            setState(() {
                                              errorOngoing = false;
                                            });
                                          }
                                        }

//                                  setState(() async {
//                                    SharedPreferences pref = await SharedPreferences.getInstance();
//                                    print(pref.getString('userid'));
//                                    var responsePending = await http.get(
//                                        'https://seg27-paani-backend.herokuapp.com/orders/${pref.getString('userid')}/Pending');
//                                    var dataPending = jsonDecode(responsePending.body);
//                                  });

                                      //   SweetAlert.show(context,
                                            // style: SweetAlertStyle.success);
                                      },
                                    ),
                                    FlatButton(
                                      child: Card(
                                        child: SizedBox(
                                          height: 30.0,
                                          width: 50.0,
                                          child: Center(
                                            child: Text(
                                              'NO',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                        color: Colors.teal,
                                      ),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              });
                        },
                        child: Icon(
                          Icons.check_circle,
                          color: Colors.green,
                          size: 40.0,
                        ),
                      ),
                      FlatButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  backgroundColor: Colors.white,
                                  title: Text(
                                    'Cancel Request',
                                    style: TextStyle(
                                        color: Colors.teal, fontSize: 25.0),
                                  ),
                                  actions: <Widget>[
                                    FlatButton(
                                      child: Card(
                                        child: SizedBox(
                                          height: 30.0,
                                          width: 50.0,
                                          child: Center(
                                            child: Text(
                                              'YES',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                        color: Colors.teal,
                                      ),
                                      onPressed: () async {
                                        Navigator.of(context).pop();
                                        var queryBody = {
                                          "order_id": newOrders[index]
                                              ["orderid"],
                                          "status": "Rejected"
                                        };
                                        var query = await http.put(
                                          'https://seg27-paani-backend.herokuapp.com/orders',
                                          body: jsonEncode(queryBody),
                                          headers: {
                                            "Content-Type":
                                                "application/x-www-form-urlencoded",
                                            "Content-Type": "application/json",
                                          },
                                        );
                                        var data = jsonDecode(query.body);
                                        if (data['error'] == false) {
                                          setState(() {
                                            errorOngoing = true;
                                            errorPending = true;
                                          });
                                          SharedPreferences pref =
                                              await SharedPreferences
                                                  .getInstance();
                                          print(pref.getString('userid'));
                                          var responsePending = await http.get(
                                              'https://seg27-paani-backend.herokuapp.com/orders/${pref.getString('userid')}/Pending');
                                          var dataPending =
                                              jsonDecode(responsePending.body);
                                          if (dataPending['error'] == false) {
                                            setState(() {
                                              newOrders = dataPending['msg'];
                                              errorPending = false;
                                            });
                                          } else {
                                            setState(() {
                                              newOrders = [];
                                              errorPending = false;
                                            });
                                          }
                                          var responseOngoing = await http.get(
                                              'https://seg27-paani-backend.herokuapp.com/orders/${pref.getString('userid')}/Confirmed');
                                          var dataOngoing =
                                              jsonDecode(responseOngoing.body);
                                          if (dataOngoing['error'] == false) {
                                            setState(() {
                                              ongoingOrders =
                                                  dataOngoing['msg'];
                                              errorOngoing = false;
                                            });
                                          } else {
                                            setState(() {
                                              errorOngoing = false;
                                            });
                                          }
                                        }
                                        print(jsonDecode(query.body));
                                        // SweetAlert.show(context,
                                        //     style: SweetAlertStyle.error);
                                      },
                                    ),
                                    FlatButton(
                                      child: Card(
                                        child: SizedBox(
                                          height: 30.0,
                                          width: 50.0,
                                          child: Center(
                                            child: Text(
                                              'NO',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                        color: Colors.teal,
                                      ),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              });
                        },
                        child: Icon(
                          Icons.cancel,
                          color: Colors.red,
                          size: 40.0,
                        ),
                      ),
                    ],
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return Divider();
              },
            ),
          );
  }
}
