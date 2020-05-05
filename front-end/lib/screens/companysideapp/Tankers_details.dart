import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:paani/screens/companysideapp/RegisterTanker.dart';
import 'EditTankerScreen.dart';

var Tankers = [
  {'bowser_capacity': 2500, 'price_base': 5000, 'price_per_km': 20},
  {'bowser_capacity': 2800, 'price_base': 6000, 'price_per_km': 20},
  {'bowser_capacity': 2000, 'price_base': 4000, 'price_per_km': 20},
  {'bowser_capacity': 2200, 'price_base': 4750, 'price_per_km': 20},
  {'bowser_capacity': 3000, 'price_base': 10000, 'price_per_km': 20},
  {'bowser_capacity': 12500, 'price_base': 20000, 'price_per_km': 20},
  {'bowser_capacity': 200, 'price_base': 800, 'price_per_km': 20},
];

class TankerDetails extends StatefulWidget {
  @override
  TankerDetailsState createState() => new TankerDetailsState();
}

class TankerDetailsState extends State<TankerDetails> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.teal,
        centerTitle: true,
        title: Text(
          "Tankers",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.add,
                color: Colors.white,
                size: 20.0,
              ),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => RegisterTankerScreen()));
              })
        ],
      ),
      body: ListView.separated(
        itemCount: Tankers.length,
        itemBuilder: (BuildContext context, int index) {
          return Row(
            children: <Widget>[
              Container(
                // width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.only(left: 10),
                width: 230,
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Tanker Size: ${Tankers[index]['bowser_capacity']} Litres",
                      style: TextStyle(
                        color: Colors.black45,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Base Price: ${Tankers[index]['price_base']} Rupees",
                      style: TextStyle(
                        color: Colors.black45,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Price Per Km: ${Tankers[index]['price_per_km']} Rupees",
                      style: TextStyle(
                        color: Colors.black45,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text('Edit'),
                      FlatButton(
                        child: Icon(Icons.edit),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  EditTankerScreen(data: index)));
                        },
                      ),
                    ],
                  )
                ],
              ),
            ],
          );
        },
        separatorBuilder: (BuildContext context, int index) => Divider(),
      ),
    );
  }
}
