import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
class FeedBack extends StatefulWidget {
  @override
  FeedBackState createState() => new FeedBackState();
}

 class FeedBackState extends State<FeedBack>{
   var rating= 0.0;
   var maxLines= 5;


   Widget build(BuildContext context) {
    return Scaffold(

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

      body: Column(
        children: <Widget>[

          SizedBox(height: 25,),
          Container(
            padding:EdgeInsets.only(top: 25.0,),
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
          SizedBox(height: 25,),
          Container(
             child: Text(
             "Please rate our service.",
             textAlign: TextAlign.center,
             style: TextStyle(
             color: Colors.black45,
             fontSize: 25.0,
             fontWeight: FontWeight.bold,
             ),

              ),
          ),
          SizedBox(height: 40,),
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
              print(rating);
            },
          ),
          SizedBox(height: 25,),
          Container(

            margin: EdgeInsets.only(right: 12.0, left: 12.0,),
            height: maxLines * 20.0,
            alignment: Alignment.center,
            padding: EdgeInsets.all(6),
            child: TextField(
              maxLines: maxLines,

              obscureText: false,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Feedback',
                fillColor: Colors.black45,
                filled:false,
              ),
            ),
          ),
          SizedBox(height: 15,),
          RaisedButton(
            onPressed: () {},
            child: new Text('Done'),
            textColor: Colors.white,
            color: Colors.teal,
          ),
        ],


        )
      );
  }

 }