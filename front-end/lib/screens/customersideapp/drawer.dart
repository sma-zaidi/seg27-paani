import 'package:flutter/material.dart';
import 'package:paani/screens/customersideapp/customer_home_screen.dart';
// import 'package:paani/screens/home_screen.dart';
// import 'package:http/http.dart' as http;

class DrawerDetails extends StatefulWidget {
  @override
  DrawerDetailsState createState() => new DrawerDetailsState();
}

class DrawerDetailsState extends State<DrawerDetails> {
  @override
  Widget build(BuildContext context) {
    return new Drawer(
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
                    'User Name',
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
            onTap: null,
          ),
          new ListTile(
            leading: Icon(Icons.hourglass_full),
            title: Text(
              'Order Status',
              style: TextStyle(fontSize: 18),
            ),
            onTap: null,
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
            onTap: null,
          ),
        ],
      ),
    );
  }
}
