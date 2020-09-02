import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:smart_kitchen/models/models.dart';
import 'package:smart_kitchen/models/recipe_model.dart';

abstract class NewRecipeEvent extends Equatable {
  const NewRecipeEvent();

  @override
  List<Object> get props => [];
}

class RecipeCreate extends NewRecipeEvent {
  final String user;

  RecipeCreate({this.user});

  @override
  List<Object> get props => [user];
}

class RecipeEdit extends NewRecipeEvent {
  final Recipe recipe;

  RecipeEdit({@required this.recipe});

  @override
  List<Object> get props => [recipe];
}

class RecipeSave extends NewRecipeEvent {}

class RecipeCancelled extends NewRecipeEvent {}

class AddIngredient extends NewRecipeEvent {
  final String name;
  final String unit;
  final double amount;

  AddIngredient({this.name, this.unit, this.amount});

  @override
  List<Object> get props => [name, unit, amount];
}

class EditIngredient extends NewRecipeEvent {
 final String name;
 final String unit;
 final double amount;
 final int index;

 EditIngredient({this.index, this.name, this.unit, this.amount});

 @override
 List<Object> get props => [index, name, unit, amount]; 
}

class RemoveIngredient extends NewRecipeEvent {
  final int index;

  RemoveIngredient({this.index});

  @override
  List<Object> get props => [index];
}

class AddImagePath extends NewRecipeEvent {
  final String imagePath;

  AddImagePath({this.imagePath});

  @override
  List<Object> get props => [imagePath];
}

class AddStep extends NewRecipeEvent {
  final String step;

  AddStep({this.step});

  @override
  List<Object> get props => [step];
}

class EditStep extends NewRecipeEvent {
  final String step;
  final int index;

  EditStep({this.index, this.step});

  @override
  List<Object> get props => [index, step];
}

class IngredientToStep extends NewRecipeEvent {
  final Ingredient ingredient;

  IngredientToStep({this.ingredient});

  @override
  List<Object> get props => [ingredient];
}

class IngredientFromStep extends NewRecipeEvent {
  final Ingredient ingredient;

  IngredientFromStep({this.ingredient});

  @override
  List<Object> get props => [ingredient];
}

class RemoveStep extends NewRecipeEvent {
  final int index;

  RemoveStep({this.index});

  @override
  List<Object> get props => [index];
}

class EditName extends NewRecipeEvent {
  final String name;

  EditName({this.name});

  @override
  List<Object> get props => [name];
}

class EditCategory extends NewRecipeEvent {
  final String category;

  EditCategory({this.category});

  @override
  List<Object> get props => [category];
}

class EditNotes extends NewRecipeEvent {
  final String notes;

  EditNotes({this.notes});

  @override
  List<Object> get props => [notes];
}