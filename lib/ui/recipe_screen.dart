import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:smart_kitchen/blocs/recipe_details/recipe_details.dart';
import 'package:smart_kitchen/helpers/constants.dart';
import 'package:smart_kitchen/presentation/custom_icons_icons.dart';
import 'package:smart_kitchen/widgets/ingredient_card.dart';
import 'package:smart_kitchen/widgets/step_card.dart';
import 'package:smart_kitchen/widgets/title_widget.dart';

class RecipeDetails extends StatefulWidget {
  @override
  _RecipeDetailsState createState() => _RecipeDetailsState();
}

class _RecipeDetailsState extends State<RecipeDetails> {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<RecipeDetailsBloc>(context);
    return BlocBuilder<RecipeDetailsBloc, RecipeDetailsState>(
      builder: (context, state) {
        return Scaffold(
            body: ListView(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.3,
              child: Stack(
                children: <Widget>[
                  Hero(
                    tag: bloc.state.recipe.id,
                    child: Container(
                        decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.only(bottomLeft: Radius.circular(20.0), bottomRight: Radius.circular(20.0)),
                      color: Colors.white,
                      image: DecorationImage(
                          image: bloc.state.hasImage
                              ? FileImage(File(bloc.state.recipe.imagePath))
                              : AssetImage('assets/noimage.jpg'),
                          fit: BoxFit.fill),
                    )),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.08,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.only(bottomLeft: Radius.circular(20.0), bottomRight: Radius.circular(20.0)),
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors:  [Colors.black87, Colors.black12],
                          )),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          bloc.state.recipe.name,
                          style: whiteTextStyle,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            IconsRow(bloc: bloc),
            SizedBox(height: 20),
            SuperText(title: "Składniki"),
            // CustomTitle(title: "Składniki"),
            MaterialButton(
              color: Colors.deepOrange,
              child: Text("Dodaj wszystkie produkty do listy zakupów"),
              onPressed: () {},
            ),
            IngredientList(bloc: bloc),
            SizedBox(height: 20),
            CustomTitle(title: "Etapy przygotowania"),
            StepList(bloc: bloc),
            SizedBox(height: 20),
            CustomTitle(title: "Dodatkowe opcje"),
            AdditionalInfo(bloc: bloc),
            ProductInfoList(bloc: bloc),
            SizedBox(height: 20),
            bloc.state.recipe.notes.length > 0 ? NotesInfo(notes: bloc.state.recipe.notes) : Container(),
            SizedBox(height: 20),
            CustomTitle(title: "Komentarze"),
          ],
        ));
      },
    );
  }
}

class SuperText extends StatelessWidget {
  final String title;

  const SuperText({@required this.title});

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      child: Container(
        color: Colors.teal,
        child: Text(title, style: whiteTextStyle),
      ),
      clipper: MyCustomClipper(),
    );
  }
}

class MyCustomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(size.width / 2, 0.0);
    path.lineTo(size.width / 2 - 50, 20.0);
    path.lineTo(0.0, 20.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(MyCustomClipper oldClipper) => true;
}

class NotesInfo extends StatelessWidget {
  final String notes;

  const NotesInfo({this.notes});

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        CustomTitle(title: "Notatki"),
        Text(notes, style: whiteTextStyle),
      ],
    );
  }
}

class ProductInfoList extends StatelessWidget {
  final RecipeDetailsBloc bloc;

  const ProductInfoList({@required this.bloc});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: ListView(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        children: <Widget>[
          ProductInfo(message: "${bloc.state.kcal}/2500 kcal", header: "kcal", percent: bloc.state.kcal / 2500),
          ProductInfo(message: "${bloc.state.fat}/80g", header: "tłuszcz", percent: bloc.state.fat / 80),
          ProductInfo(message: "${bloc.state.carbo}/340g", header: "Węglowodany", percent: bloc.state.carbo / 340),
          ProductInfo(message: "${bloc.state.protein}/60g", header: "Białko", percent: bloc.state.protein / 60),
          ProductInfo(message: "${bloc.state.cellulose}/25g", header: "Błonnik", percent: bloc.state.cellulose / 25),
          ProductInfo(message: "${bloc.state.salt}/6g", header: "Sól", percent: bloc.state.salt / 6),
        ],
      ),
    );
  }
}

class ProductInfo extends StatelessWidget {
  final String message;
  final String header;
  final double percent;

  ProductInfo({this.message, this.header, this.percent});

  @override
  Widget build(BuildContext build) {
    return Tooltip(
      message: message,
      waitDuration: Duration(milliseconds: 300),
      child: SizedBox(
        width: 90,
        height: 100,
        child: CircularPercentIndicator(
          radius: 70.0,
          animation: true,
          animationDuration: 1200,
          center: Text(
            (percent * 100).toStringAsFixed(1),
            style: whiteTextStyle,
          ),
          footer: Text(
            header,
            style: whiteTextStyle,
          ),
          percent: percent,
          progressColor: percent > .7 ? Colors.red : Colors.green,
          backgroundColor: Colors.indigoAccent,
          lineWidth: 8.0,
        ),
      ),
    );
  }
}

class IconsRow extends StatelessWidget {
  final RecipeDetailsBloc bloc;

  IconsRow({@required this.bloc});

  @override
  Widget build(BuildContext context) {
    final serveController = TextEditingController(text: bloc.state.scale.toStringAsFixed(1));
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Icon(Icons.room_service, color: Colors.white),
        Container(
          width: 50,
          height: 25,
          child: TextField(
            controller: serveController,
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            onChanged: (value) {},
            onEditingComplete: () => bloc.add(RescaleRecipe(scale: double.parse(serveController.text))),
          ),
        ),
        SizedBox(
          width: 5,
        ),
        // Container(height: 50, child: VerticalDivider(thickness: 1.0, color: Colors.black, width: 50.0, )),
        Icon(CustomIcons.cook, color: Colors.white),
        Text("Gotowanie"),
      ],
    );
  }
}

class IngredientList extends StatelessWidget {
  final RecipeDetailsBloc bloc;

  IngredientList({@required this.bloc});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: bloc.state.ingredients.length,
      itemBuilder: (context, index) {
        return IngredientCard(
          amount: bloc.state.ingredients[index].amount * bloc.state.scale,
          name: bloc.state.ingredients[index].name,
        );
      },
    );
  }
}

class StepList extends StatelessWidget {
  final RecipeDetailsBloc bloc;

  StepList({@required this.bloc});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: bloc.state.steps.length,
        itemBuilder: (context, index) {
          return StepCard(index + 1, bloc.state.steps[index].content);
        });
  }
}

class AdditionalInfo extends StatelessWidget {
  final RecipeDetailsBloc bloc;

  AdditionalInfo({@required this.bloc});

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        bloc.state.plannerCategory
            ? MaterialButton(
                color: Colors.indigoAccent,
                textColor: Colors.white,
                child: Text("Ustaw jako ${bloc.state.recipe.category} w planerze"),
                onPressed: () {},
              )
            : Container(),
        Text(
          "% spożycia dla dorosłej osoby",
          style: whiteTextStyle,
        ),
      ],
    );
  }
}
