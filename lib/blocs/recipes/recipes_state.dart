import 'package:smart_kitchen/models/models.dart';

class RecipesState {
  final List<Recipe> recipes;
  final String searchString;
  final String selectedCategory;
  final String currentUser;

  RecipesState({this.recipes, this.searchString, this.selectedCategory, this.currentUser});

  RecipesState.init({this.recipes = const [], this.searchString = '', this.selectedCategory = 'Śniadanie', this.currentUser = ''});

  List<Recipe> get userRecipes => this.recipes.where((element) => element.user == currentUser).toList();
  List<Recipe> get categoryRecipes => this.recipes.where((element) => element.category == selectedCategory).toList();
  List<Recipe> get filterRecipes => this.recipes.where((element) => element.name.contains(searchString)).toList();
  List<Recipe> get recipesList => searchString.length > 0 ? filterRecipes : categoryRecipes;

  List<Recipe> get breakfast => this.recipes.where((element) => element.category == "Śniadanie").toList();
  List<Recipe> get dinner => this.recipes.where((element) => element.category == "Obiad").toList();
  List<Recipe> get supper => this.recipes.where((element) => element.category == "Kolacja").toList();

  bool get plannerAvaliable => breakfast.length >= 3 && dinner.length >= 3 && supper.length >= 3;
  

  List<Recipe> recipesFromID(List<int> indexes) {
    return recipes.where((element) => indexes.contains(element.id)).toList();
  }

  RecipesState update({
    List<Recipe> recipes,
    String searchString,
    String selectedCategory,
    String currentUser
  }) {
    return copyWith(
      currentUser: currentUser,
      selectedCategory: selectedCategory,
      searchString: searchString,
      recipes: recipes,
    );
  }

  RecipesState copyWith({
    List<Recipe> recipes,
    String searchString,
    String selectedCategory,
    String currentUser,
  }) {
    return RecipesState(
      recipes: recipes ?? this.recipes,
      searchString: searchString ?? this.searchString,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      currentUser: currentUser ?? this.currentUser,
    );
  }
}