import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_kitchen/blocs/blocs.dart';
import 'package:smart_kitchen/blocs/shoplist/shoplist.dart';
import 'package:smart_kitchen/models/shop_item_model.dart';

class ShopCart extends StatefulWidget {
  @override
  _ShopCartState createState() => _ShopCartState();
}

class _ShopCartState extends State<ShopCart> {
  @override
  Widget build(BuildContext context) {
    final shopBloc = BlocProvider.of<ShopListBloc>(context);
    final itemController = TextEditingController();
    return SafeArea(
      child: Column(
        children: <Widget>[
          Card(
              elevation: 5.0,
              margin: EdgeInsets.all(8.0),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: itemController,
                  decoration: InputDecoration(
                      hintText: "Produkt na listę zakupów",
                      suffixIcon: IconButton(
                        icon: Icon(Icons.code),
                        onPressed: () {},
                      )),
                  onEditingComplete: () {
                    shopBloc.add(AddShopItem(
                        item: ShopItem(name: itemController.text, price: 0.0, barcode: '', editable: true)));
                    itemController.clear();
                  },
                ),
              )),
          BlocBuilder<ShopListBloc, ShopListState>(
            builder: (context, state) {
              if (state is ShopListLoading) {
                return LinearProgressIndicator();
              }
              if (state is ShopListLoaded) {
                return Expanded(child: ShopListBuilder(shopBloc: shopBloc, items: state.shoplist));
              }
              return Center(child: Text("Coś poszło nie tak :("));
            },
          ),
          BlocBuilder<ShopListBloc, ShopListState>(builder: (context, state) {
            if (state is ShopListLoading) {
              return LinearProgressIndicator();
            }
            if (state is ShopListLoaded) {
              return ListTile(
                //TODO: Adding products with voice
                trailing: Icon(Icons.mic, color: Colors.white),
                title:
                    Text("Na liście znajduje się ${state.listLength} pozycje", style: TextStyle(color: Colors.white)),
                subtitle: Text("Koszt produktów wynosi ${state.listCost.toStringAsFixed(2)} zł",
                    style: TextStyle(color: Colors.white)),
              );
            }
            return Center(child: Text("Coś poszło nie tak :("));
          })
        ],
      ),
    );
  }
}

class ShopListBuilder extends StatelessWidget {
  final ShopListBloc shopBloc;
  final List<ShopItem> items;

  const ShopListBuilder({
    @required this.shopBloc,
    @required this.items,
  });

  bool _updateItem(ShopItem item, int index, {String price = "", String name = ""}) {
    if (price != "" && name != "") {
      shopBloc.add(UpdateShopItem(item: item.copyWith(name: name, price: double.parse(price)), index: index));
      return true;
    }
    else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          final editController = TextEditingController(text: item.show());
          final priceController = TextEditingController(text: item.price.toStringAsFixed(2));
          return Dismissible(
              key: UniqueKey(),
              background: Container(
                color: Colors.red,
                child: Center(
                    child: Text(
                  "Kupione!",
                  style: TextStyle(color: Colors.white),
                )),
              ),
              direction: DismissDirection.startToEnd,
              onDismissed: (direction) {
                shopBloc.add(RemoveShopItem(item: item, index: index));
              },
              child: ListTile(
                  title: Row(
                children: <Widget>[
                  Expanded(
                    flex: 4,
                    child: TextField(
                      controller: editController,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none),
                      onEditingComplete: () {
                        if (!_updateItem(item, index, price: priceController.text, name: editController.text)) {
                          Flushbar(message: "Wartość nie może być pusta", duration: Duration(seconds: 2),).show(context);
                          editController.text = item.name;
                          priceController.text = item.price.toStringAsFixed(2);
                        }
                      },
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      controller: priceController,
                      keyboardType: TextInputType.numberWithOptions(decimal: true),
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                      decoration: InputDecoration(
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none),
                      onEditingComplete: () {
                        if (!_updateItem(item, index, price: priceController.text, name: editController.text)) {
                          Flushbar(message: "Wartość nie może być pusta", duration: Duration(seconds: 2),).show(context);
                          editController.text = item.name;
                          priceController.text = item.price.toStringAsFixed(2);
                        }
                      },
                    ),
                  )
                ],
              )
                  // title: TextField(
                  //   controller: editController,
                  //   style: TextStyle(color: Colors.white),
                  //   onEditingComplete: () {},
                  // ),
                  // title: TextField(  item.show(), style: TextStyle(color: Colors.white)),
                  // trailing: TextField(
                  //   controller: priceController,
                  //   style: TextStyle(color: Colors.grey),
                  //   onEditingComplete: () {},
                  // ),
                  // trailing: Text(item.price.toStringAsFixed(2), style: TextStyle(color: Colors.grey)),
                  ));
        });
  }
}
