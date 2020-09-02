import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:smart_kitchen/models/planner_model.dart';

abstract class PlannerEvent extends Equatable {
  const PlannerEvent();

  @override
  List<Object> get props => [];
}

class PlannerLoad extends PlannerEvent {}

class PlannerDayGenerate extends PlannerEvent {}

class PlannerDayRefresh extends PlannerEvent{}

class PlannerDayAdded extends PlannerEvent {
  final PlannerDay day;

  PlannerDayAdded({this.day});

  @override
  List<Object> get props => [day];
}

class PlannerDayUpdated extends PlannerEvent {
  final PlannerDay day;

  PlannerDayUpdated({this.day});

  @override
  List<Object> get props => [day];
}

class PlannerDayExpires extends PlannerEvent {
  final DateTime date;

  PlannerDayExpires({this.date});

  @override
  List<Object> get props => [date];
}

class DaySelect extends PlannerEvent {
  final DateTime date;

  DaySelect({this.date});

  @override
  List<Object> get props => [date];
}