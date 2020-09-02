import 'package:smart_kitchen/helpers/examples.dart';
import 'package:smart_kitchen/models/models.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseProvider {
  static final DatabaseProvider _instance = DatabaseProvider._internal();
  static Database _database;

  DatabaseProvider._internal();

  factory DatabaseProvider() {
    return _instance;
  }

  Future<Database> get db async {
    if (_database != null) return _database;
    _database = await createDatabase();
    return _database;
  }

  createDatabase() async {
    var databasePath = await getDatabasesPath();
    String path = join(databasePath, 'smart_kitchen.db');
    var database = await openDatabase(path, version: 2, onCreate: initDb);
    return database;
  }

  void initDb(Database database, int version) async {
    await database.execute('''CREATE TABLE recipe(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT,
      category TEXT,
      imagePath TEXT,
      notes TEXT,
      user TEXT,
      rating REAL,
      ratingCount INTEGER)
    ''');

    await database.execute('''CREATE TABLE ingredient(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      recipeID INTEGER,
      name TEXT,
      unit TEXT,
      amount REAL)
    ''');

    await database.execute('''CREATE TABLE step(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      recipeID INTEGER,
      content TEXT,
      timer INTEGER,
      ingredients TEXT)
      ''');

    await database.execute('''CREATE TABLE product(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      barcode TEXT,
      name TEXT,
      price REAL,
      unit TEXT,
      amount REAL,
      priceAmount REAL,
      kcal REAL,
      fat REAL,
      carbohydrates REAL,
      protein REAL,
      cellulose REAL,
      salt REAL)
      ''');

    await database.execute('''CREATE TABLE shoplist(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      barcode TEXT,
      name TEXT,
      price REAL,
      editable INTEGER)
      ''');

    await database.execute('''CREATE TABLE planner(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      date TEXT,
      dishes TEXT)
      ''');

    await initializeData(database);
  }

  Future initializeData(Database database) async {
    for (var i in exampleRecipes()) {
      await insertCompleteRecipe(i, database);
    }

    // for (var i in exampleShopList()) {
    //   await insertOnShopList(i.toMap());
    // }

    // for (var i in exampleProducts()) {
    //   await insertProduct(i.toMap());
    // }
  }

  Future<int> insertCompleteRecipe(Recipe recipe, Database database) async {
    
    int id = await database.insert('recipe', recipe.toInsertMap());

    recipe.steps.forEach((step) async {
      await insertStep(step.toMap(), id, database);
    });

    recipe.ingredients.forEach((ingredient) async {
      await insertIngredient(ingredient.toMap(), id, database);
    });

    return id;
  }

  /// Insert ingredient to database
  Future<int> insertIngredient(Map<String, dynamic> row, int recipeID, Database database) async {
    row['recipeID'] = recipeID;
    return await database.insert('ingredient', row);
  }

  /// Insert recipe step to database 
  Future<int> insertStep(Map<String, dynamic> row, int recipeID, Database database) async {
    row['recipeID'] = recipeID;
    return await database.insert('step', row);
  }
}