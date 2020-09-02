import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../models/models.dart';

class RecipeDetailsState {
  final Recipe recipe;
  final double scale;
  final double kcal;
  final double fat;
  final double carbo;
  final double protein;
  final double cellulose;
  final double salt;

  RecipeDetailsState(
      {this.recipe, this.scale, this.kcal, this.fat, this.carbo, this.protein, this.cellulose, this.salt});

  factory RecipeDetailsState.empty() {
    return RecipeDetailsState(
      carbo: 0.0,
      cellulose: 0.0,
      fat: 0.0,
      kcal: 0.0,
      protein: 0.0,
      recipe: null,
      salt: 0.0,
      scale: 1.0,
    );
  }

  factory RecipeDetailsState.init(Recipe recipe) {
    return RecipeDetailsState(
      carbo: 0.0,
      cellulose: 0.0,
      fat: 0.0,
      kcal: 0.0,
      protein: 0.0,
      recipe: recipe,
      salt: 0.0,
      scale: 1.0,
    );
  }

  bool get hasImage => this.recipe.imagePath != null && this.recipe.imagePath.isNotEmpty;
  bool get plannerCategory => recipe.category == "Śniadanie" || recipe.category == "Obiad" || recipe.category == "Kolacja";
  List<Ingredient> get ingredients => this.recipe.ingredients;
  List<RecipeStep> get steps => this.recipe.steps;

  RecipeDetailsState update({
    Recipe recipe,
    double scale,
    double kcal,
    double fat,
    double carbo,
    double protein,
    double cellulose,
    double salt,
  }) {
    return copyWith(
      carbo: carbo,
      cellulose: cellulose,
      fat: fat,
      kcal: kcal,
      protein: protein,
      salt: salt,
      scale: scale,
      recipe: recipe,
    );
  }

  RecipeDetailsState copyWith({
    Recipe recipe,
    double scale,
    double kcal,
    double fat,
    double carbo,
    double protein,
    double cellulose,
    double salt,
  }) {
    return RecipeDetailsState(
      recipe: recipe ?? this.recipe,
      scale: scale ?? this.scale,
      kcal: kcal ?? this.kcal,
      fat: fat ?? this.fat,
      carbo: carbo ?? this.carbo,
      protein: protein ?? this.protein,
      cellulose: cellulose ?? this.cellulose,
      salt: salt ?? this.salt,
    );
  }
}
