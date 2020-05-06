/*
  Defines the sliding menu on the customer home screen.
*/

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:paani/screens/index.dart';
import 'package:paani/screens/customersideapp/customer_home_screen.dart';
import 'package:paani/screens/customersideapp/customereditprofile.dart';
import 'package:paani/screens/customersideapp/order_history_customer_loading.dart';
import 'package:paani/screens/customersideapp/order_status_loading.dart';

class DrawerDetails extends StatefulWidget {
  @override
  DrawerDetailsState createState() => DrawerDetailsState();
}

class DrawerDetailsState extends State<DrawerDetails> {
  Future<String> getName() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String name = pref.getString("username");
    return name;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
        future: getName(),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          if (snapshot.hasData) {
            return drawer('${snapshot.data}', context);
          } else { // something went wrong. Probably better to log the user out here
            return drawer('?', context);
          }
        });
  }

  Widget drawer(String name, BuildContext context) {
    return Drawer(
      child: new Column(
        children: <Widget>[
          //profile
          new Container(
            width: double.infinity, //expand for the entire drawer
            padding: EdgeInsets.all(20),
            color: Colors.teal,
            child: new Center(
              child: Column(
                children: <Widget>[
                  //image
                  new Container(
                    width: 100,
                    height: 100,
                    margin: EdgeInsets.only(top: 30, bottom: 10),
                    decoration: new BoxDecoration(
                      shape: BoxShape.circle,
                      image: new DecorationImage(
                          image: new AssetImage('assets/user-profile.jpg'),
                          fit: BoxFit.fill),
                    ),
                  ),
                  new Text(
                    name,
                    style: TextStyle(fontSize: 19, color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
          new ListTile(
            leading: Icon(Icons.home),
            title: Text(
              'Home',
              style: TextStyle(fontSize: 18),
            ),
            onTap: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => CustomerHomeScreen()),
                  (_) => false);
            },
          ),
          new ListTile(
            leading: Icon(Icons.person),
            title: Text(
              'Profile',
              style: TextStyle(fontSize: 18),
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CustomerEditProfileScreen()));
            },
          ),
          new ListTile(
            leading: Icon(Icons.hourglass_full),
            title: Text(
              'Order Status',
              style: TextStyle(fontSize: 18),
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => OrderStatusLoading()));
            },
          ),
          new ListTile(
            leading: Icon(Icons.history),
            title: Text(
              'Order History',
              style: TextStyle(fontSize: 18),
            ),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Loading()));
            },
          ),
          new ListTile(
            leading: Icon(Icons.question_answer),
            title: Text(
              'FAQs',
              style: TextStyle(fontSize: 18),
            ),
            onTap: null,
          ),
          new ListTile(
            leading: Icon(Icons.library_books),
            title: Text(
              'Terms & Conditions',
              style: TextStyle(fontSize: 18),
            ),
            onTap: null,
          ),
          new ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text(
              'Logout',
              style: TextStyle(fontSize: 18),
            ),
            onTap: () async { // delete locally stored user info and redirect to the login/signup screen.
              SharedPreferences pref = await SharedPreferences.getInstance();
              await pref.clear();
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => IndexScreen()), (_) => false);
            },
          ),
        ],
      ),
    );
  }
}
