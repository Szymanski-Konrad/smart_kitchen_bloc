import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:smart_kitchen/models/models.dart';

abstract class RecipesEvent extends Equatable{
  const RecipesEvent();

  @override
  List<Object> get props => [];
}

class RecipesLoad extends RecipesEvent {}

class CategoryChanged extends RecipesEvent {
  final String category;

  CategoryChanged({@required this.category});

  @override
  List<Object> get props => [category];

  @override
  String toString() => 'CategoryChanged { category: $category }';
}

class ReloadRecipes extends RecipesEvent {}

class SearchStringChanged extends RecipesEvent {
  final String searchString;

  SearchStringChanged({@required this.searchString});

  @override
  List<Object> get props => [searchString];

  @override
  String toString() => 'SearchStringChanged { searchString: $searchString }';
}

class UserRecipes extends RecipesEvent {
  final String user;

  UserRecipes({@required this.user});

  @override
  List<Object> get props => [user];

  @override
  String toString() => 'UserRecipes { user: $user }';
}

class RemoveRecipe extends RecipesEvent {
  final Recipe recipe;

  RemoveRecipe({@required this.recipe});

  @override
  List<Object> get props => [recipe];

  @override
  String toString() => 'RemoveRecipe { recipe: $recipe }';
}

class StarRecipe extends RecipesEvent {
  final Recipe recipe;
  final double stars;

  StarRecipe({this.recipe, this.stars});

  @override
  List<Object> get props => [recipe, stars];
}

class AddRecipe extends RecipesEvent {
  final Recipe recipe;

  AddRecipe({@required this.recipe});

  @override
  List<Object> get props => [recipe];
}