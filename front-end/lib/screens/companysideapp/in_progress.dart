import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'CompanyHomeScreen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:shared_preferences/shared_preferences.dart';

class InProgress extends StatefulWidget {
  @override
  InProgressState createState() => new InProgressState();
}

class InProgressState extends State<InProgress> {
  var orders = ongoingOrders; //Orders has only in progress orders. ongoingOrders populated in previous screen
  bool loadingIcon = false; //if true, loading icon is shown
  Widget build(BuildContext context) {
    return loadingIcon == false
        ? Scaffold(
            appBar: new AppBar(
              backgroundColor: Colors.teal,
              centerTitle: true,
              title: Text(
                "In Progress",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            body: ListView.separated(
              itemBuilder: (BuildContext context, int index) {
                return Row(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(left: 10),
                      width: 135,
                      child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Order id: ${ongoingOrders[index]['orderid']}",
                            style: TextStyle(
                              color: Colors.black45,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "status: ${ongoingOrders[index]['status']}",
                            style: TextStyle(
                              color: Colors.black45,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Address: ${ongoingOrders[index]['delivery_address']}",
                            style: TextStyle(
                              color: Colors.black45,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Package ID: ${ongoingOrders[index]['id']}",
                            style: TextStyle(
                              color: Colors.black45,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Deliver Date: ${ongoingOrders[index]['delivery_time']}",
                            style: TextStyle(
                              color: Colors.black45,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        IconButton(
                          icon: Image.asset('assets/confirmed.png'),
                          iconSize: 50,
                          onPressed: () {},
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Text(
                          'status:',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        ButtonTheme(
                          minWidth: 0,
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          child: RaisedButton(
                            onPressed: () {
                              if (ongoingOrders[index]['driver_id'] == null) {
                                Navigator.pushNamed(
                                    context, "/viewdriverstankerloading",
                                    arguments: {
                                      'required': 'assigndrivers',
                                      "orderid": ongoingOrders[index]['orderid']
                                    });
                              } else {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text(
                                          'Error: Order already assinged to a Driver',
                                          style: TextStyle(color: Colors.teal),
                                        ),
                                        actions: <Widget>[
                                          FlatButton(
                                            child: Text(
                                              'OK',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            color: Colors.teal,
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                        ],
                                      );
                                    });
                              }
                            },
                            child: Row(
                              children: <Widget>[
                                Text(
                                  "Assign Driver",
                                  style: TextStyle(color: Colors.white),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Icon(
                                  Icons.person_add,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        ButtonTheme(
                          minWidth: 0,
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          child: RaisedButton(
                            onPressed: () {
                              String confirmedDate =
                                  ongoingOrders[index]['last_update'];
                              int confirmedYear =
                                  int.parse(confirmedDate.substring(0, 4));
                              int confirmedMonth =
                                  int.parse(confirmedDate.substring(5, 7));
                              int confirmedDay =
                                  int.parse(confirmedDate.substring(8, 10));
                              int confirmedHour =
                                  int.parse(confirmedDate.substring(11, 13));
                              int confirmedMinute =
                                  int.parse(confirmedDate.substring(14, 16));
                              DateTime confirmed = DateTime(
                                  confirmedYear,
                                  confirmedMonth,
                                  confirmedDay,
                                  confirmedHour,
                                  confirmedMinute);
                              print(confirmed);
                              DateTime now = DateTime.now();
                              print(now);
                              var difference = now.difference(confirmed);
                              print(difference.inHours);
                              if (difference.inHours >= 48) {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text(
                                          'Error: Cannot Cancel Order After 48 hours of Accepting',
                                          style: TextStyle(color: Colors.teal),
                                        ),
                                        actions: <Widget>[
                                          FlatButton(
                                            child: Text(
                                              'OK',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            color: Colors.teal,
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          )
                                        ],
                                      );
                                    });
                              } else {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text(
                                          'Cancel Order?',
                                          style: TextStyle(color: Colors.teal),
                                        ),
                                        actions: <Widget>[
                                          FlatButton(
                                            child: Text(
                                              'YES',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            color: Colors.teal,
                                            onPressed: () async {
                                              Navigator.of(context).pop();
                                              setState(() {
                                                loadingIcon = true;
                                              });
                                              var queryBody = {
                                                "order_id": ongoingOrders[index]
                                                    ["orderid"],
                                                "status": "Cancelled"
                                              };
                                              var query = await http.put(
                                                'https://seg27-paani-backend.herokuapp.com/orders',
                                                body: convert
                                                    .jsonEncode(queryBody),
                                                headers: {
                                                  "Content-Type":
                                                      "application/x-www-form-urlencoded",
                                                  "Content-Type":
                                                      "application/json",
                                                },
                                              );
                                              print(convert
                                                  .jsonDecode(query.body));
                                              SharedPreferences pref =
                                                  await SharedPreferences
                                                      .getInstance();
                                              var responseOngoing = await http.get(
                                                  'https://seg27-paani-backend.herokuapp.com/orders/${pref.getString('userid')}/Confirmed');
                                              var dataOngoingConfirmed =
                                                  convert.jsonDecode(
                                                      responseOngoing.body);
                                              var responseDispatched =
                                                  await http.get(
                                                      'https://seg27-paani-backend.herokuapp.com/orders/${pref.getString('userid')}/Dispatched');
                                              var dataOngoingDispatched =
                                                  convert.jsonDecode(
                                                      responseDispatched.body);
                                              if (dataOngoingConfirmed[
                                                          'error'] ==
                                                      false ||
                                                  dataOngoingDispatched[
                                                          'error'] ==
                                                      false) {
                                                setState(() {
                                                  if (dataOngoingConfirmed[
                                                              'msg'] !=
                                                          null &&
                                                      dataOngoingDispatched[
                                                              'msg'] !=
                                                          null) {
                                                    ongoingOrders = []
                                                      ..addAll(
                                                          dataOngoingConfirmed[
                                                              'msg'])
                                                      ..addAll(
                                                          dataOngoingDispatched[
                                                              'msg']);
                                                  } else if (dataOngoingConfirmed[
                                                          'msg'] ==
                                                      null) {
                                                    ongoingOrders =
                                                        dataOngoingDispatched[
                                                            'msg'];
                                                  } else if (dataOngoingDispatched[
                                                          'msg'] ==
                                                      null) {
                                                    ongoingOrders =
                                                        dataOngoingConfirmed[
                                                            'msg'];
                                                  }
                                                  loadingIcon = false;
                                                  inPro = ongoingOrders.length;
                                                });
                                              } else {
                                                setState(() {
                                                  ongoingOrders.clear();
                                                  loadingIcon = false;
                                                  inPro = 0;
                                                });
                                              }
                                            },
                                          ),
                                          FlatButton(
                                            color: Colors.teal,
                                            child: Text(
                                              'NO',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          )
                                        ],
                                      );
                                    });
                              }
                            },
                            child: Row(
                              children: <Widget>[
                                Text("Cancel"),
                                SizedBox(
                                  width: 10,
                                ),
                                Icon(Icons.clear)
                              ],
                            ),
                            textColor: Colors.white,
                            color: Colors.teal,
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        DropdownButton<String>(
                          value: ongoingOrders[index]['status'].toString(),
                          isDense: true,
                          items: <String>['Confirmed', 'Dispatched', 'Complete']
                              .map((String value) {
                            return new DropdownMenuItem<String>(
                              value: value,
                              child: new Text(value),
                            );
                          }).toList(),
                          onChanged: (value) {
                            if (value != 'Confirmed') {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text(
                                        'Change Order status to $value?',
                                        style: TextStyle(color: Colors.teal),
                                      ),
                                      actions: <Widget>[
                                        FlatButton(
                                          child: Text(
                                            'YES',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          color: Colors.teal,
                                          onPressed: () async {
                                            Navigator.of(context).pop();
                                            setState(() {
                                              loadingIcon = true;
                                            });
                                            var queryBody = {
                                              "order_id": ongoingOrders[index]
                                                  ["orderid"],
                                              "status": value
                                            };
                                            var query = await http.put(
                                              'https://seg27-paani-backend.herokuapp.com/orders',
                                              body:
                                                  convert.jsonEncode(queryBody),
                                              headers: {
                                                "Content-Type":
                                                    "application/x-www-form-urlencoded",
                                                "Content-Type":
                                                    "application/json",
                                              },
                                            );
                                            print(
                                                convert.jsonDecode(query.body));
                                            SharedPreferences pref =
                                                await SharedPreferences
                                                    .getInstance();
                                            var responseOngoing = await http.get(
                                                'https://seg27-paani-backend.herokuapp.com/orders/${pref.getString('userid')}/Confirmed');
                                            var dataOngoingConfirmed =
                                                convert.jsonDecode(
                                                    responseOngoing.body);
                                            var responseDispatched = await http.get(
                                                'https://seg27-paani-backend.herokuapp.com/orders/${pref.getString('userid')}/Dispatched');
                                            var dataOngoingDispatched =
                                                convert.jsonDecode(
                                                    responseDispatched.body);
                                            if (dataOngoingConfirmed['error'] ==
                                                    false ||
                                                dataOngoingDispatched[
                                                        'error'] ==
                                                    false) {
                                              setState(() {
                                                if (dataOngoingConfirmed[
                                                            'msg'] !=
                                                        null &&
                                                    dataOngoingDispatched[
                                                            'msg'] !=
                                                        null) {
                                                  ongoingOrders = []
                                                    ..addAll(
                                                        dataOngoingConfirmed[
                                                            'msg'])
                                                    ..addAll(
                                                        dataOngoingDispatched[
                                                            'msg']);
                                                } else if (dataOngoingConfirmed[
                                                        'msg'] ==
                                                    null) {
                                                  ongoingOrders =
                                                      dataOngoingDispatched[
                                                          'msg'];
                                                } else if (dataOngoingDispatched[
                                                        'msg'] ==
                                                    null) {
                                                  ongoingOrders =
                                                      dataOngoingConfirmed[
                                                          'msg'];
                                                }
                                                loadingIcon = false;
                                                inPro = ongoingOrders.length;
                                              });
                                            } else {
                                              setState(() {
                                                ongoingOrders.clear();
                                                loadingIcon = false;
                                                inPro = 0;
                                              });
                                            }
                                          },
                                        ),
                                        FlatButton(
                                          color: Colors.teal,
                                          child: Text(
                                            'NO',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        )
                                      ],
                                    );
                                  });
                            }
                          },
                        )
                      ],
                    ),
                  ],
                );
              },
              itemCount: ongoingOrders.length,
              separatorBuilder: (BuildContext context, int index) => Divider(),
            ),
          )
        : Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
  }
}
