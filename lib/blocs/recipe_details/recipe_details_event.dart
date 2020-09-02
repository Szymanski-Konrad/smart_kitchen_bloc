import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import '../../models/models.dart';

abstract class RecipeDetailsEvent extends Equatable {
  const RecipeDetailsEvent();

  @override
  List<Object> get props => [];
}

class RecipeDetailsLoad extends RecipeDetailsEvent {
  final Recipe recipe;

  RecipeDetailsLoad({this.recipe});

  @override
  List<Object> get props => [recipe];
}

class NutriciousCalculate extends RecipeDetailsEvent {}

class RescaleRecipe extends RecipeDetailsEvent {
  final double scale;

  RescaleRecipe({@required this.scale});

  @override
  List<Object> get props => [scale];
}

