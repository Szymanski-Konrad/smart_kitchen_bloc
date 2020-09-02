import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const String homeRoute = '/home';
const String checkRoute = '/';
const String loginRoute = '/login';
const String registerRoute = '/register';
const String introRoute = '/intro';
const String cookingRoute = '/cooking';
const String shuffleRoute = '/shuffle';
const String newRecipeRoute = '/newRecipe';
const String cartRoute = '/cart';
const String productDetailsRoute = '/productDetails';
const String recipeDetailsRoute = '/recipeDetails';
const String prepareCookingRoute = '/prepareCooking';
const String newProductRoute = '/newProduct';
const String newIngredientRoute = '/newIngredient';
const String newStepRoute = '/newStep';
const String accountPanelRoute = '/accountPanel';

const TextStyle whiteTextStyle = TextStyle(color: Colors.white);
final titleStyle = GoogleFonts.literata(textStyle: TextStyle(color: Colors.white));

const categories = [
  'Śniadanie',
  'Obiad',
  'Kolacja',
  'Koktajl',
  'Deser',
  'Ciasto',
  'Ryba',
  'Sałatka',
  'Drink',
  'Konfitura',
];

const units = [
  '-',
  'g',
  'kg',
  'cup',
  'ml',
  'l',
  'tsp',
  'tbsp',
];

const accountPanelOptions = [
  "Przepisy",
  "Powiadomienia",
  "Opinie",
  "Ustawienia",
];