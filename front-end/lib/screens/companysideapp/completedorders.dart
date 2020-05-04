import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class CompletedOrders extends StatefulWidget {
  @override
  CompletedOrdersState createState() => new CompletedOrdersState();
}

class CompletedOrdersState extends State<CompletedOrders> {
  Widget build(BuildContext context) {
    List<int> order = [1, 2, 3, 4];
    return Scaffold(
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
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
                itemCount: order.length,
                itemBuilder: (BuildContext context, int index) {
                  return Row(
                    children: <Widget>[
                      Container(
                        // width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.only(left: 10),
                        height: 100,
                        child: new Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Order id: ",
                              style: TextStyle(
                                color: Colors.black45,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "Driver:",
                              style: TextStyle(
                                color: Colors.black45,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "Address:",
                              style: TextStyle(
                                color: Colors.black45,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "Package:",
                              style: TextStyle(
                                color: Colors.black45,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "Deliver Date:",
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
                        width: 80,
                      ),
                      RatingBarIndicator(
                        itemSize: 30.0,
                        rating: 3,
                        // minRating: 1,
                        direction: Axis.horizontal,
                        itemCount: 5,
                        itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
                        itemBuilder: (context, _) => Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                      ),
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
                }),
          ),
        ],
      ),
    );
  }
}
