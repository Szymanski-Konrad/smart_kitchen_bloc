import 'dart:io';

import 'package:flutter/material.dart';
import 'package:smart_kitchen/models/models.dart';

class RecipeCard extends StatelessWidget {
  final Recipe recipe;

  RecipeCard({this.recipe});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
        height: MediaQuery.of(context).size.height * 0.25,
        child: Stack(
          children: <Widget>[
            Hero(
              tag: recipe.id,
              child: Container(
                  height: MediaQuery.of(context).size.height * 0.25,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: recipe.imagePath == null || recipe.imagePath.length == 0
                            ? AssetImage('assets/noimage.jpg')
                            : FileImage(File(recipe.imagePath)),
                        fit: BoxFit.fill),
                    borderRadius: BorderRadius.circular(15.0),
                  )),
            ),
            RecipeRating(rating: recipe.rating,),
            RecipeName(name: recipe.name),
          ],
        ));
  }
}

class RecipeRating extends StatelessWidget {
  final double rating;

  RecipeRating({this.rating});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 6.0,
      right: 6.0,
      child: Card(
        color: Colors.black26,
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Row(
            children: <Widget>[
              Icon(
                Icons.star,
                color: rating > 3.5 ? Colors.green : Colors.red,
                size: 14.0,
              ),
              Text(
                rating.toStringAsFixed(2),
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RecipeName extends StatelessWidget {
  final String name;

  RecipeName({this.name});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0.0,
      left: 0.0,
      child: Container(
        width: MediaQuery.of(context).size.width - 8.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15.0), bottomRight: Radius.circular(15.0)),
          color: Colors.black38,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(name, style: TextStyle(color: Colors.white)),
        ),
      ),
    );
  }
}
