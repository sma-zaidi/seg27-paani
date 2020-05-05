import 'package:flutter/material.dart';

class SignupAsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: EdgeInsets.only(top: 130.0),
        child: Column(
          children: <Widget>[
            Image.asset(
              'assets/logo_transparentbg.png', // paani logo
              width: 400.0,
              height: 200.0,
              fit: BoxFit.fill,
            ),
            customButton('CUSTOMER', () {
              Navigator.pushNamed(context, '/customer_signup'); 
            }),
            customButton('COMPANY', () {
              Navigator.pushNamed(context, '/company_signup');
            }),
          ]
        ),
      )
    );
  }
}

Widget customButton(String text, Function onPressed) {
  return ButtonTheme(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20.0)
    ),
    buttonColor: Colors.teal,
    minWidth: 150.0,
    child: RaisedButton(
      onPressed: onPressed,
      child: Text(text, style: TextStyle(color: Colors.white, letterSpacing: 1.5,)
      ),
    ),
  );
}
