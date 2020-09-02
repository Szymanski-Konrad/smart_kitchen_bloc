import 'dart:io';

import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smart_kitchen/blocs/new_recipe/new_recipe.dart';
import 'package:smart_kitchen/blocs/recipes/recipes.dart';
import 'package:smart_kitchen/helpers/constants.dart';
import 'package:smart_kitchen/presentation/custom_icons_icons.dart';
import 'package:smart_kitchen/presentation/smart_kitchen_icons.dart';
import 'package:smart_kitchen/widgets/title_widget.dart';

class NewRecipe extends StatefulWidget {
  @override
  _NewRecipeState createState() => _NewRecipeState();
}

class _NewRecipeState extends State<NewRecipe> {
  final picker = ImagePicker();

  Future<bool> _onWillPop() {
    final bloc = BlocProvider.of<NewRecipeBloc>(context);
    return showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text("Na pewno?"),
                content: Text("Opuszczenie tego okna spowoduje utratę wprowadzonych danych."),
                actions: <Widget>[
                  FlatButton(
                    child: Text("Opuść"),
                    onPressed: () {
                      if (bloc.state.imagePath != '' && bloc.state.imagePath != null && bloc.state.id == -1) {
                        var file = File(bloc.state.imagePath);
                        file.delete();
                      }
                      BlocProvider.of<NewRecipeBloc>(context).add(RecipeCancelled());
                      Navigator.of(context).pop(true);
                    },
                  ),
                  FlatButton(
                    child: Text("Zostań"),
                    onPressed: () => Navigator.of(context).pop(false),
                  )
                ],
              );
            }) ??
        false;
  }

  _selectImage(ImageSource source, NewRecipeBloc bloc) async {
    var image = await picker.getImage(source: source, imageQuality: 90, maxHeight: 600, maxWidth: 600);
    if (image != null) {
      bloc.add(AddImagePath(imagePath: image.path));
    } else {
      Flushbar(
        message: "Nie wybrano żadnego zdjęcia",
        duration: Duration(seconds: 2),
      ).show(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<NewRecipeBloc>(context);
    final titleController = TextEditingController(text: bloc.state.name);
    final notesController = TextEditingController(text: bloc.state.notes);
    final formKey = GlobalKey<FormState>();
    return SafeArea(
      child: WillPopScope(
        onWillPop: () => _onWillPop(),
        child: Scaffold(
          appBar: AppBar(
            title: Text("Utwórz przepis"),
            centerTitle: true,
            actions: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.check,
                  color: Colors.white,
                ),
                onPressed: () {
                  if (formKey.currentState.validate()) {
                    bloc.add(EditName(name: titleController.text));
                    bloc.add(EditNotes(notes: notesController.text));
                    bloc.add(RecipeSave());
                    Navigator.of(context).pop("refresh");
                    BlocProvider.of<RecipesBloc>(context).add(ReloadRecipes());
                  }
                },
              ),
            ],
          ),
          body: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: BlocBuilder<NewRecipeBloc, NewRecipeState>(builder: (context, state) {
                return ListView(
                  children: <Widget>[
                    CustomTitle(title: "ZDJĘCIE"),
                    state.imagePath == '' || state.imagePath == null
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              IconButton(
                                icon: Icon(Icons.add_a_photo),
                                color: Colors.white,
                                onPressed: () async => await _selectImage(ImageSource.camera, bloc),
                              ),
                              IconButton(
                                icon: Icon(Icons.image),
                                color: Colors.white,
                                onPressed: () async => await _selectImage(ImageSource.gallery, bloc),
                              ),
                            ],
                          )
                        : Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.file(
                              File(state.imagePath),
                              height: 350,
                            ),
                          ),
                    CustomTitle(title: "NAZWA PRZEPISU"),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: TextFormField(
                          controller: titleController,
                          decoration: InputDecoration(hintText: "Wpisz nazwę przepisu"),
                          validator: (value) => value.isEmpty ? "Nazwa nie może być pusta" : null,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    CustomTitle(title: "KATEGORIA"),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: DropdownButton(
                          items: categories.map((e) => DropdownMenuItem(child: Text(e), value: e)).toList(),
                          onChanged: (value) {
                            bloc.add(EditCategory(category: value));
                          },
                          value: state.category != "" ? state.category : null,
                          icon: Icon(null),
                          hint: Text("Wybierz kategorię"),
                          isExpanded: false,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    CustomTitle(title: "SKŁADNIKI"),
                    Card(
                      color: state.ingredients.length > 0 ? Colors.white : Colors.grey,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: state.ingredients.length > 0
                            ? ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: state.ingredients.length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    title: Text(state.ingredients[index].show()),
                                    trailing: IconButton(
                                        icon: Icon(Icons.delete_outline),
                                        onPressed: () => bloc.add(RemoveIngredient(index: index))),
                                    onTap: () {
                                      bloc.editIndex = index;
                                      Navigator.pushNamed(context, '/newIngredient',
                                          arguments: state.ingredients[index]);
                                    },
                                  );
                                })
                            : Center(child: Text("Czekam na pierwszy składnik")),
                      ),
                    ),
                    SizedBox(height: 20),
                    CustomTitle(title: "KROKI PRZYGOTOWANIA"),
                    Card(
                      color: state.steps.length > 0 ? Colors.white : Colors.grey,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: state.steps.length > 0
                            ? ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: state.steps.length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    title: Text(state.steps[index].content),
                                    trailing: IconButton(
                                      icon: Icon(Icons.delete_outline),
                                      onPressed: () => bloc.add(RemoveStep(index: index)),
                                    ),
                                    onTap: () {
                                      bloc.editIndex = index;
                                      Navigator.pushNamed(context, '/newStep', arguments: state.steps[index].content);
                                    },
                                  );
                                })
                            : Center(child: Text("Czekam na pierwszy krok przygotowania")),
                      ),
                    ),
                    SizedBox(height: 20),
                    CustomTitle(title: "NOTATKI"),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: TextField(
                          autofocus: false,
                          controller: notesController,
                          decoration: InputDecoration(
                            hintText: "Tutaj wpisz dowolne notatki do przepisu...",
                          ),
                          maxLines: 2,
                        ),
                      ),
                    )
                  ],
                );
              }),
            ),
          ),
          floatingActionButton: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              FloatingActionButton(
                heroTag: 'ing',
                tooltip: "Dodaj nowy składnik",
                child: Row(
                  children: <Widget>[Icon(Icons.add), Icon(SmartKitchen.grocery)],
                ),
                onPressed: () {
                  return Navigator.pushNamed(context, '/newIngredient');
                },
              ),
              SizedBox(
                height: 5,
              ),
              FloatingActionButton(
                heroTag: 'step',
                tooltip: "Dodaj nowy krok przygotowania",
                child: Row(
                  children: <Widget>[Icon(Icons.add), Icon(SmartKitchen.bake)],
                ),
                onPressed: () {
                  bloc.editIndex = -1;
                  bloc.add(AddStep(step: ''));
                  return Navigator.pushNamed(context, '/newStep', arguments: '');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}