import 'package:paani/screens/companysideapp/EditDriverScreen.dart';
import 'package:flutter/material.dart';
import 'package:sweetalert/sweetalert.dart';
import 'AddDriver.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

var drivers;
bool datacollected = false;

class DriversScreen extends StatefulWidget {
  @override
  _DriversScreenState createState() => _DriversScreenState();
}

class _DriversScreenState extends State<DriversScreen> {
  bool loadpage = true;
  void checkdriver(dynamic data) {
    if (data['list'] is String) {
      loadpage = false;
    } else if (data['list'] is List) {
      drivers = data['list'];
    } else {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    var data = ModalRoute.of(context).settings.arguments;
    checkdriver(data);
    return loadpage
        ? Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.teal,
              centerTitle: true,
              title: Text(
                'Drivers',
                style: TextStyle(color: Colors.white),
              ),
              actions: <Widget>[
                FlatButton(
                  child: Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => AddDriverScreen()));
                  },
                )
              ],
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
                            image: AssetImage(
                                'assets/user-profile-default-image.png'),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Container(
                        width: 143,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('${drivers[index]["name"]}'),
                            SizedBox(height: 1.5),
                            Text('${drivers[index]["cnic"]}'),
                            SizedBox(height: 1.5),
                            Text('${drivers[index]["contact_number"]}'),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 40,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Text(
                                'Edit',
                                style: TextStyle(color: Colors.grey),
                              ),
                              SizedBox(
                                width: 16.0,
                              ),
                              ButtonTheme(
                                materialTapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                                minWidth: 0,
                                height: 0,
                                child: FlatButton(
                                  child: Icon(
                                    Icons.edit,
                                    color: Colors.grey,
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                EditScreen(data: index)));
                                  },
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Text(
                                'Delete',
                                style: TextStyle(color: Colors.grey),
                              ),
                              ButtonTheme(
                                materialTapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                                minWidth: 0,
                                height: 0,
                                child: FlatButton(
                                  child: Icon(
                                    Icons.delete,
                                    color: Colors.grey,
                                  ),
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          backgroundColor: Colors.white,
                                          title: Text(
                                            'Delete Driver?',
                                            style: TextStyle(
                                                color: Colors.teal,
                                                fontSize: 25.0),
                                          ),
                                          actions: <Widget>[
                                            FlatButton(
                                              child: Card(
                                                child: SizedBox(
                                                  height: 30.0,
                                                  width: 50.0,
                                                  child: Center(
                                                    child: Text(
                                                      'YES',
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                ),
                                                color: Colors.teal,
                                              ),
                                              onPressed: datacollected
                                                  ? null
                                                  : () async {
                                                      this.setState(() {
                                                        datacollected = true;
                                                      });
                                                      var driverid =
                                                          drivers[index]['id'];
                                                      var response =
                                                          await http.delete(
                                                              'https://seg27-paani-backend.herokuapp.com/drivers/$driverid');
                                                      var message = json.decode(
                                                          response.body);
                                                      print(message);
                                                      if (message['error'] ==
                                                          "false") {
                                                        setState(() {
                                                          drivers
                                                              .removeAt(index);
                                                        });
                                                      } else {
                                                        print("das");
                                                      }
                                                      Navigator.of(context)
                                                          .pop();
                                                      SweetAlert.show(context,
                                                          style: SweetAlertStyle
                                                              .success,
                                                          confirmButtonColor:
                                                              Colors.teal);
                                                      this.setState(() {
                                                        datacollected = false;
                                                      });
                                                    },
                                            ),
                                            FlatButton(
                                              child: Card(
                                                child: SizedBox(
                                                  height: 30.0,
                                                  width: 50.0,
                                                  child: Center(
                                                    child: Text(
                                                      'NO',
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                ),
                                                color: Colors.teal,
                                              ),
                                              onPressed: datacollected
                                                  ? null
                                                  : () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      )
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
              actions: <Widget>[
                FlatButton(
                  child: Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => AddDriverScreen()));
                  },
                )
              ],
            ),
            body: Center(
              child: Text(
                "No Driver Record Found.\nClick on + to add drivers",
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
