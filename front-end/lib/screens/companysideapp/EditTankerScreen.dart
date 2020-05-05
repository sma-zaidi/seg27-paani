import 'package:flutter/material.dart';
import 'Tankers_details.dart';
import 'package:sweetalert/sweetalert.dart';

class EditTankerScreen extends StatefulWidget {
  var data;
  EditTankerScreen({this.data});
  @override
  _EditTankerScreenState createState() => _EditTankerScreenState(data: data);
}

class _EditTankerScreenState extends State<EditTankerScreen> {
  var data;
  _EditTankerScreenState({this.data});
  var capController = TextEditingController();
  var baseController = TextEditingController();
  var KMController = TextEditingController();
  @override
  void initState() {
    capController.text = Tankers[data]['bowser_capacity'].toString();
    baseController.text = Tankers[data]['price_base'].toString();
    KMController.text = Tankers[data]['price_per_km'].toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Tanker'),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 70, left: 20),
            child: Text(
              'Capacity:',
              style: TextStyle(color: Colors.teal),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Card(
              margin: EdgeInsets.symmetric(vertical: 12),
              child: TextField(
                controller: capController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 20),
            child: Text(
              'Base Price:',
              style: TextStyle(color: Colors.teal),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Card(
              margin: EdgeInsets.symmetric(vertical: 12),
              child: TextField(
                controller: baseController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 20),
            child: Text(
              'Price/Km:',
              style: TextStyle(color: Colors.teal),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Card(
              margin: EdgeInsets.symmetric(vertical: 12),
              child: TextField(
                controller: KMController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          Center(
            child: FlatButton(
              color: Colors.teal,
              child: Text(
                'Save',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      backgroundColor: Colors.white,
                      title: Text(
                        'Save Changes?',
                        style: TextStyle(color: Colors.teal, fontSize: 25.0),
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
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            color: Colors.teal,
                          ),
                          onPressed: () {
                            setState(() {
                              Tankers[data]['bowser_capacity'] =
                                  int.parse(capController.text);
                              Tankers[data]['price_base'] =
                                  int.parse(baseController.text);
                              Tankers[data]['price_per_km'] =
                                  int.parse(KMController.text);
                            });
                            Navigator.of(context).pop();
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
                                  style: TextStyle(color: Colors.white),
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
              },
            ),
          )
        ],
      ),
    );
  }
}
