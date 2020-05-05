import 'package:flutter/material.dart';
import 'package:sweetalert/sweetalert.dart';

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

int orderID = 1;

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      image: AssetImage('images/no_pic.jpg'),
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
                      Text('${drivers[index]["name"]}'),
                      Text('${drivers[index]["CNIC"]}'),
                      Text('${drivers[index]["contact"]}'),
                    ],
                  ),
                ),
                SizedBox(
                  width: 35,
                ),
                FlatButton(
                  child: getIconOfAvailability(index),
                  onPressed: () {
                    if (drivers[index]['Available'] == true) {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text(
                                'Assign Order ID: $orderID to ${drivers[index]['name']}?',
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
                    } else {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text(
                                "Error: ${drivers[index]['name']} already has an ongoing delivery",
                                style: TextStyle(color: Colors.teal),
                              ),
                              actions: <Widget>[
                                FlatButton(
                                  child: Text(
                                    'OK',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  color: Colors.teal,
                                ),
                              ],
                            );
                          });
                    }
                  },
                ),
              ],
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) => Divider(),
      ),
    );
  }
}
