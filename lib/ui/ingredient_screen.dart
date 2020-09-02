import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_kitchen/blocs/new_recipe/new_recipe.dart';
import 'package:smart_kitchen/helpers/constants.dart';
import 'package:smart_kitchen/models/ingredient_model.dart';
import '../blocs/new_recipe/new_recipe.dart';

class NewIngredient extends StatefulWidget {
  final Ingredient ingredient;

  NewIngredient({this.ingredient});

  @override
  _NewIngredientState createState() => _NewIngredientState();
}

class _NewIngredientState extends State<NewIngredient> {
  final name = TextEditingController();
  final amount = TextEditingController();
  final formKey = GlobalKey<FormState>();
  String unit;

  @override
  void initState() {
    super.initState();
    if (widget.ingredient != null) {
      name.text = widget.ingredient.name;
      amount.text = widget.ingredient.amount.toString();
      unit = widget.ingredient.unit;
    }
    else {
      unit = units[0];
    }
  }

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<NewRecipeBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Składnik"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: formKey,
          child: ListView(
            children: <Widget>[
              Text("Nazwa składnika", style: titleStyle,),
              TextFormField(
                controller: name,
                style: whiteTextStyle,
                validator: (value) => value.isEmpty ? "Nazwa nie może być pusta!" : null,
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("Ilość składnika", style: titleStyle,),
                        TextFormField(
                          controller: amount,
                          style: whiteTextStyle,
                          keyboardType: TextInputType.numberWithOptions(decimal: true),
                          validator: (value) => value.isEmpty ? "Ilość nie może być pusta!" : null,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 50),
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("Jednostka", style: titleStyle,),
                        DropdownButton(
                          items: units
                              .map((e) => DropdownMenuItem(
                                    child: Text(e, style: whiteTextStyle,),
                                    value: e,
                                  ))
                              .toList(),
                          value: unit,
                          onChanged: (value) => setState(() => unit = value),
                        )
                      ],
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: MaterialButton(
                  color: Colors.indigoAccent,
                  child: Text("Zapisz"),
                  onPressed: () {
                    if (formKey.currentState.validate()) {
                      if (widget.ingredient == null) {
                        bloc.add(AddIngredient(
                            unit: unit == '-' ? ' ' : unit, amount: double.parse(amount.text), name: name.text));
                      } else {
                        bloc.add(EditIngredient(
                            unit: unit == '-' ? '' : unit,
                            amount: double.parse(amount.text),
                            name: name.text,
                            index: bloc.editIndex));
                      }
                      bloc.editIndex = -1;
                      Navigator.of(context).pop();
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
