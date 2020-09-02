import 'package:flutter/material.dart';

final bottomIcons = [
  BottomNavigationBarItem(
        title: Text('Koszyk'),
        icon: Icon(
          Icons.shopping_basket,
          size: 16.0,
        )),
    BottomNavigationBarItem(
        title: Text('Przepisy'),
        icon: Icon(
          Icons.receipt,
          size: 16.0,
        )),
    BottomNavigationBarItem(
        title: Text('Produkty'),
        icon: Icon(
          Icons.fastfood,
          size: 16.0,
        )),
    BottomNavigationBarItem(
        title: Text('Planer'),
        icon: Icon(
          Icons.calendar_today,
          size: 16.0,
        )),
    BottomNavigationBarItem(
        title: Text('Konto'),
        icon: Icon(
          Icons.account_circle,
          size: 16.0,
        )),
];

const TextStyle textStyle = TextStyle(color: Colors.blue);

final popUpItems = [
    PopupMenuItem(
      child: Text("Nowy przepis", style: textStyle),
      value: 'new',
    ),
    PopupMenuItem(
      child: Text("Losowy przepis", style: textStyle),
      value: 'shuffle',
    ),
    PopupMenuItem(
      child: Text(
        "Z lodówki",
        style: textStyle,
      ),
      value: 'fridge',
    )
  ];