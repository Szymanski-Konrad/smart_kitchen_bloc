import 'package:equatable/equatable.dart';
import 'package:smart_kitchen/models/ingredient_model.dart';

class RecipeStep extends Equatable {
  final int id;
  final String content;
  final int timer;
  final List<Ingredient> ingredients;

  List<int> get ingredientsIDs => ingredients.map((e) => e.id).toList();

  RecipeStep({
    this.id,
    this.content = '',
    this.timer,
    this.ingredients = const [],
  });

  RecipeStep.withContent({
    this.content,
    this.id,
    this.timer = 0,
    this.ingredients = const [],
  });

  RecipeStep.empty({
    this.id,
    this.content = '',
    this.timer = 0,
    this.ingredients = const [],
  });

  RecipeStep copyWith({int id, String content, int timer, List<Ingredient> ingredients}) {
    return RecipeStep(
        id: id ?? this.id,
        content: content ?? this.content,
        timer: timer ?? this.timer,
        ingredients: ingredients ?? this.ingredients);
  }

  @override
  List<Object> get props => [id, content, timer, ingredients];

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'content': content,
      'timer': timer,
      'ingredients': ingredients.map((i) => i.id.toString()).join(',')
    };
  }

  static RecipeStep fromMap(Map<String, dynamic> map, List<Ingredient> ingredients) {
    if (map == null) return null;

    return RecipeStep(
      id: map['id'],
      content: map['content'],
      timer: map['timer'],
      ingredients: ingredients,
    );
  }

  @override
  String toString() => 'RecipeStep(id: $id, content: $content, timer: $timer, ingredients: $ingredients)';
}
