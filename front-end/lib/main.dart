import 'package:flutter/material.dart';
import 'package:paani/screens/index.dart';
import 'package:paani/screens/login.dart';
import 'package:paani/screens/signup_customer.dart';
import 'package:paani/screens/signup_company.dart';

void main() => runApp(MyApp());

final routes = {
  '/': (BuildContext context) => IndexScreen(),
  '/login': (BuildContext context) => LoginScreen(),
  '/customer_signup': (BuildContext context) => CustomerSignupScreen(),
  '/company_signup': (BuildContext context) => CompanySignupScreen(),
};

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    print(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Paani App',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      routes: routes,
    );
  }
}
