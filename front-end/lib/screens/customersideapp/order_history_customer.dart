import 'package:flutter/material.dart';
import 'package:paani/screens/customersideapp/drawer.dart';
import 'package:paani/screens/customersideapp/feedback_customer.dart';

class OrderHistoryScreen extends StatefulWidget {
  @override
  _OrderHistoryScreenState createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  bool datasent = false;
  Map datafromload;
  List<dynamic> pastorders;
  bool orderhistory(Map data) {
    if (data['messagetype'] == 'String') {
      return false;
    } else {
      pastorders = data['messagebody'];
      return true;
    }
  }

  Widget noorderhistory() {
    return Center(
      child: Column(children: <Widget>[
        Icon(
          Icons.error,
          size: 50.0,
        ),
        SizedBox(height: 30.0),
        Text(
          "No Order History Found",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 40.0,
          ),
        )
      ]),
    );
  }

  Widget build(BuildContext context) {
    datafromload = ModalRoute.of(context).settings.arguments;
    print(datafromload);
    return orderhistory(datafromload)
        ? Scaffold(
            appBar: AppBar(
              elevation: 0.0,
              title: Text('Order History'),
              centerTitle: true,
            ),
            drawer: DrawerDetails(),
            body: ListView.builder(
              itemCount: pastorders.length,
              itemBuilder: (BuildContext context, int index) {
                return OrderHistoryListElement(
                  packageID: pastorders[index]["package_id"].toString(),
                  companyName: pastorders[index]["name"].toString(),
                  date: pastorders[index]["created"]
                      .substring(0, pastorders[index]["created"].indexOf('T')),
                  status: pastorders[index]["status"].toString(),
                  cost: pastorders[index]["cost"].toString(),
                  tankerSize: pastorders[index]["bowser_capacity"].toString(),
                  rating: 1,
                  customer_id: pastorders[index]["customer_id"].toString(),
                  delivery_address:
                      pastorders[index]["delivery_address"].toString(),
                  delivery_location:
                      pastorders[index]["delivery_location"] == null
                          ? "N/A"
                          : pastorders[index]["delivery_location"].toString(),
                  delivery_time: pastorders[index]["delivery_time"].toString(),
                  estimated_cost:
                      pastorders[index]["estimated_cost"].toString(),
                );
              },
            ),
          )
        : noorderhistory();
  }
}

class OrderHistoryListElement extends StatelessWidget {
  OrderHistoryListElement(
      {@required this.packageID,
      @required this.date,
      @required this.companyName,
      @required this.status,
      @required this.tankerSize,
      @required this.cost,
      @required this.rating,
      @required this.customer_id,
      @required this.delivery_address,
      @required this.delivery_location,
      @required this.delivery_time,
      @required this.estimated_cost});

  final String packageID;
  final String date;
  final String companyName;
  final String status;
  final String tankerSize;
  final String cost;
  final int rating;
  final String customer_id;
  final String delivery_address;
  final String delivery_location;
  final String delivery_time;
  final String estimated_cost;

  bool checkifstatusnotcompleted() {
    if (status == 'Completed') {
      return false;
    }
    return true;
  }

  static const int MAX_COMPANYNAME_LENGTH = 12;

  Map movetonextpage() {
    var requestbody = {
      "companyname": companyName,
      "tankersize": tankerSize,
      "customer_id": customer_id,
      "package_id": packageID,
      "delivery_address": delivery_address,
      "delivery_location": delivery_location,
      "delivery_time": delivery_time,
      "estimated_cost": estimated_cost,
      "cost": cost,
    };
    return requestbody;
  }

  @override
  Widget build(BuildContext context) {
    var _companyName = companyName;
    var _cost = cost.toString();
    var _size = tankerSize.toString();
    if (companyName.length > MAX_COMPANYNAME_LENGTH)
      _companyName = companyName.substring(0, MAX_COMPANYNAME_LENGTH) + '...';
    if (cost.toString().length > 5)
      _cost = cost.toString().substring(0, 5) + '...';
    if (tankerSize.toString().length > 5)
      _size = tankerSize.toString().substring(0, 5) + '...';
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, boxShadow: [BoxShadow(color: Colors.grey)]),
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Row(
          // crossAxisAlignment: WrapCrossAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(children: <Widget>[
              CircleAvatar(
                radius: 25.0,
                backgroundColor: Colors.transparent,
                backgroundImage: AssetImage('assets/user-profile.jpg'),
              ),
            ]),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Company Name: $_companyName",
                  style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 7,
                ),
                LabelColonValue(label: 'Status', value: status),
                SizedBox(
                  height: 7,
                ),
                LabelColonValue(label: 'Package', value: _size + ' Litres'),
                SizedBox(
                  height: 7,
                ),
                LabelColonValue(label: 'Paid', value: 'Rs ' + _cost),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  date,
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                      fontWeight: FontWeight.w300),
                ),
                ButtonTheme(
                  child: RaisedButton(
                    color: Theme.of(context).primaryColor,
                    child: Text(
                      'Give Feedback',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: checkifstatusnotcompleted()
                        ? null
                        : () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => FeedBack()),
                            ),
                  ),
                ),

                // send to place order screen w/ details

                ButtonTheme(
                  child: RaisedButton(
                    color: Theme.of(context).primaryColor,
                    child: Text(
                      'Reorder',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: checkifstatusnotcompleted()
                        ? null
                        : () => Navigator.pushNamed(
                            context, '/order_confirmation',
                            arguments:
                                movetonextpage()), // send to place order screen w/ details
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class LabelColonValue extends StatelessWidget {
  // Displays stuff like 'Status: Confirmed' with seperate styling for the label and value.
  LabelColonValue({@required this.label, @required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
        Text(': '),
        Text(value),
      ],
    );
  }
}

class StarRating extends StatelessWidget {
  StarRating({@required this.rating});

  final int rating;

  static const STAR_SIZE = 15.8;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(
      children: <Widget>[
        Icon(
          Icons.star,
          color: rating >= 1 ? Colors.black : Colors.grey,
          size: STAR_SIZE,
        ),
        Icon(
          Icons.star,
          color: rating >= 2 ? Colors.black : Colors.grey,
          size: STAR_SIZE,
        ),
        Icon(
          Icons.star,
          color: rating >= 3 ? Colors.black : Colors.grey,
          size: STAR_SIZE,
        ),
        Icon(
          Icons.star,
          color: rating >= 4 ? Colors.black : Colors.grey,
          size: STAR_SIZE,
        ),
        Icon(
          Icons.star,
          color: rating >= 5 ? Colors.black : Colors.grey,
          size: STAR_SIZE,
        ),
      ],
    ));
  }
}
