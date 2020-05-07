import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:paani/screens/customersideapp/drawer.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_star_rating/flutter_star_rating.dart';
import 'package:paani/screens/customersideapp/customer_order_placement.dart';

class CustomerHomeScreen extends StatefulWidget {
  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<CustomerHomeScreen> {
  bool failedToLoad =
      false; // gets set to true if loading homescreen data from the server fails

  bool isSearching = false;
  var companies = [];
  var searchCompanies = [];
  var allCompanyPackages;

  Future<http.Response> getCompanies() async {
    try {
      return await http.get(
          "https://seg27-paani-backend.herokuapp.com/companies",
          headers: {"Accept": "application/json"});
    } catch (error) {
      setState(() {
        failedToLoad = true;
      });
      print(error);
      return null;
    }
  }

  Future<http.Response> getPackages(company) async {
    try {
      return await http.get(
          "https://seg27-paani-backend.herokuapp.com/packages/${company['id']}",
          headers: {"Accept": "application/json"});
    } catch (error) {
      setState(() {
        failedToLoad = true;
      });
      print(error);
      return null;
    }
  }

  Future<http.Response> getRatings(company) async {
    try {
      return await http.get(
          "https://seg27-paani-backend.herokuapp.com/reviews/avg/${company['id']}",
          headers: {"Accept": "application/json"});
    } catch (error) {
      setState(() {
        failedToLoad = true;
      });
      print(error);
      return null;
    }
  }

  Future<void> getData() async {
    var responseCompanies = await getCompanies();
    if (responseCompanies == null) return; // error occured
    var mapCompanies = jsonDecode(responseCompanies.body);
    companies = mapCompanies['msg'];

    for (int i = 0; i < companies.length; i++) {
      // get each company's packages and ratings. Takes a bit, persistent http might help.
      var responsePackages = await getPackages(companies[i]);
      var responseRatings = await getRatings(companies[i]);
      if (responsePackages == null || responseRatings == null) {
        // error occured
        companies = [];
        return;
      }
      var mapPackages = jsonDecode(responsePackages.body);
      var mapRatings = jsonDecode(responseRatings.body);
      companies[i]['packages'] = mapPackages['msg'];
      if (mapRatings['error'] == false) {
        if (mapRatings.containsKey('mgs')) {}
      }
    }

    setState(() {
      searchCompanies = companies;
    });
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

  String getPackageCapacities(Map<String, dynamic> company) {
    // Returns all bowser capacities of packages
    String returnString = "Packages: ";
    String bowsers = "";
    for (int i = 0; i < company['packages'].length; i++) {
      bowsers = bowsers +
          company['packages'][i]['bowser_capacity'].toString() +
          " L, ";
    }
    returnString = returnString +
        bowsers.substring(0, bowsers.length - 2); //To remove comma at the end
    return returnString;
  }

  String getPackageBasePrices(Map<String, dynamic> company) {
    // Returns all base prices of packages
    String returnString = "Base Prices: ";
    String prices = "";
    for (int i = 0; i < company['packages'].length; i++) {
      prices = prices +
          "Rs." + company['packages'][i]['price_base'].toString() + " ,";
    }
    returnString = returnString +
        prices.substring(0, prices.length - 2); //To remove comma at the end
    return returnString;
  }

  String getPackageKMPrices(Map<String, dynamic> company) {
    // Returns all price/Km of packages
    String returnString = "Price/Km: ";
    String prices = "";
    for (int i = 0; i < company['packages'].length; i++) {
      prices = prices +
          "Rs." + company['packages'][i]['price_per_km'].toString() +
          ", ";
    }
    returnString = returnString +
        prices.substring(0, prices.length - 2); //To remove comma at the end
    return returnString;
  }

  @override
  //this functions is called before anything gets rendered to the screen
  // ignore: must_call_super
  void initState() {
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        title: !isSearching
            ? Text(
                "Paani - Home",
                style: TextStyle(color: Colors.white,
                letterSpacing: 1.5, fontWeight: FontWeight.bold),
              )
            : TextField(
                onChanged: (String input) {
                  searchCompany(input);
                },
                cursorColor: Colors.white,
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
      body: searchCompanies.length > 0
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
                        height: 210,
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
                      SizedBox(width: 10,),
                      new Container(
                        padding: const EdgeInsets.all(20),
                        width: 192,
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
                              searchCompanies[index]['packages'] ==
                                      "No Packages Found!"
                                  ? 'Services: '
                                  : getPackageCapacities(
                                      searchCompanies[index]),
                              style: new TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.black54,
                              ),
                            ),
                            new SizedBox(
                              height: 10,
                            ),
                            new Text(
                              searchCompanies[index]['packages'] !=
                                      "No Packages Found!"
                                  ? getPackageBasePrices(searchCompanies[index])
                                  : 'Base Price: ',
                              style: new TextStyle(
                                fontSize: 14,
                                color: Colors.black54,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            new SizedBox(
                              height: 10,
                            ),
                            new Text(
                              searchCompanies[index]['packages'] !=
                                      "No Packages Found!"
                                  ? getPackageKMPrices(searchCompanies[index])
                                  : 'Price per Km: ',
                              style: new TextStyle(
                                fontSize: 14,
                                color: Colors.black54,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            new SizedBox(
                              height: 10,
                            ),
                            new ButtonTheme(
                              minWidth: 166 ,
                            child: new RaisedButton(
                              onPressed: () {
                                if (searchCompanies[index]['packages'] !=
                                    "No Packages Found!") {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              Place_Order_Screen(
                                                data: searchCompanies[index],
                                              )));
                                } else {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text(
                                            'Company has no packages available right now.',
                                            style:
                                                TextStyle(color: Colors.teal),
                                          ),
                                          actions: <Widget>[
                                            RaisedButton(
                                              child: Text(
                                                'OK',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                              color: Colors.teal,
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                          ],
                                        );
                                      });
                                }
                              },
                              child: new Text(
                                'ORDER',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1.5),),
                                textColor: Colors.white,
                                color: Colors.teal,
                            ),),
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
          : Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Center(
                  child: failedToLoad
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'Failed to reach Paani\'s servers.\nPlease check your internet connection and try again.',
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: 6.0,
                            ),
                            RaisedButton(
                              onPressed: () {
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            CustomerHomeScreen()),
                                    (_) => false);
                              },
                              child: Text('Refresh'),
                            )
                          ],
                        )
                      : CircularProgressIndicator()),
            ),
    );
  }
}
