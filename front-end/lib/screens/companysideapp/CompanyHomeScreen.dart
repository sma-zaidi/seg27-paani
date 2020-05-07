import 'package:flutter/material.dart';
import 'package:badges/badges.dart';
import 'package:paani/screens/companysideapp/in_progress.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'new_requests_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:paani/screens/companysideapp/drawer.dart';

var newOrders = []; //All orders yet to be accepted or confirmed
var ongoingOrders = []; //Orders accepted by company
int inPro = 0; //Number of In progress orders
int newReq = 0; //Number of New Orders

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
  var errorPending; //Returns error if New Orders could not be loaded
  var errorOngoing; //Returns error if in progress errors could not be loaded

  Future<void> getOrders() async {
    //gets Orders from Server and adds them to specific variables
    SharedPreferences pref = await SharedPreferences.getInstance();
    print(pref.getString('userid'));
    //Getting New Orders
    var responsePending = await http.get(
        'https://seg27-paani-backend.herokuapp.com/orders/${pref.getString('userid')}/Pending');
    var dataPending = convert.jsonDecode(responsePending.body);
    if (dataPending['error'] == false) {
      setState(() {
        newOrders = dataPending['msg'];
        print(newOrders);
        errorPending = false;
        newReq = newOrders.length;
      });
    } else {
      setState(() {
        print(newOrders);
        errorPending = dataPending['error'];
        newReq = 0;
      });
    }
    //Getting In Progress Orders
    var responseOngoing = await http.get(
        'https://seg27-paani-backend.herokuapp.com/orders/${pref.getString('userid')}/Confirmed');
    var dataOngoingConfirmed = convert.jsonDecode(responseOngoing.body);
    var responseDispatched = await http.get(
        'https://seg27-paani-backend.herokuapp.com/orders/${pref.getString('userid')}/Dispatched');
    var dataOngoingDispatched = convert.jsonDecode(responseDispatched.body);
    if (dataOngoingConfirmed['error'] == false ||
        dataOngoingDispatched['error'] == false) {
      setState(() {
        if (dataOngoingConfirmed['msg'] != null &&
            dataOngoingDispatched['msg'] != null) {
          ongoingOrders = []
            ..addAll(dataOngoingConfirmed['msg'])
            ..addAll(dataOngoingDispatched['msg']);
        } else if (dataOngoingConfirmed['msg'] == null) {
          ongoingOrders = dataOngoingDispatched['msg'];
        } else if (dataOngoingDispatched['msg'] == null) {
          ongoingOrders = dataOngoingConfirmed['msg'];
        }
        errorOngoing = false;
        inPro = ongoingOrders.length;
      });
    } else {
      setState(() {
        errorOngoing = dataOngoingConfirmed['error'];

        inPro = 0;
      });
    }
  }

  @override
  initState() {
    super.initState();
    getOrders();
  }

  @override
  Widget build(BuildContext context) {
    return errorPending == null || errorOngoing == null //Till asynchronous getOrders function is working, screen keeps loading 
        ? Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.teal,
              actions: <Widget>[
                //Refresh Button to reload the screen to check for new orders
                FlatButton(
                  child: Icon(
                    Icons.refresh,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    setState(() {
                      errorPending = null;
                      errorOngoing = null;
                      getOrders();
                    });
                  },
                )
              ],
            ),
            drawer: DrawerDetails(),
            body: ListView(
              children: <Widget>[
                Image.asset('assets/logo_transparentbg.png'),
                FlatButton(
                  onPressed: () {
                    setState(() {
                      newReq = 0;
                    });
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => NewReqs()));
                  },
                  child: Card(
                    color: Colors.teal.shade300,
                    margin:
                        EdgeInsets.symmetric(horizontal: 40.0, vertical: 10.0),
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
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => InProgress()));
                  },
                  child: Card(
                    color: Colors.teal.shade300,
                    margin:
                        EdgeInsets.symmetric(horizontal: 40.0, vertical: 10.0),
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
