import 'package:flutter/material.dart';
import 'package:smart_kitchen/helpers/constants.dart';

class CustomTitle extends StatelessWidget {
  final String title;

  const CustomTitle({
    @required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(color: Colors.teal, child: Center(child: Text(title, style: titleStyle)));
  }
}
