import 'package:flutter/material.dart';
import 'package:paani/screens/index.dart';
import 'package:paani/screens/login/login.dart';
import 'package:paani/screens/signup/signup_as.dart';
import 'package:paani/screens/signup/signupcustomer/signup_customer.dart';
import 'package:paani/screens/signup/signupcompany/signup_company.dart';
import 'package:paani/screens/customersideapp/customer_home_screen.dart';
import 'package:paani/screens/signup/signupcompany/RegisterDriver.dart';
import 'package:paani/screens/signup/signupcompany/RegisterTanker.dart';
import 'package:paani/screens/companysideapp/CompanyHomeScreen.dart';
import 'package:paani/screens/customersideapp/order_history_customer.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var email = prefs.getString('email');
  print(email);
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Paani App',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      routes: {
        // '/': (BuildContext context) => IndexScreen(),
        '/login': (BuildContext context) => LoginScreen(),
        '/signup_as': (BuildContext context) => SignupAsScreen(),
        '/customer_signup': (BuildContext context) => CustomerSignupScreen(),
        '/company_signup': (BuildContext context) => CompanySignupScreen(),
        '/RegisterDriver': (BuildContext context) => RegisterDriver(),
        '/RegisterTanker': (BuildContext context) => RegisterTanker(),
        '/companyhomescreen': (BuildContext context) => CompanyHomeScreen(),
        '/customerhomescreen': (BuildContext context) => CustomerHomeScreen(),
        '/orderhistory': (BuildContext context) => OrderHistoryScreen(),
      },
      home: email == null
          ? IndexScreen()
          : (prefs.getString("accounttype") == 'COMPANY'
              ? CompanyHomeScreen()
              : CustomerHomeScreen())));
}

Future<bool> checkloggedin() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  String email = pref.getString('email') ?? '';
  if (email == '') {
    return false;
  } else {
    return true;
  }
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
