import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:paani/Screens/drawer.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_star_rating/flutter_star_rating.dart';
import 'package:paani/screens/customerorderplacement.dart';

//import './Screens/drawer.dart';
class HomeScreen extends StatefulWidget {
  @override
  HomeScreenState createState() => new HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  List<dynamic> data;
  Future<String> getData() async {
    //var type -- http.response
    var response = await http.get(
        "https://seg27-paani-backend.herokuapp.com/companies",
        headers: {"Accept": "application/json"});
    //print(response.body);
    this.setState(() {
      Map<String, dynamic> map = json.decode(response.body);
      data = map["message"];
    });
    //String name=data[0]["name"];
    //List<dynamic> data= jsonDecode(response.body);
    //print(data[1]["company_id"]);
  }

  @override
  //this functions is called before anything gets rendered to the screen
  // ignore: must_call_super
  void initState() {
    this.getData();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.teal,
      ),
      drawer: new DrawerDetails(),
      body: SingleChildScrollView(
        child: new Column(
          children: <Widget>[
            new Container(
              height: 657,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: new ListView.builder(
                  //vertical by default
                  itemCount: data == null ? 0 : data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return new Card(
                      elevation: 5,
                      child: new Row(
                        children: <Widget>[
                          //image inside container
                          new Container(
                            height: 225,
                            width: 150,
                            decoration: new BoxDecoration(
                              borderRadius: new BorderRadius.only(
                                bottomLeft: new Radius.circular(5),
                                topLeft: new Radius.circular(5),
                              ),
                              image: new DecorationImage(
                                fit: BoxFit.cover,
                                image: new AssetImage(
                                  'assets/default3.png',
                                ),
                              ),
                            ),
                          ),
                          new Container(
                            padding: const EdgeInsets.all(20),
                            height: 225,
                            child: new Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                new Text(
                                  data[index]["name"],
                                  style: new TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.teal,
                                  ),
                                ),
                                new SizedBox(
                                  height: 10,
                                ),
                                new Text(
                                  'Services:',
                                  style: new TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                                new SizedBox(
                                  height: 10,
                                ),
                                new Text(
                                  'Base Price:',
                                  style: new TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                                new SizedBox(
                                  height: 10,
                                ),
                                new Text(
                                  'Price/km:',
                                  style: new TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                                new SizedBox(
                                  height: 10,
                                ),
                                new RaisedButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                Place_Order_Screen()));
                                  },
                                  child: new Text('Order'),
                                  textColor: Colors.white,
                                  color: Colors.teal,
                                ),
                                new SizedBox(
                                  height: 10,
                                ),
                                new StarRating(
                                  rating: 3.45,
                                  starConfig: new StarConfig(
                                    fillColor: Colors.teal,
                                    strokeColor: Colors.teal,
                                    size: 20,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
