import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:paani/main.dart';

class SignupAsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text(
              'Paani',
            ),
          ),
          actions: <Widget>[
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.info),
              color: Colors.white,
            ),
          ],
        ),
        body: Container(
            child: Center(
                child: new Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                  Container(
                      margin: EdgeInsets.only(bottom: 130.0),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.asset(
                            'assets/logo_transparentbg.png',
                            width: 400.0,
                            height: 200.0,
                            fit: BoxFit.fill,
                          ))),
                  customButton('Customer', context),
                  customButton('Company', context),
                ])),
            decoration: BoxDecoration(color: Colors.white)));
  }
}

Widget customButton(String text, BuildContext context) {
  return ButtonTheme(
    // buttonColor: Colors.white,
    padding: EdgeInsets.only(bottom: 1),
    minWidth: 200,
    child: RaisedButton(
      onPressed: () {
        if (text == 'Customer') {
          Navigator.pushNamed(context, '/customer_signup');
        } else if (text == 'Company') {
          Navigator.pushNamed(context, '/company_signup');
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
