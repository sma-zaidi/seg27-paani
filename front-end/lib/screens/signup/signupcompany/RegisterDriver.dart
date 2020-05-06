// import 'package:flutter/material.dart';
// import 'package:paani/screens/signup/account_created.dart';
// import 'package:paani/main.dart';

// class RegisterDriver extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: RegisterDriverScreen(),
//     );
//   }
// }

// class RegisterDriverScreen extends StatefulWidget {
//   @override
//   _RegisterDriverScreenState createState() => _RegisterDriverScreenState();
// }

// class _RegisterDriverScreenState extends State<RegisterDriverScreen> {
//   var driverData = [];
//   var nameController = TextEditingController();
//   var cnicController = TextEditingController();
//   var contactController = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: ListView(
//         children: <Widget>[
//           Padding(
//             padding: EdgeInsets.only(top: 70, left: 20),
//             child: Text(
//               'Name:',
//               style: TextStyle(color: Colors.teal),
//             ),
//           ),
//           Padding(
//             padding: EdgeInsets.symmetric(horizontal: 20),
//             child: Card(
//               margin: EdgeInsets.symmetric(vertical: 12),
//               child: TextField(
//                 controller: nameController,
//                 decoration: InputDecoration(
//                   border: InputBorder.none,
//                   hintText: 'Name',
//                 ),
//               ),
//             ),
//           ),
//           Padding(
//             padding: EdgeInsets.only(top: 10, left: 20),
//             child: Text(
//               'CNIC:',
//               style: TextStyle(color: Colors.teal),
//             ),
//           ),
//           Padding(
//             padding: EdgeInsets.symmetric(horizontal: 20),
//             child: Card(
//               margin: EdgeInsets.symmetric(vertical: 12),
//               child: TextField(
//                 controller: cnicController,
//                 decoration: InputDecoration(
//                   border: InputBorder.none,
//                   hintText: '12345-1234567-1',
//                 ),
//               ),
//             ),
//           ),
//           Padding(
//             padding: EdgeInsets.only(top: 10, left: 20),
//             child: Text(
//               'Contact:',
//               style: TextStyle(color: Colors.teal),
//             ),
//           ),
//           Padding(
//             padding: EdgeInsets.symmetric(horizontal: 20),
//             child: Card(
//               margin: EdgeInsets.symmetric(vertical: 12),
//               child: TextField(
//                 controller: contactController,
//                 decoration: InputDecoration(
//                   border: InputBorder.none,
//                   hintText: '0300-1234567',
//                 ),
//               ),
//             ),
//           ),
//           Padding(
//             padding: EdgeInsets.only(top: 20),
//             child: Center(
//               child: FlatButton(
//                 child: Card(
//                   color: Colors.teal,
//                   margin: EdgeInsets.symmetric(vertical: 12, horizontal: 90),
//                   child: ListTile(
//                     title: Text(
//                       'Add Driver',
//                       style: TextStyle(color: Colors.white),
//                     ),
//                     trailing: Icon(
//                       Icons.add,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ),
//                 onPressed: () {
//                   driverData.add({
//                     'name': nameController.text,
//                     'CNIC': cnicController.text,
//                     'contact': contactController.text
//                   });
//                   //TODO: Send POST request to Server with the DATA
//                   setState(() {
//                     nameController.text = "";
//                     cnicController.text = "";
//                     contactController.text = "";
//                   });
//                   showDialog(
//                       context: context,
//                       builder: (BuildContext context) {
//                         return AlertDialog(
//                           title: Text(
//                             'Driver Details Added Successfully',
//                             style: TextStyle(color: Colors.teal),
//                           ),
//                           actions: <Widget>[
//                             FlatButton(
//                               child: Text(
//                                 'OK',
//                                 style: TextStyle(color: Colors.white),
//                               ),
//                               color: Colors.teal,
//                               onPressed: () {
//                                 Navigator.pop(context);
//                               },
//                             )
//                           ],
//                         );
//                       });
//                 },
//               ),
//             ),
//           ),
//           Padding(
//             padding: EdgeInsets.only(top: 10),
//             child: Center(
//               child: Text(
//                 'or',
//                 style: TextStyle(color: Colors.teal),
//               ),
//             ),
//           ),
//           Padding(
//             padding: EdgeInsets.only(top: 10),
//             child: Center(
//               child: FlatButton(
//                 child: Card(
//                   color: Colors.teal,
//                   margin: EdgeInsets.symmetric(vertical: 12, horizontal: 125),
//                   child: ListTile(
//                     title: Center(
//                       child: Text(
//                         'Done',
//                         style: TextStyle(color: Colors.white),
//                       ),
//                     ),
//                   ),
//                 ),
//                 onPressed: () {
//                   Navigator.pushAndRemoveUntil(
//                       context,
//                       MaterialPageRoute(builder: (context) => Accountcreated()),
//                       ModalRoute.withName('/'));
//                 },
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:paani/screens/companysideapp/ViewDrivers.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:paani/screens/signup/account_created.dart';
import 'package:flutter/services.dart';

