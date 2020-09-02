import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:smart_kitchen/blocs/authenticate/auth.dart';
import 'package:smart_kitchen/blocs/blocs.dart';
import 'package:smart_kitchen/database/kitchen_dao.dart';
import 'package:smart_kitchen/models/models.dart';
import 'package:smart_kitchen/ui/new_recipe_screen.dart';
import 'new_recipe.dart';
import 'package:meta/meta.dart';

class NewRecipeBloc extends Bloc<NewRecipeEvent, NewRecipeState> {
  AuthBloc authBloc;
  RecipesBloc recipesBloc;
  KitchenDao repository;

  int editIndex;

  NewRecipeBloc({@required this.authBloc, @required this.recipesBloc}) {
    repository = KitchenDao();
    editIndex = -1;
  }

  List<Ingredient> get avaliableIngredient => List.from(state.freeIngredients);
  List<Ingredient> get stepIngredients => editIndex != -1
      ? List.from(state.steps[editIndex].ingredients)
      : List.from(state.steps[state.steps.length - 1].ingredients);

  String get stepContent => editIndex == -1 ? '' : state.steps[editIndex].content;

  @override
  NewRecipeState get initialState => NewRecipeState.empty((authBloc.state as Authenticated).displayName);

  @override
  Stream<NewRecipeState> mapEventToState(NewRecipeEvent event) async* {
    if (event is RecipeCreate) {
      yield* _mapRecipeCreateToState();
    } else if (event is RecipeEdit) {
      yield* _mapRecipeEditToState(event.recipe);
    } else if (event is RecipeSave) {
      yield* _mapRecipeSaveToState();
    } else if (event is RecipeCancelled) {
      yield* _mapRecipeCancelledToState();
    } else if (event is AddIngredient) {
      yield* _mapAddIngredientToState(event.name, event.unit, event.amount);
    } else if (event is EditIngredient) {
      yield* _mapEditIngredientToState(event.name, event.unit, event.amount, event.index);
    } else if (event is RemoveIngredient) {
      yield* _mapRemoveIngredientToState(event.index);
    } else if (event is AddImagePath) {
      yield* _mapAddImagePathToState(event.imagePath);
    } else if (event is AddStep) {
      yield* _mapAddStepToState(event.step);
    } else if (event is EditStep) {
      yield* _mapEditStepToState(event.step, event.index);
    } else if (event is RemoveStep) {
      yield* _mapRemoveStepToState(event.index);
    } else if (event is EditName) {
      yield* _mapEditNameToState(event.name);
    } else if (event is EditCategory) {
      yield* _mapEditCategoryToState(event.category);
    } else if (event is EditNotes) {
      yield* _mapEditNotesToState(event.notes);
    } else if (event is IngredientToStep) {
      yield* _mapIngredientToStepToState(event.ingredient);
    } else if (event is IngredientFromStep) {
      yield* _mapIngredientFromStepToState(event.ingredient);
    }
  }

  Stream<NewRecipeState> _mapIngredientToStepToState(Ingredient ingredient) async* {
    List<RecipeStep> steps = List.from(state.steps);
    if (editIndex == -1) {
      RecipeStep step = steps.last;
      step = step.copyWith(ingredients: List.from(step.ingredients)..add(ingredient));
      steps.replaceRange(steps.length - 1, steps.length, [step]);
    } else {
      RecipeStep step = steps[editIndex];
      step = step.copyWith(ingredients: List.from(step.ingredients)..add(ingredient));
      steps.replaceRange(editIndex, editIndex + 1, [step]);
    }
    yield state.update(steps: steps);
  }

  Stream<NewRecipeState> _mapIngredientFromStepToState(Ingredient ingredient) async* {
    List<RecipeStep> steps = List.from(state.steps);
    if (editIndex == -1) {
      RecipeStep step = steps.last;
      step = step.copyWith(ingredients: List.from(step.ingredients)..remove(ingredient));
      steps.replaceRange(steps.length - 1, steps.length, [step]);
    } else {
      RecipeStep step = steps[editIndex];
      step = step.copyWith(ingredients: List.from(step.ingredients)..remove(ingredient));
      steps.replaceRange(editIndex, editIndex + 1, [step]);
    }
    yield state.update(steps: steps);
  }

  Stream<NewRecipeState> _mapRecipeCreateToState() async* {
    yield NewRecipeState.empty((authBloc.state as Authenticated).displayName);
  }

  Stream<NewRecipeState> _mapRecipeEditToState(Recipe recipe) async* {
    yield NewRecipeState.toEdit(recipe);
  }

  Stream<NewRecipeState> _mapRecipeSaveToState() async* {
    Recipe recipe = Recipe(
        category: state.category,
        id: state.id,
        imagePath: state.imagePath,
        ingredients: state.ingredients,
        name: state.name,
        notes: state.notes,
        rating: state.rating,
        ratingCount: state.ratingCount,
        steps: state.steps,
        user: state.user);

    recipesBloc.add(AddRecipe(recipe: recipe));
    yield NewRecipeState.empty((authBloc.state as Authenticated).displayName);
  }

  Stream<NewRecipeState> _mapRecipeCancelledToState() async* {
    yield NewRecipeState.empty((authBloc.state as Authenticated).displayName);
  }

  Stream<NewRecipeState> _mapAddIngredientToState(String name, String unit, double amount) async* {
    List<Ingredient> list = state.ingredients;
    list.add(Ingredient(name: name, unit: unit, amount: amount, scale: 1.0));
    yield state.update(ingredients: list);
  }

  Stream<NewRecipeState> _mapEditIngredientToState(String name, String unit, double amount, int index) async* {
    List<Ingredient> list = state.ingredients;
    list.replaceRange(index, index + 1, [Ingredient(scale: 1.0, name: name, unit: unit, amount: amount)]);
    yield state.update(ingredients: list);
  }

  Stream<NewRecipeState> _mapRemoveIngredientToState(int index) async* {
    List<Ingredient> list = List.from(state.ingredients);
    Ingredient ingredient = list[index];
    list.removeAt(index);
    state.steps.forEach((element) => element.ingredients.remove(ingredient));
    yield state.update(ingredients: list);
  }

  Stream<NewRecipeState> _mapAddImagePathToState(String imagePath) async* {
    yield state.update(imagePath: imagePath);
  }

  Stream<NewRecipeState> _mapAddStepToState(String step) async* {
    List<RecipeStep> list = state.steps;
    list.add(RecipeStep(content: step));
    yield state.update(steps: list);
  }

  Stream<NewRecipeState> _mapEditStepToState(String step, int index) async* {
    List<RecipeStep> list = List.from(state.steps);
    RecipeStep recipeStep = list[index];
    recipeStep = recipeStep.copyWith(content: step);
    list.replaceRange(index, index + 1, [recipeStep]);
    yield state.update(steps: list);
  }

  Stream<NewRecipeState> _mapRemoveStepToState(int index) async* {
    List<RecipeStep> list = state.steps;
    if (index == -1) {
      list.removeLast();
    } else {
      list.removeAt(index);
    }
    yield state.update(steps: list);
  }

  Stream<NewRecipeState> _mapEditNameToState(String name) async* {
    yield state.update(name: name);
  }

  Stream<NewRecipeState> _mapEditCategoryToState(String category) async* {
    yield state.update(category: category);
  }

  Stream<NewRecipeState> _mapEditNotesToState(String notes) async* {
    yield state.update(notes: notes);
  }
}
