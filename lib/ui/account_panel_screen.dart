import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smart_kitchen/blocs/blocs.dart';
import 'package:smart_kitchen/blocs/new_recipe/new_recipe.dart';
import 'package:smart_kitchen/blocs/settings/settings.dart';
import 'package:smart_kitchen/blocs/settings/settings_bloc.dart';
import 'package:smart_kitchen/blocs/settings/settings_state.dart';
import 'package:smart_kitchen/helpers/constants.dart';
import 'package:smart_kitchen/widgets/recipe_card.dart';

class AccountPanel extends StatefulWidget {
  @override
  _AccountPanelState createState() => _AccountPanelState();
}

class _AccountPanelState extends State<AccountPanel> {
  Widget getNavigationRail() {
    final bloc = BlocProvider.of<SettingsBloc>(context);
    final authBloc = BlocProvider.of<AuthBloc>(context);
    TextStyle style = TextStyle(color: Colors.white);
    //TODO: Napisy nie zmieniają koloru przy kliknięciu
    return SafeArea(
      child: BlocBuilder<SettingsBloc, SettingsState>(builder: (context, state) {
        return NavigationRail(
          backgroundColor: Colors.indigo,
          minWidth: 30,
          labelType: NavigationRailLabelType.all,
          leading: Column(
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.person_outline, color: Colors.white),
                onPressed: () => Flushbar(
                  message: "${(authBloc.state as Authenticated).displayName}, miło Ciebie widzieć :)",
                  duration: Duration(seconds: 3),
                ).show(context),
              ),
              RotatedBox(
                quarterTurns: -1,
                child: Text("Wyloguj", style: TextStyle(color: Colors.red)),
              )
            ],
          ),
          groupAlignment: 1.0,
          selectedIndex: bloc.state.currentIndex,
          onDestinationSelected: (int index) => bloc.add(NavigationChange(index: index)),
          unselectedLabelTextStyle: style,
          selectedLabelTextStyle: TextStyle(color: Color(0xffFCCFA8), fontWeight: FontWeight.bold, fontSize: 16.0),
          destinations: accountPanelOptions
              .map((e) => NavigationRailDestination(
                  icon: SizedBox.shrink(),
                  label: RotatedBox(
                    quarterTurns: -1,
                    child: Text(e),
                  )))
              .toList(),
        );
      }),
    );
  }

  Widget userRecipes() {
    final bloc = BlocProvider.of<RecipesBloc>(context);
    return BlocBuilder<RecipesBloc, RecipesState>(
      builder: (context, state) {
        if (state.userRecipes.length == 0)
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Brak przepisów",
                style: TextStyle(color: Colors.white),
              ),
            ),
          );
        else {
          return Column(
            children: <Widget>[
              Text("Ilość przepisów: ${state.userRecipes.length}", style: TextStyle(color: Colors.white)),
              Expanded(
                child: ListView.builder(
                  itemCount: state.userRecipes.length,
                  itemBuilder: (context, index) {
                    return Row(children: <Widget>[
                      Expanded(child: RecipeCard(recipe: state.userRecipes[index])),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          IconButton(
                            color: Colors.blue,
                            icon: Icon(Icons.mode_edit),
                            onPressed: () {
                              BlocProvider.of<NewRecipeBloc>(context).add(RecipeEdit(recipe: state.userRecipes[index]));
                              Navigator.pushNamed(context, '/newRecipe');
                            },
                          ),
                          IconButton(
                            color: Colors.red,
                            icon: Icon(Icons.delete_outline),
                            onPressed: () {
                              bloc.add(RemoveRecipe(recipe: state.userRecipes[index]));
                            },
                          ),
                        ],
                      )
                    ]);
                  },
                ),
              )
            ],
          );
        }
      },
    );
  }

  Widget showBody() {
    return BlocBuilder<SettingsBloc, SettingsState>(
      builder: (context, state) {
        if (state.currentIndex == 0) {
          return userRecipes();
        }
        if (state.currentIndex == 1) {
          return Column(
            children: <Widget>[
              Text("Powiadomienia"),
              SizedBox(
                height: 20,
              ),
              Text("Pojawią się wszystkie nowe powiadomienia z aplikacji. Np."),
              Text("Ktoś skomentował Twój przepis"),
              Text("Ktoś ocenił Twój przepis"),
              Text("Twórca odpisał na zgłoszenie"),
            ],
          );
        }
        if (state.currentIndex == 2) {
          return Column(
            children: <Widget>[
              Text("Opinie"),
              SizedBox(
                height: 20,
              ),
              Text("Przesyłanie opinii do twórcy"),
              Text("Może to być informacja o błędzie, usprawnieniu, nowym pomyśle czy też zwróceniu na coś uwagę"),
              Text("Użytkownik otrzyma informację powrotną od twórcy aplikacji"),
              SizedBox(
                height: 20,
              ),
              Text("Twórcy ikon: "),
              Text("Icon created by Linector from www.flaticon.com"),
              Text("Icon created by ultimatearm from www.flaticon.com"),
            ],
          );
        }
        if (state.currentIndex == 3) {
          return Column(
            children: <Widget>[
              Text("Ustawienia"),
              SizedBox(
                height: 20,
              ),
              Text("Zmiana motywu aplikacji"),
              Text("Zmiana języka"),
              Text("Zmiana systemu miar"),
              Text("Informacje prawne o aplikacji"),
              Text("Ogólne informacje o aplikacji"),
            ],
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: <Widget>[
          getNavigationRail(),
          Expanded(
            child: SafeArea(
              child: showBody(),
            ),
          )
        ],
      ),
    );
  }
}
