import 'package:equatable/equatable.dart';

class PlannerDay extends Equatable {
  final int id;
  final DateTime date;
  final List<int> dishes;

  PlannerDay({this.id, this.date, this.dishes});

  @override
  List<Object> get props => [id, date, dishes];

  Map<String, dynamic> toMap() {
    return {
      'id' : id,
      'date' : date.toString(),
      'dishes' : dishes.map((i) => i.toString()).join(','),
    };
  }

  static PlannerDay fromMap(Map<String, dynamic> map) {
    return PlannerDay(
      id: map['id'],
      date: DateTime.parse(map['date']),
      dishes: (map["dishes"] as String).split(',').map((e) => int.parse(e)).toList(),
    );
  }

  PlannerDay copyWith({
    int id,
    DateTime date,
    List<int> dishes,
  }) {
    return PlannerDay(
      id: id ?? this.id,
      date: date ?? this.date,
      dishes: dishes ?? this.dishes,
    );
  }
}
