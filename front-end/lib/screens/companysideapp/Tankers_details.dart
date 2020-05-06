import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:paani/screens/companysideapp/RegisterTanker.dart';
import 'package:http/http.dart' as http;
import 'EditTankerScreen.dart';
import 'RegisterTanker.dart';

bool dataloading = true;

var Tankers;

class TankerDetails extends StatefulWidget {
  @override
  TankerDetailsState createState() => new TankerDetailsState();
}

class TankerDetailsState extends State<TankerDetails> {
  bool loadpage = true;
  void checktanker(dynamic data) {
    if (data['list'] is String) {
      loadpage = false;
    } else {
      Tankers = data['list'];
    }
  }

  Widget build(BuildContext context) {
    var data = ModalRoute.of(context).settings.arguments;
    print(data);
    checktanker(data);
    return loadpage
        ? Scaffold(
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
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => RegisterTankerScreen()));
                    })
              ],
            ),
            body: ListView.separated(
              itemCount: Tankers.length,
              itemBuilder: (BuildContext context, int index) {
                return Row(
                  children: <Widget>[
                    Container(
                      // width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.only(left: 10),
                      width: 210,
                      child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Tanker Size: ${Tankers[index]['bowser_capacity']} Litres",
                            style: TextStyle(
                              color: Colors.black45,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Base Price: ${Tankers[index]['price_base']} Rupees",
                            style: TextStyle(
                              color: Colors.black45,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Price Per Km: ${Tankers[index]['price_per_km']} Rupees",
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
                      width: 22,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text('Edit'),
                            SizedBox(
                              width: 15,
                            ),
                            FlatButton(
                              child: Icon(Icons.edit),
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        EditTankerScreen(data: index)));
                              },
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Text('Delete'),
                            FlatButton(
                              child: Icon(Icons.delete),
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text(
                                          'Are you Sure you want to delete package?',
                                          style: TextStyle(color: Colors.teal),
                                        ),
                                        actions: <Widget>[
                                          FlatButton(
                                            color: Colors.teal,
                                            child: Text(
                                              'YES',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            onPressed: () async {
                                              var tankerid =
                                                  Tankers[index]['id'];
                                              var response = await http.delete(
                                                  'https://seg27-paani-backend.herokuapp.com/packages/$tankerid');
                                              var message =
                                                  json.decode(response.body);
                                              print(message);
                                              if (message['error'] == false) {
                                                setState(() {
                                                  Tankers.removeAt(index);
                                                });
                                              } else {
                                                print("das");
                                              }
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                          FlatButton(
                                            color: Colors.teal,
                                            child: Text(
                                              'NO',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          )
                                        ],
                                      );
                                    });
                              },
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
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
                'Tankers',
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
                        builder: (context) => RegisterTankerScreen()));
                  },
                )
              ],
            ),
            body: Center(
              child: Text(
                "No Tanker Record Found.\nClick on + to add tankers",
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
