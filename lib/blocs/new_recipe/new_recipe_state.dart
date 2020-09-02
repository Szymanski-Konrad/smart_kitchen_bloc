import 'package:meta/meta.dart';
import 'package:smart_kitchen/blocs/new_recipe/new_recipe.dart';

import 'package:smart_kitchen/models/models.dart';

class NewRecipeState {
  final int id;
  final String name;
  final String category;
  final String imagePath;
  final String notes;
  final String user;
  final double rating;
  final int ratingCount;
  final List<Ingredient> ingredients;
  final List<RecipeStep> steps;

  List<Ingredient> get freeIngredients => ingredients.where((element) => !_busyIngredients.contains(element)).toList();
  List<Ingredient> get _busyIngredients {
    return steps.expand((element) {
      return element.ingredients == null ? List<Ingredient>() : element.ingredients;
    }).toList();
  }


  NewRecipeState({this.id, this.name, this.category, this.imagePath, this.notes, this.user, this.rating, this.ratingCount, this.ingredients, this.steps});

  factory NewRecipeState.empty(String user) {
    return NewRecipeState(
      category: '',
      imagePath: '',
      id: -1,
      ingredients: [],
      name: '',
      notes: '',
      rating: 0,
      ratingCount: 0,
      steps: [],
      user: user,
    );
  }

  factory NewRecipeState.toEdit(Recipe recipe) {
    return NewRecipeState(
      category: recipe.category,
      imagePath: recipe.imagePath,
      id: recipe.id,
      ingredients: recipe.ingredients,
      name: recipe.name,
      notes: recipe.notes,
      rating: recipe.rating,
      ratingCount: recipe.ratingCount,
      steps: recipe.steps,
      user: recipe.user,
    );
  }

  NewRecipeState update({
    String name,
    String category,
    String imagePath,
    String notes,
    List<Ingredient> ingredients,
    List<RecipeStep> steps,
  }) {
    return copyWith(
      name: name,
      category: category,
      imagePath: imagePath,
      notes: notes,
      ingredients: ingredients,
      steps: steps,
    );
  }

  NewRecipeState copyWith({
    int id,
    String name,
    String category,
    String imagePath,
    String notes,
    String user,
    double rating,
    int ratingCount,
    List<Ingredient> ingredients,
    List<RecipeStep> steps,
  }) {
    return NewRecipeState(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      imagePath: imagePath ?? this.imagePath,
      notes: notes ?? this.notes,
      user: user ?? this.user,
      rating: rating ?? this.rating,
      ratingCount: ratingCount ?? this.ratingCount,
      ingredients: ingredients ?? this.ingredients,
      steps: steps ?? this.steps,
    );
  }
}
