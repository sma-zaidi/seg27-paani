import 'package:paani/screens/companysideapp/EditDriverScreen.dart';
import 'package:flutter/material.dart';
import 'package:sweetalert/sweetalert.dart';
import 'AddDriver.dart';

void main() => runApp(Driver());

var drivers = [
  {
    "name": "Muhammad Asghar",
    "CNIC": "35202-1234567-8",
    "contact": "0300-1234567",
    "Available": true
  },
  {
    "name": "Shabir Ahmed",
    "CNIC": "35202-1234567-9",
    "contact": "0300-1234567",
    "Available": true
  },
  {
    "name": "Rizwan Nadeem",
    "CNIC": "35202-1234567-1",
    "contact": "0300-1234567",
    "Available": true
  },
  {
    "name": "Affan Butt",
    "CNIC": "35202-1234567-7",
    "contact": "0300-1234567",
    "Available": false
  },
  {
    "name": "Khalid Sheikh",
    "CNIC": "35202-1234567-2",
    "contact": "0300-1234567",
    "Available": false
  },
  {
    "name": "Fahad Latif",
    "CNIC": "35202-1234567-1",
    "contact": "0300-1234567",
    "Available": true
  },
  {
    "name": "Asad Kamraan",
    "CNIC": "35202-1234567-7",
    "contact": "0300-1234567",
    "Available": false
  },
  {
    "name": "Shehzad Rehmani",
    "CNIC": "35202-1234567-2",
    "contact": "0300-1234567",
    "Available": false
  },
];

class Driver extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DriversScreen(),
    );
  }
}

class DriversScreen extends StatefulWidget {
  @override
  _DriversScreenState createState() => _DriversScreenState();
}

class _DriversScreenState extends State<DriversScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => AddDriverScreen()));
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
                      image:
                          AssetImage('assets/user-profile-default-image.png'),
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
                      Text('${drivers[index]["CNIC"]}'),
                      Text('${drivers[index]["contact"]}'),
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
                              Navigator.of(context).push(MaterialPageRoute(
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
                              if (drivers[index]["Available"] == true) {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      backgroundColor: Colors.white,
                                      title: Text(
                                        'Delete Driver?',
                                        style: TextStyle(
                                            color: Colors.teal, fontSize: 25.0),
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
                                          onPressed: () {
                                            setState(() {
                                              drivers.removeAt(index);
                                            });
                                            Navigator.of(context).pop();
                                            SweetAlert.show(context,
                                                style: SweetAlertStyle.success);
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
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              } else {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        backgroundColor: Colors.white,
                                        title: Text(
                                          'Driver cannot be deleted because of ongoing order',
                                          style: TextStyle(color: Colors.teal),
                                        ),
                                        actions: <Widget>[
                                          FlatButton(
                                            child: Text(
                                              'OK',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            color: Colors.teal,
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                        ],
                                      );
                                    });
                              }
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
    );
  }
}
