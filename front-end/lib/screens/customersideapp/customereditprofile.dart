import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CustomerEditProfileScreen extends StatefulWidget {
  @override
  _CustomerEditProfileScreenState createState() =>
      _CustomerEditProfileScreenState();
}

class _CustomerEditProfileScreenState extends State<CustomerEditProfileScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  // final namectrl = TextEditingController();
  // final contactctrl = TextEditingController();
  // final ntnctrl = TextEditingController();
  // final address = TextEditingController();
  // final password = TextEditingController();
  bool gettingdata = true;
  Future<bool> _verifyEmail() async {
    try {
      var response =
          await http.post('http://192.168.10.7:7777/users/r2gister/', body: {
        'password': _password,
        'name': _name,
        'contact_number': _contact,
        'address': _address,
        'ntn': _ntnnumber,
        'accounttype': "COMPANY",
      });
      print(response.body);
      if (json.decode(response.body)["error"] == false) {
        return true;
      } else {
        return true;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  void _submit() async {
    final form = _formKey.currentState;
    _loading = true;
    form.save();
    if (form.validate()) {
      if (await _verifyEmail()) {
        Navigator.pushNamedAndRemoveUntil(
            context, '/RegisterTanker', ModalRoute.withName('/'));
      }
    } else {
      _showSnackBar("Sorry Cound't store your information");
    }
    _loading = false;
  }

  var _loading = false;

  String _password;
  String _cpassword;
  String _name, _contact, _address, _ntnnumber;

  bool _obscurePassword = true;

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
    print(_name);
    _contact = prefs.getString('contact') ?? '';
    _address = prefs.getString('address') ?? '';
    _ntnnumber = prefs.getString('ntn') ?? '';
    _password = prefs.getString('password') ?? '';
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
        TextFormField(
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
          validator: (text) {
            if (text == null || text.isEmpty) {
              return 'Contact Number is required';
            }
            return null;
          },
          initialValue: _contact,
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
          validator: (text) {
            if (text == null || text.isEmpty) {
              return 'Address is required';
            }
            return null;
          },
          initialValue: _address,
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
        TextFormField(
          initialValue: _password,
          validator: (text) {
            Pattern pattern =
                r'^(?=.*[0-9]+.*)(?=.*[a-zA-Z]+.*)[0-9a-zA-Z]{6,}$';
            RegExp regex = new RegExp(pattern);
            if (!regex.hasMatch(text))
              return 'Invalid password. Password must has atleast 1 letter,\n 1 number and must be 6 characters long';
            else
              return null;
          },
          onSaved: (text) => _password = text,
          cursorColor: Theme.of(context).primaryColor,
          obscureText: _obscurePassword,
          decoration: InputDecoration(
            labelText: 'New Password',
            hintText: 'New Password',
            prefixIcon: Icon(Icons.vpn_key),
            suffixIcon: Icon(Icons.edit),
          ),
        ),
        TextFormField(
          initialValue: _password,
          validator: (text) {
            if (_cpassword != _password) return 'Passwords do not match';
            return null;
          },
          onSaved: (text) => _cpassword = text,
          cursorColor: Theme.of(context).primaryColor,
          obscureText: _obscurePassword,
          decoration: InputDecoration(
            labelText: 'Confirm password',
            hintText: 'Confirm Password',
            prefixIcon: Icon(Icons.vpn_key),
            suffixIcon: Icon(Icons.edit),
          ),
        ),
      ]),
    );

    return !this.gettingdata
        ? Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
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
            body: Center(
              child: SpinKitRotatingCircle(
                color: Colors.teal,
                size: 50.0,
              ),
            ),
          );
  }
}
