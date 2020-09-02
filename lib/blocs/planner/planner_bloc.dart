import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:smart_kitchen/blocs/blocs.dart';
import 'package:smart_kitchen/database/kitchen_dao.dart';
import 'package:smart_kitchen/models/models.dart';
import 'package:smart_kitchen/models/planner_model.dart';
import 'planner.dart';
import 'package:meta/meta.dart';
import '../../helpers/extensions.dart';

class PlannerBloc extends Bloc<PlannerEvent, PlannerState> {
  KitchenDao repository;
  RecipesBloc recipesBloc;

  PlannerBloc({@required this.recipesBloc}) {
    repository = KitchenDao();
  }

  List<Recipe> get dayRecipes =>
      state.selectedDay != null ? recipesBloc.state.recipesFromID(state.selectedDay.dishes) : null;

  List<DateTime> get markedDates => state.days.map((e) => e.date).toList();

  @override
  PlannerState get initialState => PlannerState.empty();

  @override
  Stream<PlannerState> mapEventToState(PlannerEvent event) async* {
    if (event is PlannerLoad) {
      yield* _mapPlannerLoadToState();
    } else if (event is PlannerDayUpdated) {
      yield* _mapPlannerDayUpdatedToState(event.day);
    } else if (event is PlannerDayExpires) {
      yield* _mapPlannerDayExpiresToState();
    } else if (event is PlannerDayAdded) {
      yield* _mapPlannerDayAddedToState(event.day);
    } else if (event is DaySelect) {
      yield* _mapDaySelectToState(event.date);
    } else if (event is PlannerDayGenerate) {
      yield* _mapPlannerDayGenerateToState();
    }
  }

  /// Generate planner day on user demand
  Stream<PlannerState> _mapPlannerDayGenerateToState() async* {
    Random rand = Random();
    final recipes = [
      recipesBloc.state.breakfast[rand.nextInt(recipesBloc.state.breakfast.length)].id,
      recipesBloc.state.dinner[rand.nextInt(recipesBloc.state.dinner.length)].id,
      recipesBloc.state.supper[rand.nextInt(recipesBloc.state.supper.length)].id
    ];
    PlannerDay day = PlannerDay(date: state.selectedDate, dishes: recipes);
    await repository.insertPlannerDay(day.toMap());
    final days = List<PlannerDay>.from(state.days);
    days.add(day);
    yield state.update(days: days);
  }

  /// Generate new dishes for 

  /// Change selected date
  Stream<PlannerState> _mapDaySelectToState(DateTime date) async* {
    yield state.update(selectedDate: date);
  }

  /// Load planner days at start
  Stream<PlannerState> _mapPlannerLoadToState() async* {
    try {
      final planner = await repository.fetchAllPlannerDays();
      yield state.update(days: planner);
    } catch (e) {
      print("Error with loading planner");
      print(e);
    }
  }

  /// Update planner day
  Stream<PlannerState> _mapPlannerDayUpdatedToState(PlannerDay day) async* {
    final days = state.days;
    final index = days.indexWhere((element) => element.date == day.date);
    days[index] = day;
    await repository.updatePlannerDay(day);
    yield state.update(days: days);
  }

  /// Remove planner days that are before current day
  Stream<PlannerState> _mapPlannerDayExpiresToState() async* {
    final days = state.days;
    final daysToRemove = state.days.where((day) => day.date.isBefore(DateOnlyCompare.today()));
    daysToRemove.forEach((element) {
      repository.removePlannerDay(element.date);
      days.removeWhere((day) => element.date == day.date);
    });
    yield state.update(days: days);
  }

  /// Insert planner day
  Stream<PlannerState> _mapPlannerDayAddedToState(PlannerDay day) async* {
    repository.insertPlannerDay(day.toMap());
    yield state.update(days: state.days..add(day));
  }
}
