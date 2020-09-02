import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:smart_kitchen/database/kitchen_dao.dart';
import 'package:smart_kitchen/models/models.dart';
import 'recipe_details.dart';

class RecipeDetailsBloc extends Bloc<RecipeDetailsEvent, RecipeDetailsState> {
  KitchenDao repository;

  RecipeDetailsBloc({@required this.repository});

  @override
  RecipeDetailsState get initialState => RecipeDetailsState.empty();

  @override
  Stream<RecipeDetailsState> mapEventToState(RecipeDetailsEvent event) async* {
    if (event is RecipeDetailsLoad) {
      yield* _mapRecipeDetailsLoadToState(event.recipe);
    } else if (event is RescaleRecipe) {
      yield* _mapRescaleRecipeLoadToState(event.scale);
    } else if (event is NutriciousCalculate) {
      yield* _mapNutriciousCalculate();
    }
  }

  Stream<RecipeDetailsState> _mapRecipeDetailsLoadToState(Recipe recipe) async* {
    yield state.update(recipe: recipe);
    // yield RecipeDetailsState.init(recipe);
  }

  Stream<RecipeDetailsState> _mapRescaleRecipeLoadToState(double scale) async* {
    yield state.update(scale: scale);
  }

  Stream<RecipeDetailsState> _mapNutriciousCalculate() {
    
  }
}