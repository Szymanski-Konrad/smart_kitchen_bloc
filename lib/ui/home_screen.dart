import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_kitchen/blocs/bottom_nagiation/bottom_navigation.dart';
import 'package:smart_kitchen/ui/account_panel_screen.dart';
import 'package:smart_kitchen/ui/planner_screen.dart';
import 'package:smart_kitchen/ui/recipes_home_screen.dart';
import 'package:smart_kitchen/ui/shoplist_screen.dart';
import '../helpers/list_constants.dart';

class HomeScreen extends StatelessWidget {
  final String name;

  HomeScreen({this.name});

  @override
  Widget build(BuildContext context) {
    final BottomNavigationBloc bottomNavigationBloc = BlocProvider.of<BottomNavigationBloc>(context);

    return Scaffold(
      body: BlocBuilder<BottomNavigationBloc, BottomNavigationState>(
        builder: (context, state) {
          if (state is PageLoading) {
            return Center(child: CircularProgressIndicator());
          }
          if (state is ShopListPageLoaded) {
            return ShopCart();
          }
          if (state is RecipesPageLoaded) {
            return RecipesHome();
          }
          if (state is ProductsPageLoaded) {
            return Text("Products");
          }
          if (state is PlannerPageLoaded) {
            return PlannerScreen();
          }
          if (state is UserPanelPageLoaded) {
            return AccountPanel();
          }
          return Center(child: Text("Page not implemented"),);
        },
      ),
      bottomNavigationBar: BlocBuilder<BottomNavigationBloc, BottomNavigationState>(
        builder: (context, state) {
          return BottomNavigationBar(
            currentIndex: bottomNavigationBloc.currentIndex,
            items: bottomIcons,
            onTap: (index) => bottomNavigationBloc.add(PageTapped(index: index)),
          );
        }
      )
    );
  }
}