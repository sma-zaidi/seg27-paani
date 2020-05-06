/*
  ENTRY POINT FOR THE APPLICATION
  Checks if a valid session ID is stored on the device.
    if not points to login, else relevant home screen.
*/

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:paani/routes/routes.dart'; // defines the routes variable

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Paani',
      theme: ThemeData(primarySwatch: Colors.teal,),
      routes: routes, // defined in routes/routes.dart
      home: prefs.getString('email') == null
          ? index
          : (prefs.getString("accounttype") == 'COMPANY'
              ? companyHome
              : customerHome)
    )
  );
  
}

Future<bool> checkloggedin() async {
  //
  SharedPreferences pref = await SharedPreferences.getInstance();
  String email = pref.getString('email') ?? '';
  if (email == '')
    return false;
  else
    return true;
}

// class MyApp extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     print(context);
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Paani App',
//       theme: ThemeData(
//         primarySwatch: Colors.teal,
//       ),
//       initialRoute: checkloggedin()? "/login":'/',
//       routes: routes,
//     );
//   }
// }
