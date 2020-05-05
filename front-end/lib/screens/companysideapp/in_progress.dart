import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InProgress extends StatefulWidget {
  @override
  InProgressState createState() => new InProgressState();
}

class InProgressState extends State<InProgress> {
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: ListView.builder(itemBuilder: (BuildContext context, int index) {
        return Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 10),
              height: 100,
              width: 150,
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Order id:",
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
              width: 15,
            ),
            IconButton(
              icon: Image.asset('assets/confirmed.png'),
              iconSize: 50,
              onPressed: () {},
            ),
            SizedBox(
              width: 15,
            ),
            ButtonTheme(
              minWidth: 0,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              child: RaisedButton(
                onPressed: () {},
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
          ],
        );
      }),
    );
  }
}
