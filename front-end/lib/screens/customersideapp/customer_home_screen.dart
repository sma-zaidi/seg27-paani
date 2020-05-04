import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:paani/screens/customersideapp/drawer.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_star_rating/flutter_star_rating.dart';
import 'package:paani/screens/customersideapp/customerorderplacement.dart';

//import './Screens/drawer.dart';
class CustomerHomeScreen extends StatefulWidget {
  @override
  HomeScreenState createState() => new HomeScreenState();
}

class HomeScreenState extends State<CustomerHomeScreen> {
  bool isSearching = false;
  List<dynamic> companies;
  List<dynamic> searchCompanies = [];
  Future<void> getData() async {
    //var type -- http.response
    var response = await http.get(
        "https://seg27-paani-backend.herokuapp.com/companies",
        headers: {"Accept": "application/json"});
    //print(response.body);
    this.setState(() {
      Map<String, dynamic> map = json.decode(response.body);
      companies = map["message"];
      searchCompanies = companies;
    });
    //String name=data[0]["name"];
    //List<dynamic> data= jsonDecode(response.body);
    //print(data[1]["company_id"]);
  }

  void searchCompany(String input) {
    setState(() {
      searchCompanies = companies
          .where((compamy) => compamy['name']
              .toString()
              .toLowerCase()
              .contains(input.toLowerCase()))
          .toList();
    });
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
        title: !isSearching
            ? Text(
                "Welcome",
                style: TextStyle(color: Colors.white),
              )
            : TextField(
                onChanged: (String input) {
                  searchCompany(input);
                },
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Search',
                    hintStyle: TextStyle(
                      color: Colors.white,
                    ),
                    icon: Icon(
                      Icons.search,
                      color: Colors.white,
                    )),
              ),
        actions: <Widget>[
          !isSearching
              ? IconButton(
                  icon: Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    setState(() {
                      isSearching = true;
                    });
                  },
                )
              : IconButton(
                  icon: Icon(
                    Icons.clear,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    setState(() {
                      searchCompanies = companies;
                      isSearching = false;
                    });
                  },
                ),
        ],
        backgroundColor: Colors.teal,
      ),
      drawer: new DrawerDetails(),
      body: SingleChildScrollView(
        child: new Column(
          children: <Widget>[
            new Container(
              height: 657,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: searchCompanies.length > 0
                  ? new ListView.builder(
                      //vertical by default
                      itemCount: searchCompanies.length,
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
                                      searchCompanies[index]["name"],
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
                                                    Place_Order_Screen(
                                                      data:
                                                          searchCompanies[index]
                                                              ['name'],
                                                    )));
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
                      })
                  : Center(
                      child: CircularProgressIndicator(),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}