import 'package:flutter/material.dart';

class IndexScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: 130.0),
            child: Image.asset(
              'assets/logo_transparentbg.png',
              width: 400.0,
              height: 200.0,
              fit: BoxFit.fill,
            )
          ),
          customButton('Log In', context),
          customButton('Sign Up', context),
        ]
      ),
    );
  }
}

Widget customButton(String text, BuildContext context) {
  return ButtonTheme(
    padding: EdgeInsets.only(bottom: 1),
    minWidth: 200,
    child: RaisedButton(
      onPressed: () {
        if (text == 'Log In') {
          Navigator.pushNamed(context, '/login');
        } else if (text == 'Sign Up') {
          Navigator.pushNamed(context, '/signup_as');
        }
      },
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          letterSpacing: 1.5,
        ),
      ),
    ),
  );
}
