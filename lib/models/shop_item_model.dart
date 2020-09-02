import 'package:equatable/equatable.dart';

class ShopItem extends Equatable{
  final int id;
  final String name;
  final String barcode;
  final double price;
  final bool editable;
 
  ShopItem({
    this.id,
    this.name,
    this.barcode,
    this.price,
    this.editable,
  });


  ShopItem copyWith({
    int id,
    String name,
    String barcode,
    double price,
    bool editable,
  }) {
    return ShopItem(
      id: id ?? this.id,
      name: name ?? this.name,
      barcode: barcode ?? this.barcode,
      price: price ?? this.price,
      editable: editable ?? this.editable,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'barcode': barcode,
      'price': price,
      'editable': editable == true ? 1 : 0,
    };
  }

  static ShopItem fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return ShopItem(
      id: map['id'],
      name: map['name'],
      barcode: map['barcode'],
      price: map['price'],
      editable: map['editable'] == 1 ? true : false,
    );
  }
  
  @override
  List<Object> get props => [id, name, barcode, price, editable];

  @override
  String toString() {
    return 'ShopItem(id: $id, name: $name, barcode: $barcode, price: $price, editable: $editable)';
  }

  String show() {
    return '$name';
  }
}
