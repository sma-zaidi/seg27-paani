import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:sweetalert/sweetalert.dart';
import 'package:paani/screens/companysideapp/CompanyHomeScreen.dart';
import 'package:paani/screens/companysideapp/drawer.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text('New Requests'),
        centerTitle: true,
      ),
      body: ListView.separated(
        itemCount: orders.length,
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
                      Text('Order ID: ${orders[index].order_id}'),
                      Text('Address: ${orders[index].location}'),
                      Text('Tanker Size: ${orders[index].capacity} Litre'),
                      Text('Delivery Date: '),
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
                              style:
                                  TextStyle(color: Colors.teal, fontSize: 25.0),
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
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                  color: Colors.teal,
                                ),
                                onPressed: () {
                                  setState(() {
                                    orders.removeAt(index);
                                  });
                                  Navigator.of(context).pop();
                                  SweetAlert.show(context,
                                      style: SweetAlertStyle.success);
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
                                        style: TextStyle(color: Colors.white),
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
                              style:
                                  TextStyle(color: Colors.teal, fontSize: 25.0),
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
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                  color: Colors.teal,
                                ),
                                onPressed: () {
                                  setState(() {
                                    orders.removeAt(index);
                                  });
                                  Navigator.of(context).pop();
                                  SweetAlert.show(context,
                                      style: SweetAlertStyle.error);
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
                                        style: TextStyle(color: Colors.white),
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
