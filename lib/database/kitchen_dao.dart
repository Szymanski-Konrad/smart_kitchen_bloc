import 'dart:async';
import 'package:smart_kitchen/models/planner_model.dart';
import 'package:smart_kitchen/models/shop_item_model.dart';

import 'database.dart';
import '../models/models.dart';

class KitchenDao {
  final dbProvider = DatabaseProvider();

  List<Ingredient> getStepIngredients(String stepString, List<Ingredient> ingredients) {
    print(stepString);
    print(stepString != null && stepString.isNotEmpty);
    if (stepString != null && stepString.isNotEmpty) {
      List<int> list = stepString.split(',').map((e) => int.parse(e)).toList();
      return ingredients.where((element) => list.contains(element.id));
    }
    else {
      return [];
    }
  }

  /// Fetch single recipe from database
  Future<Recipe> fetchSingleRecipe(Recipe recipe) async {
    final db = await dbProvider.db;
    var ingredientsResult = await db.query('ingredient', where: 'recipeID = ?', whereArgs: [recipe.id]);
    var stepsResult = await db.query('step', where: 'recipeID = ?', whereArgs: [recipe.id]);
    List<Ingredient> ingredients = ingredientsResult.map((ingredient) => Ingredient.fromMap(ingredient)).toList();
    List<RecipeStep> steps = stepsResult.map((e) => RecipeStep.fromMap(e, getStepIngredients(e['ingredients'], ingredients))).toList();
    return recipe.copyWith(
      ingredients: ingredients,
      steps: steps,
    );
  }

  /// Fetch all recipes from database
  Future<List<Recipe>> fetchRecipes() async {
    final db = await dbProvider.db;
    var result = await db.query('recipe');
    var recipesResult = result.map((map) => Recipe.fromMap(map));
    var recipes = recipesResult.map((e) async => fetchSingleRecipe(e));
    return Future.wait(recipes);
  }

  /// Fetch all user recipes from database
  Future<List<Recipe>> fetchUserRecipes(String userName) async {
    final db = await dbProvider.db;
    var result = await db.query('recipe', where: 'user = ?', whereArgs: [userName]);
    var recipesResult = result.map((map) => Recipe.fromMap(map));
    return Future.wait(recipesResult.map((e) async => fetchSingleRecipe(e)));
  }

  /// Fetch recipes based on search string
  Future<List<Recipe>> fetchSearchedRecipes(String searchString) async {
    final db = await dbProvider.db;
    var result = await db.query('recipe', where: "name LIKE ?", whereArgs: ['%$searchString%']);
    var recipesResult = result.map((map) => Recipe.fromMap(map));
    return Future.wait(recipesResult.map((e) async => fetchSingleRecipe(e)));
  }

  /// Fetch recipes based on category
  Future<List<Recipe>> fetchCategoryRecipes(String category) async {
    final db = await dbProvider.db;
    var result = await db.query('recipe', where: 'category = ?', whereArgs: [category]);
    var recipesResult = result.map((map) => Recipe.fromMap(map));
    return Future.wait(recipesResult.map((e) async => fetchSingleRecipe(e)));
  }

  /// Fetch shoplist from database
  Future<List<ShopItem>> fetchShopList() async {
    final db = await dbProvider.db;
    var result = await db.query('shoplist');
    return result.map((map) => ShopItem.fromMap(map)).toList();
  }

  /// Insert recipe with ingredients, steps and cooking steps
  Future<int> insertCompleteRecipe(Recipe recipe) async {
    final db = await dbProvider.db;
    int id = await db.insert('recipe', recipe.toInsertMap());

    recipe.steps.forEach((step) async {
      await insertStep(step.toMap(), id);
    });

    recipe.ingredients.forEach((ingredient) async {
      await insertIngredient(ingredient.toMap(), id);
    });

    return id;
  }

