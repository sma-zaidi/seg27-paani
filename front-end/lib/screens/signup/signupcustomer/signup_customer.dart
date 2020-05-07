import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:paani/screens/signup/account_created.dart';
import 'package:email_validator/email_validator.dart';

class CustomerSignupScreen extends StatefulWidget {
  @override
  _CustomerSignupScreenState createState() => _CustomerSignupScreenState();
}

class _CustomerSignupScreenState extends State<CustomerSignupScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  var _loading = false;

  String _email, _password;
  String _cpassword;
  String _name, _contact, _address;

  Future<bool> _verifyEmail() async {
    try {
      var response = await http.post(
          'https://seg27-paani-backend.herokuapp.com/users/register/',
          body: {
            'email': _email,
            'password': _password,
            'name': _name,
            'contact_number': _contact,
            'address': _address,
            'account_type': "CUSTOMER",
          });
      print(response.body);
      if (json.decode(response.body)["error"] == false) {
        return true;
      } else {
        return false;
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
      print(_cpassword);
      print(_password);
      if (await _verifyEmail()) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => Accountcreated()),
            ModalRoute.withName("/"));
      }
      _loading = false;
    } else {
      print("ads");
    }
  }

  bool _obscurePassword = true;

  Widget build(BuildContext context) {
    Widget DetailsForm = Form(
      key: _formKey,
      child: Column(children: <Widget>[
        TextFormField(
          validator: (text) {
            if (text == null || text.isEmpty) {
              return 'Name is required';
            }
            return null;
          },
          onSaved: (text) => _name = text,
          cursorColor: Theme.of(context).primaryColor,
          decoration: InputDecoration(
            labelText: 'Name',
            prefixIcon: Icon(Icons.person),
          ),
        ),
        TextFormField(
          validator: (text) {
            if (EmailValidator.validate(text) == false) {
              return 'invalid Email-address';
            }
            return null;
          },
          onSaved: (text) => _email = text,
          cursorColor: Theme.of(context).primaryColor,
          decoration: InputDecoration(
            labelText: 'Email',
            prefixIcon: Icon(Icons.email),
          ),
        ),
        TextFormField(
          validator: (text) {
            if (text == null || text.isEmpty) {
              return 'Contact address is required';
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
          ),
        ),
        TextFormField(
          onSaved: (text) => _address = text,
          cursorColor: Theme.of(context).primaryColor,
          // obscureText: _obscurePassword,
          decoration: InputDecoration(
            labelText: 'Address (optional)',
            hintText: 'Address',
            prefixIcon: Icon(Icons.view_compact),
          ),
        ),
        TextFormField(
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
            labelText: 'Password',
            prefixIcon: Icon(Icons.vpn_key),
            suffixIcon: IconButton(
                icon: _obscurePassword
                    ? Icon(Icons.visibility_off)
                    : Icon(Icons.visibility),
                onPressed: () => {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      })
                    }),
          ),
        ),
        TextFormField(
          validator: (text) {
            if (_cpassword != _password) {
              return 'Passwords do not match';
            } else {
              return null;
            }
          },
          onSaved: (text) => _cpassword = text,
          cursorColor: Theme.of(context).primaryColor,
          obscureText: _obscurePassword,
          decoration: InputDecoration(
              labelText: 'Confirm password',
              prefixIcon: Icon(Icons.vpn_key),
              suffixIcon: IconButton(
                  icon: _obscurePassword
                      ? Icon(Icons.visibility_off)
                      : Icon(Icons.visibility),
                  onPressed: () => {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        })
                      })),
        ),
      ]),
    );
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('Sign up - Customer'),
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
                    'Welcome',
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
                  'Please enter the required details:',
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
                            'Sign Up',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}
