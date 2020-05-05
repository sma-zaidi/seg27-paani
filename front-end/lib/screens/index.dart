import 'package:flutter/material.dart';

class IndexScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: EdgeInsets.only(top: 130.0),
        child: Column(
          children: <Widget>[
            Image.asset(
              'assets/logo_transparentbg.png',
              width: 400.0,
              height: 200.0,
              fit: BoxFit.fill,
            ),
            customButton('LOG IN', () {
              Navigator.pushNamed(context, '/login');
            }),
            customButton('SIGN UP', () {
              Navigator.pushNamed(context, '/signup_as');
            }),
          ]
        ),
      ),
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
