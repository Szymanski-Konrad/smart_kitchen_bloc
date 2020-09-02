import 'package:flutter/material.dart';
import 'package:smart_kitchen/repository/login_repository.dart';
import 'package:smart_kitchen/ui/account_panel_screen.dart';
import 'package:smart_kitchen/ui/ingredient_screen.dart';
import 'package:smart_kitchen/ui/new_recipe_screen.dart';
import 'package:smart_kitchen/ui/recipe_screen.dart';
import 'package:smart_kitchen/ui/step_screen.dart';
import 'helpers/constants.dart';
import 'ui/welcome_screen.dart';
import 'ui/login_screen.dart';
import 'ui/register_screen.dart';
// import 'package:smart_kitchen/models/product_model.dart';
// import 'package:smart_kitchen/models/recipe_model.dart';
// import 'package:smart_kitchen/screens/shoplist.dart';
// import 'package:smart_kitchen/screens/cooking.dart';
// import 'package:smart_kitchen/screens/home.dart';
// import 'package:smart_kitchen/screens/temp_screen.dart';
// import 'package:smart_kitchen/screens/new_product.dart';
// import 'package:smart_kitchen/screens/cooking_prepare.dart';
// import 'package:smart_kitchen/screens/recipe_detalis.dart';
// import 'package:smart_kitchen/screens/schuffle.dart';
// import 'package:smart_kitchen/widgets/newRecipeHero.dart';
// import 'package:smart_kitchen/widgets/product_card.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case checkRoute:
        return MaterialPageRoute(builder: (_) => Welcome());
      case loginRoute:
        return MaterialPageRoute(builder: (_) => LoginScreen(loginRepository: LoginRepository(),));
      case registerRoute:
        return MaterialPageRoute(builder: (_) => RegisterScreen(loginRepository: LoginRepository(),));
      case newRecipeRoute:
        return MaterialPageRoute(builder: (_) => NewRecipe());
      case newIngredientRoute:
        if (settings.arguments != null) {
          return MaterialPageRoute(builder: (_) => NewIngredient(ingredient: settings.arguments,));
        }
        return MaterialPageRoute(builder: (_) => NewIngredient());
      case newStepRoute:
        if (settings.arguments != null) {
          return MaterialPageRoute(builder: (_) => NewStep(content: settings.arguments));
        }
        return MaterialPageRoute(builder: (_) => NewStep());
      case accountPanelRoute:
        return MaterialPageRoute(builder: (_) => AccountPanel());
      case recipeDetailsRoute:
        return MaterialPageRoute(builder: (_) => RecipeDetails());
      // case homeRoute:
      //   return MaterialPageRoute(builder: (_) => HomeScreen());
      // case introRoute:
      //   return MaterialPageRoute(builder: (_) => IntroScreen());
      // case cookingRoute:
      //   var data = settings.arguments as Recipe;
      //   return MaterialPageRoute(builder: (_) => CookingScreen(data));
      // case shuffleRoute:
      //   return MaterialPageRoute(builder: (_) => ShuffleScreen());
      // case cartRoute:
      //   return MaterialPageRoute(builder: (_) => CartScreen());
      // case productDetailsRoute:
      //   var data = settings.arguments as Product;
      //   return MaterialPageRoute(builder: (_) => ProductDetails(data));
      // case prepareCookingRoute:
      //   var data = settings.arguments as Recipe;
      //   return MaterialPageRoute(builder: (_) => PrepareCooking(data));
      // case newProductRoute:
      //   return MaterialPageRoute(builder: (_) => NewProduct());
      // case '/temp':
      //   return MaterialPageRoute(builder: (_) => TempScreen());
      default:
        return MaterialPageRoute(builder: (_) => Welcome());
    }
  }
}