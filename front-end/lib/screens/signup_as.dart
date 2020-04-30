// import 'package:flutter/material.dart';
// import 'package:paani/screens/signup_customer.dart';
// import 'package:paani/screens/signup_company.dart';

// class SignupAsScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Paani.'),
//       ),
//       body: Column(children: <Widget>[
//         RaisedButton(
//           child: Text('Customer'),
//           onPressed: () {
//             Navigator.push(context, MaterialPageRoute(
//               builder: (context) =>
//                 CustomerSignupScreen()
//               )
//             );
//           },
//         ),
//         RaisedButton(
//           onPressed: () {
//             Navigator.push(context, MaterialPageRoute(
//               builder: (context) =>
//                 CompanySignupScreen()
//               )
//             );
//           },
//           child: Text('Company')
//         ),
//       ],),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:paani/screens/signup_customer.dart';
import 'package:paani/screens/signup_company.dart';

void main() => runApp(MaterialApp(
      home: SignupAsScreen(),
      theme: ThemeData(primaryColor: Colors.white),
    ));

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
                  customButton('Customer', 20.0, context),
                  customButton('Company', 60.0, context),
                ])),
            decoration: BoxDecoration(color: Colors.white)));
  }
}

Widget customButton(String text, double bottomMargin, BuildContext context) {
  return ButtonTheme(
    // buttonColor: Colors.white,
    padding: EdgeInsets.only(bottom: 1),
    minWidth: 200,
    child: RaisedButton(
      onPressed: () {
        if (text == 'Customer') {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => CustomerSignupScreen()));
        } else if (text == 'Company') {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => CompanySignupScreen()));
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
