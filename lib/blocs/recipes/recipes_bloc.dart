import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:smart_kitchen/database/kitchen_dao.dart';
import 'package:smart_kitchen/models/models.dart';
import 'recipes.dart';
import 'package:rxdart/rxdart.dart';

class RecipesBloc extends Bloc<RecipesEvent, RecipesState> {
  KitchenDao repository;

  RecipesBloc() {
    repository = KitchenDao();
  }

  @override
  RecipesState get initialState => RecipesState.init();

  @override
  Stream<Transition<RecipesEvent, RecipesState>> transformEvents(
      Stream<RecipesEvent> events, TransitionFunction<RecipesEvent, RecipesState> transitionFn) {
    final nonDebounceStream = events.where((event) => event is! SearchStringChanged).asyncExpand(transitionFn);
    final debounceStream = events
        .where((event) => event is SearchStringChanged)
        .debounceTime(Duration(milliseconds: 200))
        .distinct()
        .switchMap(transitionFn);
    return nonDebounceStream.mergeWith([debounceStream]);
  }

  @override
  Stream<RecipesState> mapEventToState(RecipesEvent event) async* {
    if (event is RecipesLoad) {
      yield* _mapRecipesLoadToState();
    } else if (event is CategoryChanged) {
      yield* _mapCategoryChangedToState(event.category);
    } else if (event is SearchStringChanged) {
      yield* _mapSearchStringToState(event.searchString);
    } else if (event is UserRecipes) {
      yield* _mapUserChangeToState(event.user);
    } else if (event is ReloadRecipes) {
      yield* _mapRecipesLoadToState();
    } else if (event is RemoveRecipe) {
      yield* _mapRemoveRecipeToState(event.recipe);
    } else if (event is StarRecipe) {
      yield* _mapStarRecipeToState(event.recipe, event.stars);
    } else if (event is AddRecipe) {
      yield* _mapAddRecipeToState(event.recipe);
    }
  }

  /// Add new recipe
  Stream<RecipesState> _mapAddRecipeToState(Recipe recipe) async* {
    if (recipe.id < 0) {
      int id = await repository.insertCompleteRecipe(recipe);
      recipe = recipe.update(id: id);
      final recipes = List<Recipe>.from(state.recipes);
      recipes..add(recipe);
      yield state.update(recipes: recipes);
    }
    else {
      await repository.updateCompleteRecipe(recipe);
      final recipes = state.recipes;
      int index = recipes.indexWhere((element) => element.id == recipe.id);
      recipes.replaceRange(index, index + 1, [recipe]);
      yield state.update(recipes: recipes);
    }
  }

  /// Change category in state
  Stream<RecipesState> _mapCategoryChangedToState(String category) async* {
    yield state.update(selectedCategory: category);
  }

  /// Change searchString in state
  Stream<RecipesState> _mapSearchStringToState(String searchString) async* {
    yield state.update(searchString: searchString);
  }

  /// Change current user in state
  Stream<RecipesState> _mapUserChangeToState(String userName) async* {
    yield state.update(currentUser: userName);
  }

  /// Load recipes on given parameters
  Stream<RecipesState> _mapRecipesLoadToState() async* {
    try {
      final recipes = await repository.fetchRecipes();
      yield state.update(recipes: recipes);
    } catch (e) {
      print("Error with loading recipes");
      print(e);
    }
  }

  /// Star recipe
  Stream<RecipesState> _mapStarRecipeToState(Recipe recipe, double stars) async* {
    double sum = recipe.rating * recipe.ratingCount + stars;
    double newRating = sum / (recipe.ratingCount + 1);
    Recipe starred = recipe.update(ratingCount: recipe.ratingCount + 1, rating: newRating);
    final index = state.recipes.indexOf(recipe);
    try {
      await repository.updateCompleteRecipe(starred);
    } catch (e) {
      print("Error with starring recipe");
      print(e);
    }
    final recipes = List<Recipe>.from(state.recipes);
    recipes.replaceRange(index, index + 1, [starred]);
    yield state.update(recipes: recipes);
  }

  /// Remove recipe from database
  Stream<RecipesState> _mapRemoveRecipeToState(Recipe recipe) async* {
    try {
      await repository.removeRecipe(recipe);
      final recipes = state.recipes..remove(recipe);
      yield state.update(recipes: recipes);
    } catch (e) {
      print("Error with removing recipes");
      print(e);
    }
  }
}
