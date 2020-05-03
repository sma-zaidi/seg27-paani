import 'package:flutter/material.dart';
import 'package:badges/badges.dart';
import 'new_requests_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class Order {
  int order_id;
  int capacity;
  String location;

  Order({this.order_id, this.capacity, this.location});

  factory Order.fromJSON(Map<String, dynamic> json) {
    return Order(
      order_id: json['order_id'],
      capacity: json['bowser_capacity'],
      location: json['location'],
    );
  }
}

List<Order> orders = [];

Future<void> getOrders() async {
  var response =
      await http.get('https://seg27-paani-backend.herokuapp.com/orders');
  var extractedData = convert.jsonDecode(response.body);
  List loadedOrders = extractedData['message'];
  for (var i in loadedOrders) {
    orders.add(Order(
        order_id: i['order_id'],
        location: i['location'],
        capacity: i['bowser_capacity']));
  }
}

Badge getBadge(int a, int b) {
  // a is number that badge will show
  // b is the icon type. 0 = playlist_add and 1 = access_time
  if (a > 0 && b == 0) {
    return Badge(
      badgeColor: Colors.red,
      badgeContent: Text(
        '$a',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      child: Icon(
        Icons.playlist_add,
        color: Colors.white,
        size: 40.0,
      ),
      position: BadgePosition.topRight(),
    );
  } else if (a == 0 && b == 0) {
    return Badge(
      badgeColor: Colors.teal.shade300,
      child: Icon(
        Icons.playlist_add,
        color: Colors.white,
        size: 40.0,
      ),
    );
  } else if (a > 0 && b == 1) {
    return Badge(
      badgeColor: Colors.red,
      badgeContent: Text(
        '$a',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      child: Icon(
        Icons.access_time,
        color: Colors.white,
        size: 40.0,
      ),
      position: BadgePosition.topRight(),
    );
  } else {
    return Badge(
      badgeColor: Colors.teal.shade300,
      child: Icon(
        Icons.access_time,
        color: Colors.white,
        size: 40.0,
      ),
    );
  }
}

class CompanyHomeScreen extends StatefulWidget {
  @override
  _CompanyHomeScreenState createState() => _CompanyHomeScreenState();
}

class _CompanyHomeScreenState extends State<CompanyHomeScreen> {
  @override
  initState() {
    super.initState();
    getOrders();
  }

  int inPro = 11;
  int newReq = orders.length;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        leading: FlatButton(
          child: Icon(
            Icons.menu,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset('images/logo_transparentbg.png'),
          FlatButton(
            onPressed: () {
              setState(() {
                newReq = 0;
              });
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => NewReqInit()));
            },
            child: Card(
              color: Colors.teal.shade300,
              margin: EdgeInsets.symmetric(horizontal: 40.0, vertical: 10.0),
              child: ListTile(
                title: Text(
                  'New Requests',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 21.0,
                      fontWeight: FontWeight.bold),
                ),
                trailing: getBadge(newReq, 0),
              ),
            ),
          ),
          FlatButton(
            onPressed: () {
              setState(() {
                inPro = 0;
              });
            },
            child: Card(
              color: Colors.teal.shade300,
              margin: EdgeInsets.symmetric(horizontal: 40.0, vertical: 10.0),
              child: ListTile(
                title: Text(
                  'In Progress',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 21.0,
                      fontWeight: FontWeight.bold),
                ),
                trailing: getBadge(inPro, 1),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
