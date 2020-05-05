import 'package:flutter/material.dart';
import 'package:paani/screens/customersideapp/drawer.dart';

class OrderHistoryScreen extends StatefulWidget {
  @override
  _OrderHistoryScreenState createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
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
                  packageID: pastorders[index]["package_id"],
                  companyName: pastorders[index]["name"],
                  date: pastorders[index]["created"]
                      .substring(0, pastorders[index]["created"].indexOf('T')),
                  status: pastorders[index]["status"],
                  cost: pastorders[index]["cost"],
                  tankerSize: pastorders[index]["browser_capacity"],
                  rating: 1,
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
      @required this.rating});

  final int packageID;
  final String date;
  final String companyName;
  final String status;
  final int tankerSize;
  final int cost;
  final int rating;

  static const int MAX_COMPANYNAME_LENGTH = 12;

  @override
  Widget build(BuildContext context) {
    var _companyName = companyName;
    if (companyName.length > MAX_COMPANYNAME_LENGTH)
      _companyName = companyName.substring(0, MAX_COMPANYNAME_LENGTH) + '...';

    return Container(
        decoration: BoxDecoration(
            color: Colors.white, boxShadow: [BoxShadow(color: Colors.grey)]),
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Row(
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
                    _companyName,
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  LabelColonValue(label: 'Status', value: status),
                  LabelColonValue(
                      label: 'Package', value: tankerSize.toString() + ' gal.'),
                  LabelColonValue(
                      label: 'Paid', value: 'RS ' + cost.toString()),
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
                  StarRating(
                    rating: rating,
                  ),
                  ButtonTheme(
                    child: RaisedButton(
                      color: Theme.of(context).primaryColor,
                      child: Text(
                        'Reorder',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {}, // send to place order screen w/ details
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
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
