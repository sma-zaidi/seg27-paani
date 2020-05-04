import 'package:flutter/material.dart';

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