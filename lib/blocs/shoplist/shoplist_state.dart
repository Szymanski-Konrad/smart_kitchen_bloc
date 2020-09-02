import 'package:equatable/equatable.dart';
import 'package:smart_kitchen/models/shop_item_model.dart';

abstract class ShopListState extends Equatable {
  const ShopListState();

  @override
  List<Object> get props => [];
}

class ShopListLoading extends ShopListState {}

class ShopListLoaded extends ShopListState {
  final List<ShopItem> shoplist;

  ShopListLoaded({this.shoplist});

  double get listCost => shoplist.fold(0, (value, element) => value + element.price);

  int get listLength => shoplist.length;

  @override
  List<Object> get props => [shoplist];
}

