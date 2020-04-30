import 'package:flutter/material.dart';
import 'package:paani/screens/login.dart';
import 'package:paani/screens/signup_as.dart';
import 'package:flutter/rendering.dart';

void main() => runApp(MaterialApp(
      home: IndexScreen(),
      theme: ThemeData(primaryColor: Colors.teal),
    ));

class IndexScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: Center(
          child: new Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
            Container(
                margin: EdgeInsets.only(bottom: 130.0),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: new Image.asset(
                      'assets/logo_transparentbg.png',
                      width: 400.0,
                      height: 200.0,
                      fit: BoxFit.fill,
                    ))),
            customButton('Log In', 20.0, context),
            customButton('Sign Up', 60.0, context),
          ])),
      // decoration: BoxDecoration(
      //     image: DecorationImage(
      //         image: AssetImage('assets/logo_whitebg.png'), fit: BoxFit.cover)),
    ));
  }
}

Widget customButton(String text, double bottomMargin, BuildContext context) {
  return ButtonTheme(
    padding: EdgeInsets.only(bottom: 1),
    minWidth: 200,
    child: RaisedButton(
      onPressed: () {
        if (text == 'Log In') {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => LoginScreen()));
        } else if (text == 'Sign Up') {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => SignupAsScreen()));
        }
      },
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          letterSpacing: 1.5,
        ),
      ),
      // color: Theme.of(context).primaryColor,
      // shape: RoundedRectangleBorder(
      //   borderRadius: BorderRadius.circular(18.0),
      // ),
    ),
  );
}
