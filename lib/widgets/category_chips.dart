import 'package:flutter/material.dart';
import 'package:smart_kitchen/helpers/constants.dart';

class ChipList extends StatefulWidget {
  final String selectedCategory;
  final Function onTap;

  ChipList({this.selectedCategory, this.onTap});

  @override
  _ChipListState createState() => _ChipListState();
}

class _ChipListState extends State<ChipList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: categories.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () => widget.onTap(categories[index]),
              child: Card(
                elevation: categories[index] == widget.selectedCategory ? 5.0 : 0.0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                color: categories[index] == widget.selectedCategory ? Colors.indigo : Colors.deepOrange,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(categories[index], style: TextStyle(color: Colors.white)),
                ),
              ),
            );
          }),
    );
  }
}
