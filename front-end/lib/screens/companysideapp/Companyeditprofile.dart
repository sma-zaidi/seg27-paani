import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:paani/screens/companysideapp/Tankers_details.dart';
import 'package:paani/screens/companysideapp/ViewDrivers.dart';

class CompanyEditProfileScreen extends StatefulWidget {
  @override
  _CompanyEditProfileScreenState createState() =>
      _CompanyEditProfileScreenState();
}

class _CompanyEditProfileScreenState extends State<CompanyEditProfileScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  // final namectrl = TextEditingController();
  // final contactctrl = TextEditingController();
  // final ntnctrl = TextEditingController();
  // final address = TextEditingController();
  // final password = TextEditingController();
  bool gettingdata = true;
  bool editprofile = false;
  String _name, _contact, _address;

  Future<bool> _UpdateInformation() async {
    this.setState(() {
      this.gettingdata = true;
    });
    try {
      print("adas");
      SharedPreferences pref = await SharedPreferences.getInstance();
      print("d");
      String userid = pref.getString('userid');
      print('s');
      var response = await http.put(
        'https://seg27-paani-backend.herokuapp.com/customers/',
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          'id': userid,
          'name': _name,
          'contact_number': _contact,
          'address': _address,
          'location': '',
        }),
      );
      print(response.body);
      if (json.decode(response.body)["error"] == false) {
        this.setState(() {
          pref.setString('username', _name);
          pref.setString('contact', _contact);
          pref.setString('address', _address);
          this.editprofile = false;
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

  void _submit() async {
    final form = _formKey.currentState;
    form.save();
    if (form.validate()) {
      if (await _UpdateInformation()) {
        print("adas");
        _showSnackBar("Information Updated Successfully");
        this.setState(() {
          editprofile = false;
        });
      } else {
        _showSnackBar("Sorry Cound't store your information");
      }
    } else {
      _showSnackBar("Sorry Cound't store your information");
    }
  }

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

  Future<void> getdata() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    _name = prefs.getString('username');
    _contact = prefs.getString('contact');
    _address = prefs.getString('address');
    setState(() {
      this.gettingdata = false;
    });
  }

  @override
  void initState() {
    this.getdata();
  }

  Widget build(BuildContext context) {
    Widget DetailsForm = Form(
      key: _formKey,
      child: Column(children: <Widget>[
        Container(
          width: double.infinity,
          alignment: Alignment.centerRight,
          color: Colors.transparent,
          child: FlatButton(
              color: Colors.transparent,
              onPressed: () {
                this.setState(() {
                  editprofile = true;
                });
              },
              child: Text(
                "Edit",
                style: TextStyle(
                  letterSpacing: 0.7,
                  color: Colors.red[300],
                  fontSize: 15.0,
                  decoration: TextDecoration.underline,
                ),
              )),
        ),
        TextFormField(
          enabled: editprofile,
          initialValue: _name,
          validator: (text) {
            if (text == null || text.isEmpty) {
              return 'Company Name is required';
            }
            return null;
          },
          onSaved: (text) => _name = text,
          cursorColor: Theme.of(context).primaryColor,
          decoration: InputDecoration(
            labelText: 'Company Name',
            hintText: 'Company Name',
            prefixIcon: Icon(Icons.person),
            suffixIcon: Icon(Icons.edit),
          ),
        ),
        TextFormField(
          enabled: editprofile,
          initialValue: _contact,
          validator: (text) {
            if (text == null || text.isEmpty) {
              return 'Contact Number is required';
            }
            return null;
          },
          inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
          onSaved: (text) => _contact = text,
          cursorColor: Theme.of(context).primaryColor,
          // obscureText: _obscurePassword,
          decoration: InputDecoration(
            labelText: 'Contact',
            hintText: 'Contact Number',
            prefixIcon: Icon(Icons.contact_phone),
            suffixIcon: Icon(Icons.edit),
          ),
        ),
        TextFormField(
          enabled: editprofile,
          initialValue: _address,
          validator: (text) {
            if (text == null || text.isEmpty) {
              return 'Address is required';
            }
            return null;
          },
          onSaved: (text) => _address = text,
          cursorColor: Theme.of(context).primaryColor,
          // obscureText: _obscurePassword,
          decoration: InputDecoration(
            labelText: 'Address',
            hintText: 'Adress',
            prefixIcon: Icon(Icons.view_compact),
            suffixIcon: Icon(Icons.edit),
          ),
        ),
        Container(
          width: double.infinity,
          alignment: Alignment.centerRight,
          color: Colors.transparent,
          child: FlatButton(
              color: Colors.transparent,
              padding: EdgeInsets.all(0.0),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => TankerDetails()));
              },
              child: Text(
                "Edit Tankers details",
                style: TextStyle(
                  letterSpacing: 0.7,
                  color: Colors.red[300],
                  fontSize: 15.0,
                  decoration: TextDecoration.underline,
                ),
              )),
        ),
        SizedBox(height: 0.0),
        Container(
          width: double.infinity,
          alignment: Alignment.centerRight,
          color: Colors.transparent,
          padding: EdgeInsets.all(0.0),
          child: FlatButton(
              padding: EdgeInsets.all(0.0),
              color: Colors.transparent,
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => DriversScreen()));
              },
              child: Text(
                "Edit Drivers details",
                style: TextStyle(
                  letterSpacing: 0.7,
                  color: Colors.red[300],
                  fontSize: 15.0,
                  decoration: TextDecoration.underline,
                ),
              )),
        ),
      ]),
    );

    return !this.gettingdata
        ? Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              backgroundColor: Colors.teal,
              title: Text('Edit Profile'),
              actions: <Widget>[
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.info),
                  color: Colors.white,
                ),
              ],
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: Text(
                          'Profile',
                          style: TextStyle(
                              color: Color(0xFF002626),
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Text(
                        'Edit Profile',
                        style: TextStyle(
                          color: Color(0xFF002626),
                          fontSize: 14.0,
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Center(
                        child: Column(
                          children: <Widget>[
                            DetailsForm,
                            SizedBox(height: 20.0),
                            ButtonTheme(
                              minWidth: 170.0,
                              child: RaisedButton(
                                color: Colors.teal,
                                onPressed: _submit,
                                child: Text(
                                  'Save',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ]),
              ),
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
