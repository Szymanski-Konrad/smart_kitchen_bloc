import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_kitchen/blocs/authenticate/auth.dart';
import 'package:smart_kitchen/blocs/new_recipe/new_recipe.dart';
import 'package:smart_kitchen/blocs/recipe_details/recipe_details.dart';
import 'package:smart_kitchen/helpers/list_constants.dart';
import 'package:smart_kitchen/models/models.dart';
import 'package:smart_kitchen/widgets/category_chips.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import '../blocs/recipes/recipes.dart';
import '../widgets/recipe_card.dart';

class RecipesHome extends StatefulWidget {
  @override
  _RecipesHomeState createState() => _RecipesHomeState();
}

class _RecipesHomeState extends State<RecipesHome> {
  final TextEditingController searchController = TextEditingController();

  changeCateory(String newCategory) {
    BlocProvider.of<RecipesBloc>(context).add(CategoryChanged(category: newCategory));
  }

  @override
  Widget build(BuildContext context) {
    final recipesBloc = BlocProvider.of<RecipesBloc>(context);
    return SafeArea(
      child: BlocBuilder<RecipesBloc, RecipesState>(builder: (context, state) {
        return Column(
          children: <Widget>[
            PreferredSize(
              preferredSize: Size(MediaQuery.of(context).size.width, 40),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Card(
                      child: TextField(
                        controller: searchController,
                        style: TextStyle(color: Colors.blue),
                        decoration: InputDecoration(
                            fillColor: Colors.white,
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
                            hintText: "Wyszukaj przepis",
                            suffixIcon: recipesBloc.state.searchString.length > 0
                                ? IconButton(
                                    icon: Icon(Icons.clear),
                                    onPressed: () {
                                      recipesBloc.add(SearchStringChanged(searchString: ''));
                                      searchController.clear();
                                    },
                                  )
                                : null),
                        onChanged: (text) {
                          recipesBloc.add(SearchStringChanged(searchString: text));
                        },
                      ),
                    ),
                  ),
                  recipesBloc.state.searchString.isEmpty
                      ? PopupMenuButton<String>(
                          onSelected: (selected) {
                            if (selected == 'new') {
                              Navigator.pushNamed(context, '/newRecipe');
                            }
                          },
                          child: Icon(
                            Icons.more_vert,
                            color: Colors.white,
                          ),
                          itemBuilder: (context) => popUpItems,
                        )
                      : Container(),
                ],
              ),
            ),
            recipesBloc.state.searchString == ''
                ? ChipList(
                    selectedCategory: recipesBloc.state.selectedCategory,
                    onTap: changeCateory,
                  )
                : Container(),
            showRecipes(state.recipesList, recipesBloc)
          ],
        );
      }),
    );
  }

  /// Show recipes by category or search string
  showRecipes(List<Recipe> recipes, RecipesBloc bloc) {
    if (recipes.length > 0) {
      return Expanded(
        child: ListView.builder(
            itemCount: recipes.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                child: RecipeCard(recipe: recipes[index]),
                onTap: () {
                  BlocProvider.of<RecipeDetailsBloc>(context).add(RecipeDetailsLoad(recipe: recipes[index]));
                  Navigator.pushNamed(context, '/recipeDetails');
                },
                onLongPress: () {
                  final authBloc = BlocProvider.of<AuthBloc>(context);
                  if ((authBloc.state as Authenticated).displayName == recipes[index].user) {
                    Flushbar(
                      backgroundColor: Colors.red,
                      message: "Nie możesz oceniać swojego przepisu",
                    ).show(context);
                  } else {
                    double starValue = 0.0;
                    showDialog(
                        context: context,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Center(
                                child: SmoothStarRating(
                                  allowHalfRating: true,
                                  onRated: (value) => starValue = value,
                                ),
                              ),
                              FlatButton(
                                  onPressed: () {
                                    bloc.add(StarRecipe(recipe: recipes[index], stars: starValue));
                                    Navigator.of(context).pop();
                                  },
                                  child: Text("Oceń")),
                            ],
                          ),
                        ));
                  }
                },
              );
            }),
      );
    } else {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Brak przepisów",
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
    }
  }
}
