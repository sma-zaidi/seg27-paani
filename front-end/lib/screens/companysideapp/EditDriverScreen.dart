import 'package:flutter/material.dart';
import 'package:sweetalert/sweetalert.dart';
import 'package:paani/screens/companysideapp/ViewDrivers.dart';

class EditScreen extends StatefulWidget {
  var data;
  EditScreen({this.data});
  @override
  _EditScreenState createState() => _EditScreenState(data: data);
}

class _EditScreenState extends State<EditScreen> {
  var data;
  _EditScreenState({this.data});
  var nameController = TextEditingController();
  var cnicController = TextEditingController();
  var contactController = TextEditingController();
  @override
  void initState() {
    nameController.text = drivers[data]['name'];
    cnicController.text = drivers[data]['CNIC'];
    contactController.text = drivers[data]['contact'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal,
          leading: FlatButton(
            child: Icon(
              Icons.keyboard_backspace,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          centerTitle: true,
          title: Text(
            'Edit Driver',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 70, left: 20),
              child: Text(
                'Driver\'s Name:',
                style: TextStyle(color: Colors.teal),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Card(
                margin: EdgeInsets.symmetric(vertical: 12),
                child: TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 20),
              child: Text(
                'Contact:',
                style: TextStyle(color: Colors.teal),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Card(
                margin: EdgeInsets.symmetric(vertical: 12),
                child: TextField(
                  controller: contactController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 20),
              child: Text(
                'CNIC:',
                style: TextStyle(color: Colors.teal),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Card(
                margin: EdgeInsets.symmetric(vertical: 12),
                child: TextField(
                  controller: cnicController,
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
                                drivers[data]['name'] = nameController.text;
                                drivers[data]['contact'] =
                                    contactController.text;
                                drivers[data]['CNIC'] = cnicController.text;
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
      ),
    );
  }
}