class RegisterDriverScreen extends StatefulWidget {
  @override
  _ResgisterDriverScreenState createState() => _ResgisterDriverScreenState();
}

class _ResgisterDriverScreenState extends State<RegisterDriverScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  void _showSnackBar(String text) {
    scaffoldKey.currentState.hideCurrentSnackBar();
    scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(text),
      action: SnackBarAction(
        label: 'Dismiss',
        onPressed: () {
          scaffoldKey.currentState.hideCurrentSnackBar();
        },
      ),
    ));
  }

  Map packageData;
  var nameController = TextEditingController();
  var cnicController = TextEditingController();
  var contactController = TextEditingController();
  bool gettingdata = false;

  Future<bool> _senddata(String name, cnic, contact) async {
    this.setState(() {
      this.gettingdata = true;
    });
    SharedPreferences pref = await SharedPreferences.getInstance();
    String userid = pref.getString('userid');
    packageData = {
      'company_id': userid,
      'name': name,
      'cnic': cnic,
      'contact_number': contact,
    };
    print(packageData);
    try {
      var response = await http.post(
        'https://seg27-paani-backend.herokuapp.com/drivers/',
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
          "Content-Type": "application/json",
        },
        body: jsonEncode(packageData),
      );
      print(response.body);
      if (json.decode(response.body)['error'] == false) {
        this.setState(() {
          this.gettingdata = false;
        });
        return true;
      } else {
        this.setState(() {
          this.gettingdata = false;
        });
        return false;
      }
    } catch (e) {
      this.setState(() {
        this.gettingdata = false;
      });
      return false;
    }
  }

  Future<void> _submit() async {
    if (contactController.text == "" ||
        nameController.text == "" ||
        cnicController.text == "") {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(
                'One or More fields missing',
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
                )
              ],
            );
          });
    } else {
      if (await _senddata(
          nameController.text, cnicController.text, contactController.text)) {
        _showSnackBar('Driver Added Successfully');
        setState(() {
          nameController.text = "";
          cnicController.text = "";
          contactController.text = "";
        });
      } else {
        _showSnackBar('Sorry, Driver Could not be added');
      }
    }
  }

  @override
  void initState() {
    nameController.text = "";
    cnicController.text = "";
    contactController.text = "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return !this.gettingdata
        ? Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                'Add Driver',
                style: TextStyle(color: Colors.white),
              ),
              leading: FlatButton(
                child: Icon(
                  Icons.keyboard_backspace,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => DriversScreen()));
                },
              ),
              backgroundColor: Colors.teal,
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
                        hintText: 'Name',
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
                          hintText: '0300-1234567',
                          border: InputBorder.none,
                        ),
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          WhitelistingTextInputFormatter.digitsOnly
                        ]),
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
                          hintText: '1234512345671',
                          border: InputBorder.none,
                        ),
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          WhitelistingTextInputFormatter.digitsOnly
                        ]),
                  ),
                ),
                Center(
                  child: FlatButton(
                    color: Colors.teal,
                    child: Text(
                      'Add Driver',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: _submit,
                  ),
                ),
                SizedBox(
                  height: 18.0,
                ),
                Center(
                  child: FlatButton(
                    color: Colors.teal,
                    child: Text(
                      'Next',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      SharedPreferences pref =
                          await SharedPreferences.getInstance();
                      await pref.remove('userid');
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Accountcreated()),
                          ModalRoute.withName('/'));
                    },
                  ),
                )
              ],
            ),
          )
        : Scaffold(
            key: scaffoldKey,
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
  }
}
