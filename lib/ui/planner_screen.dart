import 'package:calendar_strip/calendar_strip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_kitchen/blocs/planner/planner.dart';
import 'package:smart_kitchen/blocs/recipe_details/recipe_details.dart';
import 'package:smart_kitchen/helpers/constants.dart';
import '../helpers/converters.dart';
import 'package:smart_kitchen/models/models.dart';
import 'package:smart_kitchen/widgets/recipe_card.dart';
import '../helpers/extensions.dart';

class PlannerScreen extends StatefulWidget {
  @override
  _PlannerScreenState createState() => _PlannerScreenState();
}

class _PlannerScreenState extends State<PlannerScreen> {
  _dateTileBuilder(DateTime date, selectedDate, rowIndex, dayName, isDateMarked, isDateOutOfRange) {
    bool isSelectedDate = date.onlyDate.compareTo(BlocProvider.of<PlannerBloc>(context).state.selectedDate) == 0;
    Color fontColor = isDateOutOfRange ? Colors.black26 : Colors.white;
    TextStyle normalStyle = TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: fontColor);
    TextStyle selectedStyle = TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: Colors.deepOrange);
    TextStyle dayNameStyle = TextStyle(fontSize: 12, color: fontColor);
    List<Widget> _children = [
      Text(dayConvertMap[dayName], style: dayNameStyle),
      Text(date.day.toString(), style: !isSelectedDate ? normalStyle : selectedStyle),
    ];
    if (isDateMarked) _children.add(_getMarkedIndicatorWidget());

    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      alignment: Alignment.topCenter,
      padding: EdgeInsets.only(bottom: 5),
      decoration: BoxDecoration(
        color: !isSelectedDate ? Colors.transparent : Colors.black45,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        children: _children,
      ),
    );
  }

  _getMarkedIndicatorWidget() {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Container(
        width: 5,
        height: 5,
        decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.blue),
      )
    ]);
  }

  _monthNameWidget(monthName) {
    return Container(
      child: Text(
        replaceMonth(monthName),
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white, fontStyle: FontStyle.italic),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<PlannerBloc>(context);
    return Scaffold(body: SafeArea(
      child: BlocBuilder<PlannerBloc, PlannerState>(builder: (context, state) {
        return Column(
          children: <Widget>[
            CalendarStrip(
              iconColor: Colors.white,
                addSwipeGesture: true,
                monthNameWidget: _monthNameWidget,
                dateTileBuilder: _dateTileBuilder,
                markedDates: bloc.markedDates,
                onDateSelected: (DateTime value) {
                  bloc.add(DaySelect(date: value.onlyDate));
                }),
            Expanded(child: DayMeals(bloc: bloc)),
          ],
        );
      }),
    ));
  }
}

class DayMeals extends StatelessWidget {
  final PlannerBloc bloc;

  DayMeals({this.bloc});

  @override
  Widget build(BuildContext context) {
    return bloc.dayRecipes != null
        ? Container(
            child: ListView(
              children: <Widget>[
                MealWidget(
                  name: "Śniadanie",
                  recipe: bloc.dayRecipes[0],
                ),
                MealWidget(
                  name: "Obiad",
                  recipe: bloc.dayRecipes[1],
                ),
                MealWidget(
                  name: "Kolacja",
                  recipe: bloc.dayRecipes[2],
                ),
              ],
            ),
          )
        : Container(
            child: bloc.recipesBloc.state.plannerAvaliable
                ? ListView(
                    children: <Widget>[
                      MaterialButton(
                          child: Text("Utwórz plan na dzisiaj"),
                          color: Colors.deepOrange,
                          textColor: Colors.white,
                          onPressed: () => bloc.add(PlannerDayGenerate())),
                    ],
                  )
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                        child: Text(
                      "Aby móc wygenerować plan żywieniowy potrzebujesz conajmniej 3 przepisów z kategorii: Śniadanie, Obiad, Kolacja",
                      style: whiteTextStyle,
                    )),
                  ),
          );
  }
}

class MealWidget extends StatelessWidget {
  final String name;
  final Recipe recipe;

  MealWidget({this.name, this.recipe});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.25,
      child: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: RotatedBox(
              child: Text(
                name,
                style: TextStyle(color: Colors.deepOrange, letterSpacing: 1.2, fontSize: 22.0),
              ),
              quarterTurns: -1,
            ),
          ),
          Expanded(
            child: GestureDetector(
              child: RecipeCard(recipe: recipe),
              onTap: () async {
                BlocProvider.of<RecipeDetailsBloc>(context).add(RecipeDetailsLoad(recipe: recipe));
                Navigator.pushNamed(context, '/recipeDetails');
              },
            ),
          )
        ],
      ),
    );
  }
}
