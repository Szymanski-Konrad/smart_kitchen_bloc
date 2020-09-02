import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:smart_kitchen/models/shop_item_model.dart';

abstract class ShopListEvent extends Equatable {
  const ShopListEvent();

  @override
  List<Object> get props => [];
}

class ShopListLoad extends ShopListEvent {}

class AddShopItem extends ShopListEvent {
  final ShopItem item;

  AddShopItem({@required this.item});

  @override
  List<Object> get props => [item];
}

class RemoveShopItem extends ShopListEvent {
  final ShopItem item;
  final int index;

  RemoveShopItem({@required this.item, @required this.index});

  @override
  List<Object> get props => [item];
}

class UpdateShopItem extends ShopListEvent {
  final ShopItem item;
  final int index;

  UpdateShopItem({@required this.item, @required this.index});

  @override
  List<Object> get props => [item];
}