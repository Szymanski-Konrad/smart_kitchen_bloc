import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_kitchen/blocs/new_recipe/new_recipe.dart';
import 'package:smart_kitchen/helpers/constants.dart';
import 'package:smart_kitchen/models/models.dart';

class NewStep extends StatefulWidget {
  final String content;
  NewStep({this.content});

  @override
  _NewStepState createState() => _NewStepState();
}

class _NewStepState extends State<NewStep> {
  final formKey = GlobalKey<FormState>();
  final content = TextEditingController();

  @override
  void initState() {
    super.initState();
    content.text = widget.content;
  }

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<NewRecipeBloc>(context);
    return WillPopScope(
      onWillPop: () async {
        if (bloc.editIndex == -1) bloc.add(RemoveStep(index: bloc.editIndex));
        return true;
      },
      child: BlocBuilder<NewRecipeBloc, NewRecipeState>(builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Etap przygotowania"),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: formKey,
              child: ListView(
                children: <Widget>[
                  Text(
                    "Opis kroku",
                    style: titleStyle,
                  ),
                  TextFormField(
                    controller: content,
                    maxLines: 4,
                    style: whiteTextStyle,
                    validator: (value) => value.isEmpty ? "Opis nie może być pusty!" : null,
                  ),
                  MaterialButton(
                    padding: const EdgeInsets.all(8.0),
                    color: Colors.indigoAccent,
                    child: Text("Zapisz"),
                    onPressed: () {
                      if (formKey.currentState.validate()) {
                        if (bloc.editIndex != -1) {
                          bloc.add(EditStep(step: content.text, index: bloc.editIndex));
                        } else {
                          bloc.add(EditStep(step: content.text, index: bloc.state.steps.length - 1));
                        }
                        bloc.editIndex = -1;
                        Navigator.of(context).pop();
                      }
                    },
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: bloc.avaliableIngredient.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: Checkbox(
                          value: false,
                          onChanged: (value) {
                            bloc.add(IngredientToStep(ingredient: bloc.avaliableIngredient[index]));
                          },
                        ),
                        title: Text(bloc.avaliableIngredient[index].name, style: whiteTextStyle,),
                      );
                    },
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: bloc.stepIngredients.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: Checkbox(
                          value: true,
                          onChanged: (value) {
                            bloc.add(IngredientFromStep(ingredient: bloc.stepIngredients[index]));
                          },
                        ),
                        title: Text(bloc.stepIngredients[index].name, style: whiteTextStyle),
                      );
                    }
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
