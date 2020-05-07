//This Screen will Display Orders Completed by Company

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CompletedOrders extends StatefulWidget {
  @override
  CompletedOrdersState createState() => new CompletedOrdersState();
}

class CompletedOrdersState extends State<CompletedOrders> {
  var completedOrders = [];
  var loadScreen = true; 
  Future<void> getCompletedOrders() async {
    
    SharedPreferences pref = await SharedPreferences.getInstance();
    var responseCompleted = await http.get(
        'https://seg27-paani-backend.herokuapp.com/orders/${pref.getString('userid')}/Complete');
    var dataBody = jsonDecode(responseCompleted.body);
    if (dataBody['error'] == false) {
      for (int i = 0; i < dataBody['msg'].length; i++) {
        var responseRating = await http.get(
            'https://seg27-paani-backend.herokuapp.com/orders/rating/${dataBody['msg'][i]['orderid'].toString()}');
        var dataRating = jsonDecode(responseRating.body);
        if (dataRating['msg'] == "No completed order!") {
          dataBody['msg'][i]['rating'] = null;
        } else {
          dataBody['msg'][i]['rating'] = dataRating['msg'][0]['rating'];
        }
      }
      setState(() {
        completedOrders = dataBody['msg'];
        loadScreen = false;
      });
    }
  }

  @override
  void initState() {
    getCompletedOrders();
  }

  Widget build(BuildContext context) {
    return loadScreen == true
        ? Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : Scaffold(
            appBar: new AppBar(
              backgroundColor: Colors.teal,
              centerTitle: true,
              title: Text(
                "Completed",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            body: ListView.separated(
              itemCount: completedOrders.length,
              itemBuilder: (BuildContext context, int index) {
                return Row(
                  children: <Widget>[
                    Container(
                      // width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.only(left: 10),
                      width: 180,
                      child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Order ID: ${completedOrders[index]['orderid']}",
                            style: TextStyle(
                              color: Colors.black45,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Driver ID: ${completedOrders[index]['driver_id']}",
                            style: TextStyle(
                              color: Colors.black45,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Address: ${completedOrders[index]['delivery_address']}",
                            style: TextStyle(
                              color: Colors.black45,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Package ID: ${completedOrders[index]['package_id']}",
                            style: TextStyle(
                              color: Colors.black45,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Deliver Date: ${completedOrders[index]['delivery_time']}",
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
                      width: 10,
                    ),
                    completedOrders[index]['rating'] == null
                        ? RatingBarIndicator(
                            itemSize: 30.0,
                            rating: 0,
                            // minRating: 1,
                            direction: Axis.horizontal,
                            itemCount: 5,
                            itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
                            itemBuilder: (context, _) => Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                          )
                        : RatingBarIndicator(
                            itemSize: 30.0,
                            rating: double.parse(
                                completedOrders[index]['rating'].toString()),
                            // minRating: 1,
                            direction: Axis.horizontal,
                            itemCount: 5,
                            itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
                            itemBuilder: (context, _) => Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                          )
                    // RaisedButton(
                    //   onPressed: () {},
                    //   child: Row(
                    //     children: <Widget>[
                    //       Text("Cancel"),
                    //       SizedBox(
                    //         width: 10,
                    //       ),
                    //       Icon(Icons.clear)
                    //     ],
                    //   ),
                    //   textColor: Colors.white,
                    //   color: Colors.teal,
                    // ),
                  ],
                );
              },
              separatorBuilder: (BuildContext context, int index) => Divider(),
            ),
          );
  }
}
