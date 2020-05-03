import 'package:flutter/material.dart';
import 'package:flutterapp/Screens/drawer.dart';

class Declined extends StatefulWidget {
  @override
  DeclinedState createState() => new DeclinedState();
}

class DeclinedState extends State<Declined> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // Appbar
        appBar: AppBar(
          backgroundColor: Colors.teal,
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () { Scaffold.of(context).openDrawer(); },
                tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
              );
            },
         ),
          // Title
          title: Text("Order Status"),
          centerTitle: true,

        ),
        drawer: DrawerDetails(),
        // Body
        body: Container(
          child: Center(
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(bottom: 130),
                  child: Text(
                    "Request Declined.",
                    style: TextStyle(
                      fontSize:25.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                   height: 170.0,
                    width: 170.0,
                    margin: EdgeInsets.only(bottom: 220.0),
                    decoration: new BoxDecoration(
                      image: DecorationImage(
                        image: new AssetImage(
                            'assets/declined.png'),
                        fit: BoxFit.fill,
                      ),
                    ),
                              )
              ])
          )));
  }
}

