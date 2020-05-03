import 'package:flutter/material.dart';
import 'package:flutterapp/Screens/drawer.dart';

class Confirmed extends StatefulWidget {
  @override
  ConfirmedState createState() => new ConfirmedState();
}

class ConfirmedState extends State<Confirmed> {
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
        // Body
        drawer: DrawerDetails(),
        body: Container(
          child: Center(
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(bottom: 130.0),
                  child: Text(
                    "Order Confirmed.",
                    style: TextStyle(
                      fontSize:25.0,
                      fontWeight: FontWeight.bold,
                      
                    ),
                  ),
                ),
                Container(
                   height: 170.0,
                    width: 170.0,
                    margin: EdgeInsets.only(bottom: 170.0),
                    decoration: new BoxDecoration(
                      image: DecorationImage(
                        image: new AssetImage(
                            'assets/confirmed.png'),
                        fit: BoxFit.fill,
                      ),
                    ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 45.0),
                    width: 158,
                    height: 42,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(6.0),
                      child: RaisedButton(
                        color: Colors.teal,
                        textColor: Colors.white,
                        onPressed: () => {},
                        child: Row(
                          children: <Widget>[
                            Text("Cancel Order", style:
                            TextStyle(fontSize: 16),),

                            SizedBox(width: 6,),
                            Icon(Icons.clear)
                          ],
                      ),),)
                )
              ])
          )));
  }
}

