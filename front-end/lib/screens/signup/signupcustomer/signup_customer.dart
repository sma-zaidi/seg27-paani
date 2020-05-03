import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wc_form_validators/wc_form_validators.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:paani/screens/signup/account_created.dart';

class CustomerSignupScreen extends StatefulWidget {
  @override
  _CustomerSignupScreenState createState() => _CustomerSignupScreenState();
}

class _CustomerSignupScreenState extends State<CustomerSignupScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  var _loading = false;

  String _email, _password;
  String _cpassword;
  String _name, _contact, _address;

  Future<bool> _verifyEmail() async {
    try {
      var response =
          await http.post('http://10.0.2.2:7777/users/register/', body: {
        'email': _email,
        'password': _password,
        'name': _name,
        'contact_number': _contact,
        'address': _address,
      });
      print(response.body);
      if (json.decode(response.body)["message"] == true) {
        return false;
      } else {
        return true;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  void _submit() async {
    final form = formKey.currentState;

    _loading = true;

    if (form.validate()) {
      form.save();
      if (await _verifyEmail()) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => Accountcreated()),
            (_) => false);
      }
      _loading = false;
    }
  }

  bool _obscurePassword = true;

  void _showSnackBar(String text) {
    scaffoldKey.currentState.hideCurrentSnackBar();
    scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(text),
      action: SnackBarAction(
        label: 'Dismiss',
        onPressed: () {
          scaffoldKey.currentState.hideCurrentSnackBar();
        },
      ),
    ));
  }

  Widget build(BuildContext context) {
    Widget DetailsForm = Form(
      child: Column(children: <Widget>[
        TextFormField(
          validator: Validators.required("Enter your name"),
          onSaved: (text) => _name = text,
          cursorColor: Theme.of(context).primaryColor,
          decoration: InputDecoration(
            border: InputBorder.none,
            labelText: 'Name',
            prefixIcon: Icon(Icons.person),
          ),
        ),
        TextFormField(
          validator: Validators.email("Invalid Email address"),
          onSaved: (text) => _email = text,
          cursorColor: Theme.of(context).primaryColor,
          decoration: InputDecoration(
            labelText: 'Email',
            prefixIcon: Icon(Icons.email),
          ),
        ),
        TextFormField(
          validator: Validators.required("Enter your contact number"),
          inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
          onSaved: (text) => _contact = text,
          cursorColor: Theme.of(context).primaryColor,
          // obscureText: _obscurePassword,
          decoration: InputDecoration(
            labelText: 'Contact',
            hintText: 'Contact Number',
            prefixIcon: Icon(Icons.contact_phone),
          ),
        ),
        TextFormField(
          onSaved: (text) => _address = text,
          cursorColor: Theme.of(context).primaryColor,
          // obscureText: _obscurePassword,
          decoration: InputDecoration(
            labelText: 'Address (optional)',
            hintText: 'Adress',
            prefixIcon: Icon(Icons.view_compact),
          ),
        ),
        TextFormField(
          validator: (text) {
            Pattern pattern =
                r'^(?=.*[0-9]+.*)(?=.*[a-zA-Z]+.*)[0-9a-zA-Z]{6,}$';
            RegExp regex = new RegExp(pattern);
            if (!regex.hasMatch(text))
              return 'Invalid password. Password must has atleast 1 letter, 1 number and must be 6 characters long';
            else
              return null;
          },
          onSaved: (text) => _password = text,
          cursorColor: Theme.of(context).primaryColor,
          obscureText: _obscurePassword,
          decoration: InputDecoration(
            labelText: 'Password',
            prefixIcon: Icon(Icons.vpn_key),
            suffixIcon: IconButton(
                icon: _obscurePassword
                    ? Icon(Icons.visibility_off)
                    : Icon(Icons.visibility),
                onPressed: () => {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      })
                    }),
          ),
        ),
        TextFormField(
          validator: (text) {
            if (_cpassword != _password) return 'Passwords do not match';
            return null;
          },
          onSaved: (text) => _cpassword = text,
          cursorColor: Theme.of(context).primaryColor,
          obscureText: _obscurePassword,
          decoration: InputDecoration(
              labelText: 'Confirm password',
              prefixIcon: Icon(Icons.vpn_key),
              suffixIcon: IconButton(
                  icon: _obscurePassword
                      ? Icon(Icons.visibility_off)
                      : Icon(Icons.visibility),
                  onPressed: () => {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        })
                      })),
        ),
      ]),
    );
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('Sign up - Customer'),
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.info),
            color: Colors.white,
          ),
          FlatButton(
            onPressed: _submit,
            child: Text(
              'Next',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Text(
                    'Almost done',
                    style: TextStyle(
                        color: Color(0xFF002626),
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  'Please enter the required details:',
                  style: TextStyle(
                    color: Color(0xFF002626),
                    fontSize: 14.0,
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Center(
                  child: Column(
                    children: <Widget>[
                      DetailsForm,
                    ],
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}

// class CustomerSignupScreen extends StatefulWidget {
//   @override
//   _CustomerSignupScreenState createState() => _CustomerSignupScreenState();
// }

// class _CustomerSignupScreenState extends State<CustomerSignupScreen> {
//   final scaffoldKey = GlobalKey<ScaffoldState>();
//   final formKey = GlobalKey<FormState>();

//   var _loading = false;

//   String _email, _password;
//   String _cpassword;
//   String _name, _contact, _address;

//   bool _obscurePassword = true;

//   int _currentStep = 1;

//   void _showSnackBar(String text) {
//     scaffoldKey.currentState.hideCurrentSnackBar();
//     scaffoldKey.currentState.showSnackBar(SnackBar(
//       content: Text(text),
//       action: SnackBarAction(
//         label: 'Dismiss',
//         onPressed: () {
//           scaffoldKey.currentState.hideCurrentSnackBar();
//         },
//       ),
//     ));
//   }

//   Future<bool> _verifyEmail() async {
//     try {
//       var response = await http.get('http://10.0.2.2:7777/users/$_email');
//       print(response.body);
//       if (json.decode(response.body)["message"] == true) {
//         return false;
//       } else {
//         return true;
//       }
//     } catch (e) {
//       print(e);
//       return false;
//     }
//   }

//   Future<bool> _senddetails() async {
//     try {
//       var response = await http.post('placeholder', body: {
//         'Name': _name,
//         'Contact_Number': _contact,
//         'Address': _address
//       });
//       print(response.body);
//       if (json.decode(response.body)["error"] == true) {
//         return false;
//       }
//       return true;
//     } catch (e) {
//       print(e);
//       return true; //to be changed to false later
//     }
//   }

//   void _submit() async {
//     final form = formKey.currentState;

//     _loading = true;

//     form.save();
//     if (form.validate()) {
//       if (_currentStep == 1) {
//         setState(() {
//           _currentStep += 1;
//         });
//       } else if (_currentStep == 2) {
//         if (await _verifyEmail()) {
//           setState(() {
//             _currentStep += 1;
//           });
//         } else {
//           _showSnackBar("The email address is already in use.");
//         }
//       } else if (_currentStep == 3) {
//         if (await _senddetails()) {
//           setState(() {
//             _currentStep += 1;
//           });
//         } else {
//           _showSnackBar("Sorry Cound't store your information");
//         }
//       }
//     }
//     _loading = false;
//   }

//   Widget build(BuildContext context) {
//     Widget progressStep(stepNumber) {
//       return Container(
//         alignment: Alignment.center,
//         width: 20,
//         height: 20,
//         decoration: BoxDecoration(
//           color: _currentStep >= stepNumber
//               ? Theme.of(context).primaryColor
//               : Colors.grey,
//           shape: BoxShape.circle,
//         ),
//         child: Text(
//           stepNumber.toString(),
//           textAlign: TextAlign.center,
//           style: TextStyle(
//             color: Colors.white,
//           ),
//         ),
//       );
//     }

//     Widget progressLine(stepNumber) {
//       return Padding(
//         padding: EdgeInsets.symmetric(horizontal: 0.0),
//         child: Container(
//           height: 1.0,
//           width: 120.0,
//           color: _currentStep > stepNumber
//               ? Theme.of(context).primaryColor
//               : Colors.grey,
//         ),
//       );
//     }

//     Widget progress = Container(
//         child: Row(
//       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       children: <Widget>[
//         progressStep(1),
//         progressLine(1),
//         progressStep(2),
//         progressLine(2),
//         progressStep(3),
//       ],
//     ));

//     Widget emailForm = Form(
//       key: _currentStep == 1 ? formKey : null,
//       child: TextFormField(
//         validator: (text) {
//           if (text.isEmpty) {
//             return 'Please enter some text';
//           }
//           return null;
//         },
//         onSaved: (text) => _email = text,
//         cursorColor: Theme.of(context).primaryColor,
//         decoration: InputDecoration(
//           labelText: 'Email address',
//           prefixIcon: Icon(Icons.email),
//         ),
//       ),
//     );

//     Widget emailPage = Padding(
//       padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
//       child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             progress,
//             Padding(
//               padding: EdgeInsets.only(top: 20),
//               child: Text(
//                 'Create an account',
//                 style: TextStyle(
//                     color: Color(0xFF002626),
//                     fontSize: 30.0,
//                     fontWeight: FontWeight.bold),
//               ),
//             ),
//             SizedBox(
//               height: 20.0,
//             ),
//             Text(
//               'Please enter your email address:',
//               style: TextStyle(
//                 color: Color(0xFF002626),
//                 fontSize: 14.0,
//               ),
//             ),
//             SizedBox(
//               height: 20.0,
//             ),
//             Center(
//               child: Column(
//                 children: <Widget>[
//                   emailForm,
//                 ],
//               ),
//             ),
//           ]),
//     );

//     Widget passwordForm = Form(
//       key: _currentStep == 2 ? formKey : null,
//       child: Column(children: <Widget>[
//         TextFormField(
//           validator: (text) {
//             if (text.isEmpty) {
//               return 'Please enter some text';
//             }
//             return null;
//           },
//           onSaved: (text) => _password = text,
//           cursorColor: Theme.of(context).primaryColor,
//           obscureText: _obscurePassword,
//           decoration: InputDecoration(
//               labelText: 'Password',
//               prefixIcon: Icon(Icons.vpn_key),
//               suffixIcon: IconButton(
//                   icon: _obscurePassword
//                       ? Icon(Icons.visibility_off)
//                       : Icon(Icons.visibility),
//                   onPressed: () => {
//                         setState(() {
//                           _obscurePassword = !_obscurePassword;
//                         })
//                       })),
//         ),
//         TextFormField(
//           validator: (text) {
//             if (_cpassword != _password) return 'Passwords do not match';
//             return null;
//           },
//           onSaved: (text) => _cpassword = text,
//           cursorColor: Theme.of(context).primaryColor,
//           obscureText: _obscurePassword,
//           decoration: InputDecoration(
//               labelText: 'Confirm password',
//               prefixIcon: Icon(Icons.vpn_key),
//               suffixIcon: IconButton(
//                   icon: _obscurePassword
//                       ? Icon(Icons.visibility_off)
//                       : Icon(Icons.visibility),
//                   onPressed: () => {
//                         setState(() {
//                           _obscurePassword = !_obscurePassword;
//                         })
//                       })),
//         ),
//       ]),
//     );

//     Widget detailsForm = Form(
//       key: _currentStep == 3 ? formKey : null,
//       child: Column(children: <Widget>[
//         TextFormField(
//           validator: (text) {
//             if (text.isEmpty) {
//               return 'Please enter some text';
//             }
//             return null;
//           },
//           onSaved: (text) => _name = text,
//           cursorColor: Theme.of(context).primaryColor,
//           decoration: InputDecoration(
//             labelText: 'Name',
//             prefixIcon: Icon(Icons.person),
//           ),
//         ),
//         TextFormField(
//           validator: (text) {
//             if (text.isEmpty) {
//               return 'Please enter some text';
//             }
//             return null;
//           },
//           inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
//           onSaved: (text) => _contact = text,
//           cursorColor: Theme.of(context).primaryColor,
//           // obscureText: _obscurePassword,
//           decoration: InputDecoration(
//             labelText: 'Contact number',
//             prefixIcon: Icon(Icons.phone),
//           ),
//         ),
//         TextFormField(
//           validator: (text) {
//             if (text.isEmpty) {
//               return 'Please enter some text';
//             }
//             return null;
//           },
//           onSaved: (text) => _contact = text,
//           cursorColor: Theme.of(context).primaryColor,
//           // obscureText: _obscurePassword,
//           decoration: InputDecoration(
//             labelText: 'Address',
//             prefixIcon: Icon(Icons.location_on),
//           ),
//         ),
//       ]),
//     );

//     Widget detailsPage = Padding(
//       padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
//       child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             progress,
//             Padding(
//               padding: EdgeInsets.only(top: 20),
//               child: Text(
//                 'Almost done',
//                 style: TextStyle(
//                     color: Color(0xFF002626),
//                     fontSize: 30.0,
//                     fontWeight: FontWeight.bold),
//               ),
//             ),
//             SizedBox(
//               height: 20.0,
//             ),
//             Text(
//               'Please enter the required details:',
//               style: TextStyle(
//                 color: Color(0xFF002626),
//                 fontSize: 14.0,
//               ),
//             ),
//             SizedBox(
//               height: 20.0,
//             ),
//             Center(
//               child: Column(
//                 children: <Widget>[
//                   detailsForm,
//                 ],
//               ),
//             ),
//           ]),
//     );

//     Widget passwordPage = Padding(
//       padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
//       child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             progress,
//             Padding(
//               padding: EdgeInsets.only(top: 20),
//               child: Text(
//                 'Create an account',
//                 style: TextStyle(
//                     color: Color(0xFF002626),
//                     fontSize: 30.0,
//                     fontWeight: FontWeight.bold),
//               ),
//             ),
//             SizedBox(
//               height: 20.0,
//             ),
//             Text(
//               'Please choose a password:',
//               style: TextStyle(
//                 color: Color(0xFF002626),
//                 fontSize: 14.0,
//               ),
//             ),
//             SizedBox(
//               height: 20.0,
//             ),
//             Center(
//               child: Column(
//                 children: <Widget>[
//                   passwordForm,
//                 ],
//               ),
//             ),
//           ]),
//     );

//     Widget account_created = Padding(
//       padding: EdgeInsets.fromLTRB(30.0, 90.0, 30.0, 0),
//       child: Wrap(
//         children: <Widget>[
//           Center(
//             child: Icon(
//               Icons.beach_access,
//               size: 80.0,
//             ),
//           ),
//           SizedBox(
//             height: 105.0,
//           ),
//           Text(
//             'Your account has been created!',
//             style: TextStyle(
//                 fontSize: 25.0,
//                 fontWeight: FontWeight.bold,
//                 letterSpacing: 2.0),
//             textAlign: TextAlign.center,
//           ),
//           SizedBox(
//             height: 170.0,
//           ),
//           Center(
//             child: ButtonTheme(
//               padding: EdgeInsets.only(bottom: 1),
//               minWidth: 300,
//               child: RaisedButton(
//                 onPressed: () {
//                   Navigator.pushAndRemoveUntil(
//                       context,
//                       MaterialPageRoute(builder: (context) => LoginScreen()),
//                       (_) => false);
//                 },
//                 child: Text(
//                   'Login',
//                   style: TextStyle(
//                     color: Colors.white,
//                   ),
//                 ),
//                 color: Theme.of(context).primaryColor,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(18.0),
//                 ),
//               ),
//             ),
//           )
//         ],
//       ),
//     );

//     Widget _getPage() {
//       if (_currentStep == 1)
//         return emailPage;
//       else if (_currentStep == 2)
//         return passwordPage;
//       else if (_currentStep == 3)
//         return detailsPage;
//       else
//         return account_created;
//     }

//     return Scaffold(
//       key: scaffoldKey,
//       appBar: AppBar(
//         title: Text('Paani - Sign up'),
//         actions: <Widget>[
//           IconButton(
//             onPressed: () {},
//             icon: Icon(Icons.info),
//             color: Colors.white,
//           ),
//           FlatButton(
//             onPressed: _submit,
//             child: Text(
//               'Next',
//               style: TextStyle(
//                 color: Colors.white,
//               ),
//             ),
//           )
//         ],
//       ),
//       body: SingleChildScrollView(
//         child: _getPage(),
//       ),
//     );
//   }
// }
