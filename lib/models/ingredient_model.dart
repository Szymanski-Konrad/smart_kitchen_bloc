import 'package:equatable/equatable.dart';

class Ingredient extends Equatable {
  final int id;
  final String name;
  final String unit;
  final double amount;
  final double scale;

  Ingredient({
    this.id,
    this.name,
    this.unit,
    this.amount,
    this.scale,
  });


  Ingredient copyWith({
    int id,
    String name,
    String unit,
    double amount,
    double scale,
  }) {
    return Ingredient(
      id: id ?? this.id,
      name: name ?? this.name,
      unit: unit ?? this.unit,
      amount: amount ?? this.amount,
      scale: scale ?? this.scale,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'unit': unit,
      'amount': amount,
    };
  }

  static Ingredient fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return Ingredient(
      id: map['id'],
      name: map['name'],
      unit: map['unit'],
      amount: map['amount'],
      scale: 1.0,
    );
  }

  String get _amountToString {
    return amount == amount.toInt() ? amount.toInt().toString() : amount.toStringAsFixed(2);
  }

  String show() {
    return '$_amountToString $unit   $name';
  }

  @override
  List<Object> get props => [id, name, unit, amount, scale];

  @override
  String toString() {
    return 'Ingredient(id: $id, name: $name, unit: $unit, amount: $amount, scale: $scale)';
  }
}
