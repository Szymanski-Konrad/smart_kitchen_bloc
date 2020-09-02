import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class BottomNavigationState extends Equatable {
  const BottomNavigationState();

  @override
  List<Object> get props => [];
}

class CurrentIndexChanged extends BottomNavigationState {
  final int currentIndex;

  CurrentIndexChanged({@required this.currentIndex});

  @override
  List<Object> get props => [currentIndex];

  @override
  String toString() => 'CurrentIndexChanged: $currentIndex';
}

class PageLoading extends BottomNavigationState {
  @override
  String toString() => 'PageLoading';
}

class RecipesPageLoaded extends BottomNavigationState {
  @override
  String toString() => 'RecipesPageLoaded';
}

class ShopListPageLoaded extends BottomNavigationState {
  @override
  String toString() => 'ShopListPageLoaded';
}

class ProductsPageLoaded extends BottomNavigationState {
  @override
  String toString() => 'ProductsPageLoaded';
}

class PlannerPageLoaded extends BottomNavigationState {
  @override
  String toString() => 'PlannerPageLoaded';
}

class UserPanelPageLoaded extends BottomNavigationState {
  @override
  String toString() => 'UserPanelPageLoaded';
}
