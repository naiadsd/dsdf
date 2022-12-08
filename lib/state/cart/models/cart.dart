import 'package:dsd/state/cart/models/cart_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show immutable;

@immutable
// ignore: must_be_immutable
class Cart {
  int? customerId;
  List<CartItem>? items;
  String? driverID;
  DateTime? orderdatetime;
  double? totalPrice;

  Cart({
    required this.customerId,
    this.items = const [],
    required this.driverID,
    required this.orderdatetime,
    this.totalPrice = 0.0,
  });

  Cart.initial() : orderdatetime = DateTime.now();

  void addItem(
      int id, int quantity, double price, String promoId, double salePrice) {
    items?.add(CartItem(
      itemId: id,
      promoId: promoId,
      promoPrice: price,
      saleprice: salePrice,
      totalPrice: quantity * price,
    ));
  }

  Cart addItemQuantity(int id, int quantity, double price) {
    var citems = items;
    var ct = totalPrice ?? 0.0;

    citems?.forEach((element) {
      if (element.itemId == id) {
        element.quantity = quantity;
        element.totalPrice = quantity * element.reOrderQuantity * price;
      }
    });

    return Cart(
      items: citems,
      customerId: customerId,
      driverID: driverID,
      orderdatetime: orderdatetime,
      totalPrice: ct + price * quantity,
    );
  }

  Cart copiedWithCustomer(int id) => Cart(
        customerId: id,
        driverID: driverID,
        orderdatetime: DateTime.now(),
        items: items,
        totalPrice: totalPrice,
      );

  Cart addNewItem(CartItem item) {
    var citems = items ?? [];

    citems.add(item);

    return Cart(
      customerId: customerId,
      driverID: driverID,
      items: citems,
      orderdatetime: orderdatetime,
      totalPrice: item.totalPrice,
    );
  }

  //Cart(customerId: customerId, driverID: driverID, orderdatetime: orderdatetime)
  bool removeItem(itemId) {
    items?.removeWhere((element) => element.itemId == itemId);
    return true;
  }
}
