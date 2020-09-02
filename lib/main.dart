import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_kitchen/blocs/new_recipe/new_recipe.dart';
import 'package:smart_kitchen/blocs/planner/planner.dart';
import 'package:smart_kitchen/blocs/recipe_details/recipe_details.dart';
import 'package:smart_kitchen/blocs/settings/settings.dart';
import 'package:smart_kitchen/router.dart';
import 'package:smart_kitchen/simple_bloc_delegate.dart';
import 'database/kitchen_dao.dart';
import 'repository/login_repository.dart';
import 'blocs/blocs.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  BlocSupervisor.delegate = SimpleBlocDelegate();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<AuthBloc>(
        create: (context) {
          return AuthBloc(loginRepository: LoginRepository())..add(AppStarted());
        },
      ),
      BlocProvider<RecipesBloc>(
        create: (context) {
          return RecipesBloc()..add(RecipesLoad());
        }
      ),
      BlocProvider<BottomNavigationBloc>(
        create: (context) {
          return BottomNavigationBloc(
            authBloc: BlocProvider.of<AuthBloc>(context),
            recipesBloc: BlocProvider.of<RecipesBloc>(context),
          )..add(BottomStarted());
        }
      ),
      BlocProvider<ShopListBloc>(
        create: (context) {
          return ShopListBloc()..add(ShopListLoad());
        },
      ),
      BlocProvider<NewRecipeBloc>(
        create: (context) {
          return NewRecipeBloc(authBloc: BlocProvider.of<AuthBloc>(context), recipesBloc: BlocProvider.of<RecipesBloc>(context))..add(RecipeCreate());
        }
      ),
      BlocProvider<SettingsBloc>(
        create: (context) {
          return SettingsBloc();
        }
      ),
      BlocProvider<RecipeDetailsBloc>(
        create: (context) {
          return RecipeDetailsBloc(repository: KitchenDao());
        }
      ),
      BlocProvider<PlannerBloc>(
        create: (context) {
          return PlannerBloc(recipesBloc: BlocProvider.of<RecipesBloc>(context))..add(PlannerLoad());
        },
      )
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Kitchen',
      theme: ThemeData(
        canvasColor: Colors.indigo,
        focusColor: Colors.white,
        primarySwatch: Colors.blue,
        buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
        //visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      onGenerateRoute: Router.generateRoute,
    );
  }
}
