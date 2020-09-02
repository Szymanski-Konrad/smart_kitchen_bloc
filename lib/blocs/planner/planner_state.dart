import 'package:smart_kitchen/models/models.dart';
import 'package:smart_kitchen/models/planner_model.dart';
import '../../helpers/extensions.dart';

class PlannerState {
  final DateTime selectedDate;
  final List<PlannerDay> days;

  PlannerState({this.selectedDate, this.days});

  factory PlannerState.empty() {
    return PlannerState(days: [], selectedDate: DateOnlyCompare.today());
  }

  PlannerDay get selectedDay {
    return days.firstWhere((element) => element.date.isSameDate(selectedDate), orElse: () => null);
  }

  PlannerState update({
    DateTime selectedDate,
    List<PlannerDay> days,
  }) {
    return copyWith(selectedDate: selectedDate, days: days);
  }

  PlannerState copyWith({
    DateTime selectedDate,
    List<PlannerDay> days,
  }) {
    return PlannerState(
      selectedDate: selectedDate ?? this.selectedDate,
      days: days ?? this.days,
    );
  }
}
