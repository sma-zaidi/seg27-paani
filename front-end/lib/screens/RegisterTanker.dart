import 'package:flutter/material.dart';
import 'RegisterDriver.dart';
import 'optionalScreen.dart';

void main() => runApp(RegisterTanker());

class RegisterTanker extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: RegisterTankerScreen(),
    );
  }
}

class RegisterTankerScreen extends StatefulWidget {
  @override
  _RegisterTankerScreenState createState() => _RegisterTankerScreenState();
}

class _RegisterTankerScreenState extends State<RegisterTankerScreen> {
  var packageData = [];
  var sizeController = TextEditingController();
  var baseController = TextEditingController();
  var KMController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 70, left: 20),
            child: Text(
              'Tanker Size:',
              style: TextStyle(color: Colors.teal),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Card(
              margin: EdgeInsets.symmetric(vertical: 12),
              child: TextField(
                controller: sizeController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Litres',
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10, left: 20),
            child: Text(
              'Base Price:',
              style: TextStyle(color: Colors.teal),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Card(
              margin: EdgeInsets.symmetric(vertical: 12),
              child: TextField(
                controller: baseController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Rs',
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10, left: 20),
            child: Text(
              'Price per Km:',
              style: TextStyle(color: Colors.teal),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Card(
              margin: EdgeInsets.symmetric(vertical: 12),
              child: TextField(
                controller: KMController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Rs/Km',
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 20),
            child: Center(
              child: FlatButton(
                child: Card(
                  color: Colors.teal,
                  margin: EdgeInsets.symmetric(vertical: 12, horizontal: 85),
                  child: ListTile(
                    title: Text(
                      'Add Tanker',
                      style: TextStyle(color: Colors.white),
                    ),
                    trailing: Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                  ),
                ),
                onPressed: () {
                  int size = int.parse(sizeController.text);
                  double base = double.parse(baseController.text);
                  double priceKM = double.parse(KMController.text);
                  packageData.add({
                    'size': size,
                    'base price': base,
                    'price per KM': priceKM
                  });
                  //TODO: Send POST request to Server with the DATA
                  setState(() {
                    sizeController.text = "";
                    baseController.text = "";
                    KMController.text = "";
                  });
                  showDialog(
                      context: context,
                      builder: (BuildContext cotext) {
                        return AlertDialog(
                          title: Text(
                            'Tanker Details Added Successfully',
                            style: TextStyle(color: Colors.teal),
                          ),
                          actions: <Widget>[
                            FlatButton(
                              child: Text(
                                'OK',
                                style: TextStyle(color: Colors.white),
                              ),
                              color: Colors.teal,
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            )
                          ],
                        );
                      });
                },
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: Center(
              child: Text(
                'or',
                style: TextStyle(color: Colors.teal),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: Center(
              child: FlatButton(
                child: Card(
                  color: Colors.teal,
                  margin: EdgeInsets.symmetric(vertical: 12, horizontal: 120),
                  child: ListTile(
                    title: Center(
                      child: Text(
                        'Next',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => Optional()));
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
