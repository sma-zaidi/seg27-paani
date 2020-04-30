import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class CompanySignupScreen extends StatefulWidget {
  @override
  _CompanySignupScreenState createState() => _CompanySignupScreenState();
}

class _CompanySignupScreenState extends State<CompanySignupScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  var _loading = false;

  String _email, _password;
  String _cpassword;
  String _name, _contact, _address, _ntn;
  String _baseprice, _priceperkm, _tankersize;

  bool _obscurePassword = true;

  int _currentStep = 1;

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

  Future<bool> _verifyEmail() async {
    try {
      var response = await http.get('http://10.0.2.2:7777/users/$_email');
      print(response.body);
      if (json.decode(response.body)["error"] == true) {
        return false;
      }
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> _senddetails() async {
    try {
      var response = await http.post('placeholder', body: {
        'Name': _name,
        'Contact_Number': _contact,
        'Address': _address,
        'NTN': _ntn,
      });
      print(response.body);
      if (json.decode(response.body)["error"] == true) {
        return false;
      }
      return true;
    } catch (e) {
      print(e);
      return true; //to be changed to false later
    }
  }

  void _submit() async {
    final form = formKey.currentState;

    _loading = true;

    form.save();
    if (form.validate()) {
      if (_currentStep == 1) {
        if (await _verifyEmail()) {
          setState(() {
            _currentStep += 1;
          });
        } else {
          _showSnackBar("The email address is already in use.");
        }
      } else if (_currentStep == 2) {
        setState(() {
          _currentStep += 1;
        });
      } else if (_currentStep == 3) {
        if (await _senddetails()) {
          setState(() {
            _currentStep += 1;
          });
        } else {
          _showSnackBar("Sorry Cound't store your information");
        }
      } else if (_currentStep == 3) {
        setState(() {
          _currentStep += 1;
        });
      }
    }
    _loading = false;
  }

  Widget build(BuildContext context) {
    Widget progressStep(stepNumber) {
      return Container(
        alignment: Alignment.center,
        width: 20,
        height: 20,
        decoration: BoxDecoration(
          color: _currentStep >= stepNumber
              ? Theme.of(context).primaryColor
              : Colors.grey,
          shape: BoxShape.circle,
        ),
        child: Text(
          stepNumber.toString(),
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      );
    }

    Widget progressLine(stepNumber) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 0.0),
        child: Container(
          height: 1.0,
          width: 120.0,
          color: _currentStep > stepNumber
              ? Theme.of(context).primaryColor
              : Colors.grey,
        ),
      );
    }

    Widget progress = Container(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        progressStep(1),
        progressLine(1),
        progressStep(2),
        progressLine(2),
        progressStep(3),
        // progressLine(3),
        // progressStep(4),
      ],
    ));

    Widget email_Ntn_Password_Form = Form(
      key: _currentStep == 1 ? formKey : null,
      child: Column(children: <Widget>[
        TextFormField(
          validator: (text) {
            if (text.isEmpty) {
              return 'Please enter some text';
            }
            return null;
          },
          onSaved: (text) => _email = text,
          cursorColor: Theme.of(context).primaryColor,
          decoration: InputDecoration(
            labelText: 'Email address',
            prefixIcon: Icon(Icons.email),
          ),
        ),
        TextFormField(
          validator: (text) {
            if (text.isEmpty) {
              return 'Please enter some text';
            }
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
                      })),
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

    Widget email_Ntn_Password_Page = Padding(
      padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            progress,
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: Text(
                'Create an account',
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
              'Please enter your email address:',
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
                  email_Ntn_Password_Form,
                ],
              ),
            ),
          ]),
    );

    // Widget passwordForm = Form(
    //   key: _currentStep == 2 ? formKey : null,
    //   child: Column(children: <Widget>[]),
    // );

    Widget detailsForm = Form(
      key: _currentStep == 2 ? formKey : null,
      child: Column(children: <Widget>[
        TextFormField(
          validator: (text) {
            if (text.isEmpty) {
              return 'Please enter some text';
            }
            return null;
          },
          onSaved: (text) => _ntn = text,
          cursorColor: Theme.of(context).primaryColor,
          decoration: InputDecoration(
            labelText: 'NTN Number',
            prefixIcon: Icon(Icons.person),
          ),
        ),
        TextFormField(
          validator: (text) {
            if (text.isEmpty) {
              return 'Please enter some text';
            }
            return null;
          },
          onSaved: (text) => _name = text,
          cursorColor: Theme.of(context).primaryColor,
          decoration: InputDecoration(
            labelText: 'Company Name',
            prefixIcon: Icon(Icons.person),
          ),
        ),
        TextFormField(
          validator: (text) {
            if (text.isEmpty) {
              return 'Please enter some text';
            }
            return null;
          },
          inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
          onSaved: (text) => _contact = text,
          cursorColor: Theme.of(context).primaryColor,
          // obscureText: _obscurePassword,
          decoration: InputDecoration(
            labelText: 'Contact number',
            prefixIcon: Icon(Icons.phone),
          ),
        ),
        TextFormField(
          validator: (text) {
            if (text.isEmpty) {
              return 'Please enter some text';
            }
            return null;
          },
          onSaved: (text) => _contact = text,
          cursorColor: Theme.of(context).primaryColor,
          // obscureText: _obscurePassword,
          decoration: InputDecoration(
            labelText: 'Address',
            prefixIcon: Icon(Icons.location_on),
          ),
        ),
      ]),
    );

    Widget detailsPage = Padding(
      padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            progress,
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: Text(
                'Company Information',
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
                  detailsForm,
                ],
              ),
            ),
          ]),
    );

    Widget tanker_Size_Price_Form = Form(
      key: _currentStep == 3 ? formKey : null,
      child: Column(children: <Widget>[
        TextFormField(
          validator: (text) {
            if (text.isEmpty) {
              return 'Please enter some text';
            } else if (int.parse(text).toInt() < 1000) {
              return 'Tanker Size must be greater than 1000';
            }
            return null;
          },
          inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
          onSaved: (text) => _tankersize = text,
          cursorColor: Theme.of(context).primaryColor,
          decoration: InputDecoration(
            labelText: 'Tanker Size',
            prefixIcon: Icon(Icons.person),
          ),
        ),
        TextFormField(
          validator: (text) {
            if (text.isEmpty) {
              return 'Please enter some text';
            }
            return null;
          },
          inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
          onSaved: (text) => _baseprice = text,
          cursorColor: Theme.of(context).primaryColor,
          decoration: InputDecoration(
            labelText: 'Base Price (Rps)',
            prefixIcon: Icon(Icons.person),
          ),
        ),
        TextFormField(
          validator: (text) {
            if (text.isEmpty) {
              return 'Please enter some text';
            }
            return null;
          },
          inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
          onSaved: (text) => _priceperkm = text,
          cursorColor: Theme.of(context).primaryColor,
          // obscureText: _obscurePassword,
          decoration: InputDecoration(
            labelText: 'Price per Km',
            prefixIcon: Icon(Icons.phone),
          ),
        ),
        SizedBox(
          height: 35,
        ),
        ButtonTheme(
          padding: EdgeInsets.only(bottom: 1),
          minWidth: 200,
          child: RaisedButton.icon(
            onPressed: _submit,
            label: Text(
              'Tanker Size',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            icon: Icon(
              Icons.add,
              color: Colors.white,
            ),
            color: Theme.of(context).primaryColor,
            // shape: RoundedRectangleBorder(
            //   borderRadius: BorderRadius.circular(18.0),
            // ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        ButtonTheme(
          padding: EdgeInsets.only(bottom: 1),
          minWidth: 200,
          child: RaisedButton(
            onPressed: _submit,
            child: Text(
              'Next',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            color: Theme.of(context).primaryColor,
            // shape: RoundedRectangleBorder(
            //   borderRadius: BorderRadius.circular(18.0),
            // ),
          ),
        ),
      ]),
    );

    Widget tanker_Size_Price_Page = Padding(
      padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            progress,
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: Text(
                'Create an account',
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
              'Fill the following details',
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
                  tanker_Size_Price_Form,
                ],
              ),
            ),
          ]),
    );

    Widget driver_reg_option_form = Form(
      key: _currentStep == 4 ? formKey : null,
      child: Column(children: <Widget>[
        ButtonTheme(
          padding: EdgeInsets.only(bottom: 1),
          minWidth: 200,
          child: RaisedButton(
            onPressed: _submit,
            child: Text(
              'Register Driver',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            color: Theme.of(context).primaryColor,
            // shape: RoundedRectangleBorder(
            //   borderRadius: BorderRadius.circular(18.0),
            // ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        ButtonTheme(
          padding: EdgeInsets.only(bottom: 1),
          minWidth: 200,
          child: RaisedButton(
            onPressed: _submit,
            child: Text(
              'Skip',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            color: Theme.of(context).primaryColor,
            // shape: RoundedRectangleBorder(
            //   borderRadius: BorderRadius.circular(18.0),
            // ),
          ),
        ),
      ]),
    );

    Widget driver_reg_option_page = Padding(
      padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // progress,
            Padding(
              padding: EdgeInsets.only(top: 20),
            ),
            SizedBox(
              height: 20.0,
            ),
            SizedBox(
              height: 20.0,
            ),
            Center(
              child: Column(
                children: <Widget>[
                  driver_reg_option_form,
                ],
              ),
            ),
          ]),
    );

    Widget driver_reg_form = Form(
      key: _currentStep == 3 ? formKey : null,
      child: Column(children: <Widget>[
        TextFormField(
          validator: (text) {
            if (text.isEmpty) {
              return 'Please enter some text';
            } else if (int.parse(text).toInt() < 1000) {
              return 'Tanker Size must be greater than 1000';
            }
            return null;
          },
          // inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
          onSaved: (text) => _tankersize = text,
          cursorColor: Theme.of(context).primaryColor,
          decoration: InputDecoration(
            labelText: 'Driver Name',
            prefixIcon: Icon(Icons.person),
          ),
        ),
        TextFormField(
          validator: (text) {
            if (text.isEmpty) {
              return 'Please enter some text';
            }
            return null;
          },
          inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
          onSaved: (text) => _baseprice = text,
          cursorColor: Theme.of(context).primaryColor,
          decoration: InputDecoration(
            labelText: 'CNIC',
            prefixIcon: Icon(Icons.person),
          ),
        ),
        TextFormField(
          validator: (text) {
            if (text.isEmpty) {
              return 'Please enter some text';
            }
            return null;
          },
          inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
          onSaved: (text) => _priceperkm = text,
          cursorColor: Theme.of(context).primaryColor,
          // obscureText: _obscurePassword,
          decoration: InputDecoration(
            labelText: 'Contact Number',
            prefixIcon: Icon(Icons.phone),
          ),
        ),
        SizedBox(
          height: 35,
        ),
        ButtonTheme(
          padding: EdgeInsets.only(bottom: 1),
          minWidth: 200,
          child: RaisedButton.icon(
            onPressed: null,
            label: Text(
              'Add Driver',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            icon: Icon(
              Icons.add,
              color: Colors.white,
            ),
            color: Theme.of(context).primaryColor,
            // shape: RoundedRectangleBorder(
            //   borderRadius: BorderRadius.circular(18.0),
            // ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        ButtonTheme(
          padding: EdgeInsets.only(bottom: 1),
          minWidth: 200,
          child: RaisedButton.icon(
            onPressed: _submit,
            label: Text(
              'Done',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            icon: Icon(
              Icons.check,
              color: Colors.white,
            ),
            color: Theme.of(context).primaryColor,
            // shape: RoundedRectangleBorder(
            //   borderRadius: BorderRadius.circular(18.0),
            // ),
          ),
        ),
      ]),
    );

    Widget driver_reg_page = Padding(
      padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            progress,
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: Text(
                'Create an account',
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
              'Fill the following details',
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
                  driver_reg_form,
                ],
              ),
            ),
          ]),
    );

    Widget _getPage() {
      if (_currentStep == 1)
        return email_Ntn_Password_Page;
      else if (_currentStep == 2)
        return detailsPage;
      else if (_currentStep == 3)
        return tanker_Size_Price_Page;
      else if (_currentStep == 4)
        return driver_reg_option_page;
      else if (_currentStep == 5)
        return driver_reg_page;
      else {
        return Container(
          child: Center(
            child: Text(
              'Your account has been created!',
              style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
            ),
          ),
        );
      }
    }

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('Paani - Sign up'),
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
        child: _getPage(),
      ),
    );
  }
}
