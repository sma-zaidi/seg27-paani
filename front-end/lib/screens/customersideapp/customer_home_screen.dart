import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:paani/screens/customersideapp/drawer.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_star_rating/flutter_star_rating.dart';
import 'package:paani/screens/customersideapp/customerorderplacement.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

//import './Screens/drawer.dart';
class CustomerHomeScreen extends StatefulWidget {
  @override
  HomeScreenState createState() => new HomeScreenState();
}

class HomeScreenState extends State<CustomerHomeScreen> {
  bool isSearching = false;
  List<dynamic> companies = [];
  List<dynamic> searchCompanies = [];
  String internetworking = "unknown";

  Future<void> getData() async {
    try {
      //var type -- http.response
      var response = await http.get(
          "https://seg27-paani-backend.herokuapp.com/companies",
          headers: {"Accept": "application/json"});
      //print(response.body);
      this.setState(() {
        Map<String, dynamic> map = json.decode(response.body);
        companies = map["msg"];
        searchCompanies = companies;
        internetworking = "yes";
      });
    } catch (e) {
      setState(() {
        internetworking = 'no';
      });
    }
    //var type -- http.response
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

  // Widget actualScreen() {
// }

  Widget internetissue() {
    return Scaffold(
      appBar: AppBar(
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
      drawer: DrawerDetails(),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ButtonTheme(
              buttonColor: Colors.grey,
              child: IconButton(
                onPressed: () {
                  getData();
                },
                icon: Icon(Icons.refresh),
                iconSize: 70.0,
                color: Colors.grey[700],
              ),
            ),
            SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
              child: Text(
                "Can not connect to the server. Check your Internet Connection",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25.0,
                  letterSpacing: 0.5,
                  color: Colors.grey[800],
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ]),
    );
  }

  Widget actualpage() {
    return Scaffold(
      appBar: AppBar(
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
      drawer: DrawerDetails(),
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

  @override
  Widget build(BuildContext context) {
    if (internetworking == "yes") {
      return actualpage();
    } else if (internetworking == "no") {
      return internetissue();
    } else {
      return Scaffold(
        body: Center(
          child: SpinKitRotatingCircle(
            color: Colors.teal,
            size: 50.0,
          ),
        ),
      );
    }
  }
}
