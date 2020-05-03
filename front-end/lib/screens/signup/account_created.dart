import 'package:flutter/material.dart';

class Accountcreated extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(30.0, 90.0, 30.0, 0),
      child: Wrap(
        children: <Widget>[
          Center(
            child: Icon(
              Icons.beach_access,
              size: 80.0,
            ),
          ),
          SizedBox(
            height: 105.0,
          ),
          Text(
            'Your account has been created!',
            style: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
                letterSpacing: 2.0),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 170.0,
          ),
          Center(
            child: ButtonTheme(
              padding: EdgeInsets.only(bottom: 1),
              minWidth: 300,
              child: RaisedButton(
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/login', (_) => false);
                },
                child: Text(
                  'Login',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                color: Theme.of(context).primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
