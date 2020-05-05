import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:paani/screens/companysideapp/RegisterTanker.dart';

class TankerDetails extends StatefulWidget {
  @override
  TankerDetailsState createState() => new TankerDetailsState();
}

class TankerDetailsState extends State<TankerDetails> {
  Widget build(BuildContext context) {
    List<int> order = [1, 2, 3, 4];
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.teal,
        centerTitle: true,
        title: Text(
          "Tankers",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.add,
                color: Colors.white,
                size: 20.0,
              ),
              onPressed: () {
                MaterialPageRoute(builder: (context) => RegisterTankerScreen());
              })
        ],
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
                              "Tanker Size: ",
                              style: TextStyle(
                                color: Colors.black45,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "Base Price:",
                              style: TextStyle(
                                color: Colors.black45,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "Price Per Km:",
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
                    ],
                  );
                }),
          ),
        ],
      ),
    );
  }
}
