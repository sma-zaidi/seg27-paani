import 'package:flutter/material.dart';

class OrderHistoryScreen extends StatefulWidget {
  @override
  _OrderHistoryScreenState createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text('Order History'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.menu, color: Colors.white,),
          onPressed: () {}, // show context menu
        ),
      ),
      body: ListView.builder(
        itemCount: 14,
        itemBuilder: (BuildContext context, int index) {
          return OrderHistoryListElement(packageID: 1, companyName: 'KW & SB', date: '02/05/2020', status: 'Complete', cost: 3300, tankerSize: 1200, rating: 4,);
        },),
    );
  }
}

class OrderHistoryListElement extends StatelessWidget {

  OrderHistoryListElement({
    @required this.packageID,
    @required this.date,
    @required this.companyName,
    @required this.status,
    @required this.tankerSize, 
    @required this.cost, 
    @required this.rating
  });

  final int packageID;
  final String date;
  final String companyName;
  final String status;
  final int tankerSize;
  final int cost;
  final int rating;

  static const int MAX_COMPANYNAME_LENGTH = 12; 

  @override
  Widget build (BuildContext context) {

    var _companyName = companyName;
    if(companyName.length > MAX_COMPANYNAME_LENGTH) _companyName = companyName.substring(0, MAX_COMPANYNAME_LENGTH) + '...';

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(
          color: Colors.grey
        )]
      ),
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[

          Column(children: <Widget>[
            CircleAvatar(radius: 25.0 ,backgroundColor: Colors.transparent, backgroundImage: AssetImage('assets/user-profile.jpg'),),
          ]),

          Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
            Text(_companyName, style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),),
            LabelColonValue(label: 'Status', value: status),
            LabelColonValue(label: 'Package', value: tankerSize.toString() + ' gal.'),
            LabelColonValue(label: 'Paid', value: 'RS ' + cost.toString()),
          ],),

          Column(crossAxisAlignment: CrossAxisAlignment.center, children: <Widget>[
            Text(date, style: TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.w300),),
            StarRating(rating: rating,),
            ButtonTheme(
              child: RaisedButton(  
                color: Theme.of(context).primaryColor,
                child: Text('Reorder', style: TextStyle(color: Colors.white),),
                onPressed: () {}, // send to place order screen w/ details
              ),
            ),
          ],),

        ],),
      )
    );
  }
}

class LabelColonValue extends StatelessWidget { // Displays stuff like 'Status: Confirmed' with seperate styling for the label and value.
  LabelColonValue({@required this.label, @required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(children: <Widget>[
        Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
        Text(': '),
        Text(value),
      ],);
  }
}

class StarRating extends StatelessWidget {

  StarRating({@required this.rating});

  final int rating;

  static const STAR_SIZE = 15.8;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(children: <Widget>[
        Icon(Icons.star, color: rating >= 1 ? Colors.black : Colors.grey, size: STAR_SIZE,),
        Icon(Icons.star, color: rating >= 2 ? Colors.black : Colors.grey, size: STAR_SIZE,),
        Icon(Icons.star, color: rating >= 3 ? Colors.black : Colors.grey, size: STAR_SIZE,),
        Icon(Icons.star, color: rating >= 4 ? Colors.black : Colors.grey, size: STAR_SIZE,),
        Icon(Icons.star, color: rating >= 5 ? Colors.black : Colors.grey, size: STAR_SIZE,),
      ],)
    );
  }
}