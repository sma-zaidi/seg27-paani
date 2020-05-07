//This Screen helps customer give feedback to the company after a completed order

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class FeedBack extends StatefulWidget {
  @override
  FeedBackState createState() => new FeedBackState();
}

var data;

class FeedBackState extends State<FeedBack> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  var final_rating = 0.0;
  var maxLines = 5;
  var review;
  void _submit() async {
    if (final_rating != 0.0) {
      try {
        var response = await http.post(
          'https://seg27-paani-backend.herokuapp.com/reviews',
          headers: {
            "Content-Type": "application/x-www-form-urlencoded",
            "Content-Type": "application/json",
          },
          body: jsonEncode({
            'id': data['orderid'],
            'review': review,
            'rating': final_rating,
          }),
        );
        var message = json.decode(response.body);
        if (message['error'] == false) {
          _showSnackBar("Feedback Submitted Successfully");
          Navigator.pop(context);
        } else if (message['error'] == 'Review exists!') {
          _showSnackBar("Feedback already given! Feedback not submitted");
        } else {
          _showSnackBar("Error! Feedback not submitted");
        }
      } catch (e) {
        _showSnackBar("Connection Error! Feeback not submittted");
      }
    } else {
      _showSnackBar("Please give rating");
    }
  }

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
    data = ModalRoute.of(context).settings.arguments;
    return Scaffold(
        key: scaffoldKey,
        resizeToAvoidBottomPadding: false,
        appBar: new AppBar(
          backgroundColor: Colors.teal,
          centerTitle: true,
          title: Text(
            "Feedback",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 25,
              ),
              Container(
                padding: EdgeInsets.only(
                  top: 25.0,
                ),
                child: Text(
                  "Thank you for trusting us!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black45,
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Container(
                child: Text(
                  "Please rate our service. (in 200 characters)",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black45,
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              RatingBar(
                initialRating: 0,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {
                  final_rating = rating;
                },
              ),
              SizedBox(
                height: 25,
              ),
              Container(
                margin: EdgeInsets.only(
                  right: 12.0,
                  left: 12.0,
                ),
                height: maxLines * 20.0,
                alignment: Alignment.center,
                padding: EdgeInsets.all(6),
                child: TextField(
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(200),
                  ],
                  maxLines: this.maxLines,
                  obscureText: false,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Feedback',
                    fillColor: Colors.black45,
                    filled: false,
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              RaisedButton(
                onPressed: _submit,
                child: new Text('Done'),
                textColor: Colors.white,
                color: Colors.teal,
              ),
            ],
          ),
        ));
  }
}