  /// Insert ingredient to database
  Future<int> insertIngredient(Map<String, dynamic> row, int recipeID) async {
    final db = await dbProvider.db;
    row['recipeID'] = recipeID;
    return await db.insert('ingredient', row);
  }

  /// Insert recipe step to database
  Future<int> insertStep(Map<String, dynamic> row, int recipeID) async {
    final db = await dbProvider.db;
    row['recipeID'] = recipeID;
    return await db.insert('step', row);
  }

  /// Insert product to database
  Future<int> insertProduct(Map<String, dynamic> row) async {
    final db = await dbProvider.db;
    return await db.insert('product', row);
  }

  /// Insert product from shoplist to database
  Future<int> insertOnShopList(Map<String, dynamic> row) async {
    final db = await dbProvider.db;
    return await db.insert('shoplist', row);
  }

  /// Insert planner day to database
  Future<int> insertPlannerDay(Map<String, dynamic> row) async {
    final db = await dbProvider.db;
    return await db.insert('planner', row);
  }

  /// Remove item from shoplist
  Future removeFromShopList(ShopItem item) async {
    final db = await dbProvider.db;
    db.delete('shoplist', where: 'id = ?', whereArgs: [item.id]);
  }

  /// Update shop item
  Future updateShopItem(ShopItem item) async {
    final db = await dbProvider.db;
    db.update('shoplist', item.toMap(), where: 'id = ? ', whereArgs: [item.id]);
  }

  /// Update edited recipe
  Future updateCompleteRecipe(Recipe recipe) async {
    final db = await dbProvider.db;
    db.update('recipe', recipe.toUpdateMap(), where: 'id = ?', whereArgs: [recipe.id]);
    recipe.ingredients.forEach((item) async {
      int number = await db
          .update('ingredient', item.toMap(), where: 'recipeID = ? and id = ?', whereArgs: [recipe.id, item.id]);
      if (number == 0) insertIngredient(item.toMap(), recipe.id);
    });
    recipe.steps.forEach((item) async {
      int number =
          await db.update('step', item.toMap(), where: 'recipeID = ? and id = ?', whereArgs: [recipe.id, item.id]);
      if (number == 0) insertStep(item.toMap(), recipe.id);
    });
  }

  /// Remove recipe from database
  Future removeRecipe(Recipe recipe) async {
    final db = await dbProvider.db;
    recipe.ingredients.forEach((element) async => await removeIngredient(recipe.id));
    recipe.steps.forEach((element) async => await removeStep(recipe.id));
    db.delete('recipe', where: 'id = ?', whereArgs: [recipe.id]);
  }

  /// Remove ingredient from database
  Future removeIngredient(int recipeID) async {
    final db = await dbProvider.db;
    db.delete('ingredient', where: 'recipeID = ?', whereArgs: [recipeID]);
  }

  /// Remove step from database
  Future removeStep(int recipeID) async {
    final db = await dbProvider.db;
    db.delete('step', where: 'recipeID = ?', whereArgs: [recipeID]);
  }

  /// Remove planner day from database
  Future removePlannerDay(DateTime day) async {
    final db = await dbProvider.db;
    db.delete('planner', where: 'date = ?', whereArgs: [day.toString()]);
  }

  /// Update planner day into database
  Future updatePlannerDay(PlannerDay plannerDay) async {
    final db = await dbProvider.db;
    db.update('planner', plannerDay.toMap(), where: 'date = ?', whereArgs: [plannerDay.date]);
  }

  // Fetch all planner days from database
  Future<List<PlannerDay>> fetchAllPlannerDays() async {
    final db = await dbProvider.db;
    var result = await db.query('planner');
    return result.map((e) => PlannerDay.fromMap(e)).toList();
  }

  /// Get planner day from database
  Future getPlannerDay(DateTime date) async {
    final db = await dbProvider.db;
    var result = await db.query('planner', where: 'date = ?', whereArgs: [date]);
    return result.map((e) => PlannerDay.fromMap(e)).first;
  }
}
