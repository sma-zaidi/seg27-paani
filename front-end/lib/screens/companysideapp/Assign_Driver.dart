import 'package:flutter/material.dart';
import 'package:sweetalert/sweetalert.dart';

var drivers;
var orderid;

Icon getIconOfAvailability(int index) {
  if (drivers[index]['Available'] == true) {
    return Icon(
      Icons.check_circle,
      size: 40,
    );
  } else {
    return Icon(
      Icons.check_circle,
      color: Colors.green,
      size: 40,
    );
  }
}

class AssignDriverScreen extends StatefulWidget {
  @override
  _AssignDriverScreenState createState() => _AssignDriverScreenState();
}

class _AssignDriverScreenState extends State<AssignDriverScreen> {
  bool loadpage = true;
  void checkdriver(dynamic data) {
    if (data['list'] is String) {
      loadpage = false;
    } else {
      drivers = data['list'];
      orderid = data['orderid'];
    }
  }

  @override
  Widget build(BuildContext context) {
    var data = ModalRoute.of(context).settings.arguments;
    checkdriver(data);
    return loadpage
        ? Scaffold(
            appBar: AppBar(
              centerTitle: true,
              backgroundColor: Colors.teal,
              title: Text(
                'Assign Driver',
                style: TextStyle(color: Colors.white),
              ),
            ),
            body: ListView.separated(
              itemCount: drivers.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage('assets/user-profile.jpg'),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      Container(
                        width: 140,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('Name: ${drivers[index]["name"]}'),
                            Text('CNIC: ${drivers[index]["cnic"]}'),
                            Text(
                                'Contact: ${drivers[index]["contact_number"]}'),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 35,
                      ),
                      FlatButton(
                        child: getIconOfAvailability(index),
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text(
                                    'Assign Order ID: $orderid to ${drivers[index]['name']}?',
                                    style: TextStyle(color: Colors.teal),
                                  ),
                                  actions: <Widget>[
                                    FlatButton(
                                      child: Text(
                                        'YES',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      color: Colors.teal,
                                      onPressed: () {
                                        setState(() {
                                          drivers[index]['Available'] = false;
                                        });
                                        Navigator.of(context).pop();
                                        Navigator.of(context).pop();

                                        SweetAlert.show(context,
                                            style: SweetAlertStyle.success);
                                      },
                                    ),
                                    FlatButton(
                                      child: Text(
                                        'NO',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      color: Colors.teal,
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              });
                        },
                      ),
                    ],
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) => Divider(),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.teal,
              centerTitle: true,
              title: Text(
                'Drivers',
                style: TextStyle(color: Colors.white),
              ),
            ),
            body: Center(
              child: Text(
                "No Driver Record Found.\n Add drivers from Profile to assign one",
                style: TextStyle(
                  color: Colors.grey[700],
                  fontWeight: FontWeight.bold,
                  fontSize: 35.0,
                  letterSpacing: 0.8,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          );
  }
}
