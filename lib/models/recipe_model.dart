import 'package:equatable/equatable.dart';
import 'ingredient_model.dart';
import 'recipe_step_model.dart';

class Recipe extends Equatable {
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

  Recipe({
    this.id,
    this.name,
    this.category,
    this.imagePath,
    this.notes = '',
    this.user = 'Admin',
    this.rating = 0.0,
    this.ratingCount = 0,
    this.ingredients = const [],
    this.steps = const [],
  });

  String get showRating => rating.toStringAsFixed(2);

  Map<String, dynamic> toInsertMap() {
    return {
      'name': name,
      'user': user,
      'category': category,
      'imagePath': imagePath,
      'notes': notes,
      'rating': rating,
      'ratingCount': ratingCount,
    };
  }

  Map<String, dynamic> toUpdateMap() {
    return {
      'id': id,
      'name': name,
      'user': user,
      'category': category,
      'imagePath': imagePath,
      'notes': notes,
      'rating': rating,
      'ratingCount': ratingCount,
    };
  }

  static Recipe fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Recipe(
      id: map['id'],
      name: map['name'],
      category: map['category'],
      imagePath: map['imagePath'],
      notes: map['notes'],
      user: map['user'],
      rating: map['rating'],
      ratingCount: map['ratingCount'],
    );
  }

  @override
  List<Object> get props =>
      [id, name, category, imagePath, notes, user, rating, ratingCount, ingredients, steps];

  @override
  String toString() {
    return 'Recipe(id: $id, name: $name, category: $category, imagePath: $imagePath, notes: $notes, user: $user, rating: $rating, ratingCount: $ratingCount, ingredients: $ingredients, steps: $steps)';
  }

  Recipe update({
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
    return copyWith(
      id: id,
      name: name,
      category: category,
      imagePath: imagePath,
      notes: notes,
      user: user,
      rating: rating,
      ratingCount: ratingCount,
      ingredients: ingredients,
      steps: steps,
    );
  }

  Recipe copyWith({
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
    return Recipe(
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
