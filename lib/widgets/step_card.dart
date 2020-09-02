import 'package:flutter/material.dart';

class StepCard extends StatelessWidget {
  final int number;
  final String content;

  const StepCard(this.number, this.content);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              radius: 14.0,
              child: Text('$number'),
              backgroundColor: Colors.red,
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.all(8.0),
              child: Text(content, style: TextStyle(color: Colors.white),),
            )
          ),
        ],
      ),
    );
  }
}
