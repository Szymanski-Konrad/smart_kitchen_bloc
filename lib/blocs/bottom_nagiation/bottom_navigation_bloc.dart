import 'dart:async';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_kitchen/blocs/authenticate/auth.dart';
import 'package:smart_kitchen/blocs/recipes/recipes.dart';
import 'bottom_navigation.dart';

class BottomNavigationBloc extends Bloc<BottomNavigationEvent, BottomNavigationState> {
  int currentIndex = 0;
  AuthBloc authBloc;
  RecipesBloc recipesBloc;

  BottomNavigationBloc({@required this.authBloc, @required this.recipesBloc});

  @override
  BottomNavigationState get initialState => PageLoading();

  @override
  Stream<BottomNavigationState> mapEventToState(BottomNavigationEvent event) async* {
    if (event is BottomStarted) {
      this.add(PageTapped(index: currentIndex));
    }
    if (event is PageTapped) {
      this.currentIndex = event.index;
      yield CurrentIndexChanged(currentIndex: this.currentIndex);
      yield PageLoading();

      if (this.currentIndex == 0) {
        yield ShopListPageLoaded();
      }
      if (this.currentIndex == 1) {
        // recipesBloc.add(CategoryChanged(category: recipesBloc.currentCategory));
        yield RecipesPageLoaded();
      }
      if (this.currentIndex == 2) {
        yield ProductsPageLoaded();
      }
      if (this.currentIndex == 3) {
        yield PlannerPageLoaded();
      }
      if (this.currentIndex == 4) {
        recipesBloc.add(UserRecipes(user: (authBloc.state as Authenticated).displayName));
        yield UserPanelPageLoaded();
      }
    }
  }
}
