import 'package:flutter/material.dart';
import 'package:smart_kitchen/helpers/constants.dart';

class IngredientCard extends StatefulWidget {
  final double amount;
  final String name;

  IngredientCard({this.amount, this.name});

  @override
  _IngredientCardState createState() => _IngredientCardState();
}

class _IngredientCardState extends State<IngredientCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          IconButton(
            color: Colors.green,
            icon: Icon(Icons.shopping_cart),
            onPressed: () {},
          ),
          Expanded(
            child: ListTile(
              title: Text("${widget.amount} ${widget.name}", style: whiteTextStyle,),
            ),
          )
        ],
      ),
    );
  }
}