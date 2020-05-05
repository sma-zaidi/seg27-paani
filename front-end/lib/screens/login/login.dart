import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  var _loading = false;

  String _email, _password;

  bool _obscurePassword = true;

  void _showSnackBar(String text) {
    scaffoldKey.currentState.removeCurrentSnackBar();
    scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(text),
      action: SnackBarAction(
        label: 'Dismiss',
        onPressed: () {
          scaffoldKey.currentState.removeCurrentSnackBar();
        },
      ),
    ));
  }

  Future<String> _logUserIn() async {
    // handles user login

    try {
      var result = await http.post(
          'https://seg27-paani-backend.herokuapp.com/users/login',
          body: {'email': _email, 'password': _password});

      var response = json.decode(result.body);
      print(response);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("email", _email);
      prefs.setString("password", _password);
      if (response['error'] == false) {
        Map message = response['msg'];

        prefs.setString("userid", message['id'].toString()); // session id
        prefs.setString("username", message['name'].toString());
        if (message.containsKey('ntn')) {
          prefs.setString("address", message['address'].toString());
          prefs.setString("contact", message['contact_number'].toString());
          prefs.setString("ntn", message['ntn'].toString());
          prefs.setString("accounttype", "COMPANY");
          return 'company';
        } else {
          prefs.setString("accounttype", 'COSTUMER');
          prefs.setString("address", message['address'].toString());
          prefs.setString("contact", message['contact_number'].toString());
          return 'customer';
        }
      } else {
        return 'invalid login';
      }
    } catch (error) { print(error); return 'error'; }
  }

  void _submit() async {
    setState(() {
      _loading = true;
    });

    final form = formKey.currentState;

    if (form.validate()) {
      form.save();

      var result = await _logUserIn();

      if (result == 'error') {
        _showSnackBar('Unable to reach Paani\'s servers');
      } else if (result == 'customer') {
        // credentials match a customer account
        Navigator.pushNamedAndRemoveUntil(
            context, '/customerhomescreen', (_) => false);
      } else if (result == 'company') {
        // credentials match a company account
        Navigator.pushNamedAndRemoveUntil(
            context, '/companyhomescreen', (_) => false);
      } else {
        _showSnackBar("Incorrect email or password");
      }
    }

    setState(() {
      _loading = false;
    });
  }

  Widget build(BuildContext context) {
    Widget paaniLogo = Image.asset(
      'assets/logo_transparentbg.png', // paani logo
      width: 400.0,
      height: 200.0,
      fit: BoxFit.fill,
    );

    Widget loginButton = ButtonTheme(
      minWidth: 320,
      child: RaisedButton(
        onPressed: _loading ? null : _submit,
        child: Text(
          'LOGIN',
          style: TextStyle(
            color: Colors.white,
            letterSpacing: 1.5,
          ),
        ),
        color: Theme.of(context).primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
    );

    Widget loginForm = Form(
        key: formKey,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: <Widget>[
                TextFormField(
                  validator: (text) {
                    if (text.isEmpty) {
                      return 'Please enter your email address';
                    }
                    return null;
                  },
                  onSaved: (text) => _email = text,
                  cursorColor: Theme.of(context).primaryColor,
                  decoration: InputDecoration(
                    labelText: 'Email address',
                    prefixIcon: Icon(Icons.email),
                  ),
                ),
                SizedBox(height: 6,),
                TextFormField(
                  validator: (text) {
                    if (text.isEmpty) {
                      return 'Please enter your password';
                    }
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
                          onPressed: () {
                                setState(() {
                                  _obscurePassword = !_obscurePassword;
                                });
                              })
                            ),
                ),
            ],
          ),
        ));

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('Paani - Log in', style: TextStyle(letterSpacing: 1.5),),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              paaniLogo,
              loginForm,
              SizedBox(height: 6.0,),
              loginButton,
              SizedBox(height: 6.0,),
            ],
          ),
        ),
      ),
    );
  }
}
