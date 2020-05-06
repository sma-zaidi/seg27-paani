/*
  -> ENTRY POINT FOR THE APPLICATION
  Checks if a valid session ID is stored on the device, and points the user to login or the relevant home screen.
*/

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
import 'package:paani/screens/customersideapp/orderstatus/order_completed.dart';
import 'package:paani/screens/customersideapp/orderstatus/order_dispatched.dart';
import 'package:paani/screens/customersideapp/orderstatus/order_status_confirmed.dart';
import 'package:paani/screens/customersideapp/orderstatus/order_status_declined.dart';
import 'package:paani/screens/customersideapp/orderstatus/order_status_pending.dart';
import 'package:paani/screens/companysideapp/ViewDrivers.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:paani/screens/companysideapp/view_drivers_tanker_loading.dart';
import 'package:paani/screens/companysideapp/Tankers_details.dart';
import 'package:paani/screens/companysideapp/Assign_Driver.dart';
import 'package:paani/screens/companysideapp/Companyeditprofile.dart';
import 'screens/companysideapp/Assign_Driver.dart';
import 'screens/companysideapp/Companyeditprofile.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Paani',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      routes: {
        '/login': (BuildContext context) => LoginScreen(),
        '/signup_as': (BuildContext context) => SignupAsScreen(),
        '/customer_signup': (BuildContext context) => CustomerSignupScreen(),
        '/company_signup': (BuildContext context) => CompanySignupScreen(),
        '/RegisterDriver': (BuildContext context) => RegisterDriverScreen(),
        '/RegisterTanker': (BuildContext context) => RegisterTankerScreen(),
        '/companyhomescreen': (BuildContext context) => CompanyHomeScreen(),
        '/customerhomescreen': (BuildContext context) => CustomerHomeScreen(),
        '/orderhistory': (BuildContext context) => OrderHistoryScreen(),
        '/orderconfirmed': (BuildContext context) => Confirmed(),
        '/orderdeclined': (BuildContext context) => Declined(),
        '/orderdispatched': (BuildContext context) => Dispatched(),
        '/orderpending': (BuildContext context) => Pending(),
        '/ordercompleted': (BuildContext context) => Completed(),
        '/viewdrivers': (BuildContext context) => DriversScreen(),
        "/viewdriverstankerloading": (BuildContext context) =>
            Driver_Tanker_Loading(),
        '/viewtankers': (BuildContext context) => TankerDetails(),
        '/assigndriver': (BuildContext context) => AssignDriverScreen(),
        '/companyeditprofile': (BuildContext context) =>
            CompanyEditProfileScreen()
      },
      home: prefs.getString('email') == null
          ? IndexScreen()
          : (prefs.getString("accounttype") == 'COMPANY'
              ? CompanyHomeScreen()
              : CustomerHomeScreen())));
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
