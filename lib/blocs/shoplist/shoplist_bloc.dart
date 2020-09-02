import 'package:bloc/bloc.dart';
import 'package:smart_kitchen/blocs/shoplist/shoplist.dart';
import 'package:smart_kitchen/database/kitchen_dao.dart';
import 'package:smart_kitchen/models/shop_item_model.dart';

class ShopListBloc extends Bloc<ShopListEvent, ShopListState> {
  KitchenDao repository;

  ShopListBloc() {
    repository = KitchenDao();
  }

  @override
  ShopListState get initialState => ShopListLoading();

  @override
  Stream<ShopListState> mapEventToState(ShopListEvent event) async* {
    if (event is ShopListLoad) {
      yield* _mapShopListLoadToState();
    } else if (event is AddShopItem) {
      yield* _mapAddShopItemToState(event);
    } else if (event is RemoveShopItem) {
      yield* _mapRemoveShopItemToState(event);
    } else if (event is UpdateShopItem) {
      yield* _mapUpdateShopItemToState(event);
    }
  }

  Stream<ShopListState> _mapShopListLoadToState() async* {
    yield ShopListLoading();
    try {
      final shoplist = await repository.fetchShopList();
      yield ShopListLoaded(shoplist: shoplist);
    } catch (e) {
      print("Error with loading shoplist");
      print(e);
    }
  }

  Stream<ShopListState> _mapAddShopItemToState(AddShopItem event) async* {
    if (state is ShopListLoaded) {
      if (event.item.name.isNotEmpty) {
        final List<ShopItem> updatedShopList = List.from((state as ShopListLoaded).shoplist)..add(event.item);
        yield ShopListLoaded(shoplist: updatedShopList);
        repository.insertOnShopList(event.item.toMap());
      }
    }
  }

  Stream<ShopListState> _mapRemoveShopItemToState(RemoveShopItem event) async* {
    if (state is ShopListLoaded) {
      final List<ShopItem> updatedShopList = List.from((state as ShopListLoaded).shoplist)..removeAt(event.index);
      yield ShopListLoaded(shoplist: updatedShopList);
      repository.removeFromShopList(event.item);
    }
  }

  Stream<ShopListState> _mapUpdateShopItemToState(UpdateShopItem event) async* {
    if (state is ShopListLoaded) {
      final List<ShopItem> updatedShopList = List.from((state as ShopListLoaded).shoplist)..replaceRange(event.index, event.index + 1, [event.item]);
      yield ShopListLoaded(shoplist: updatedShopList);
      repository.updateShopItem(event.item);
    }
  }
}