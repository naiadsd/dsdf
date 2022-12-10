import 'package:dsd/db/item/item_db_contants.dart';
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

  double getCartTotal() {
    double tp = 0.0;
    if (items!.isNotEmpty) {
      for (var element in items!) {
        tp = tp + element.totalPrice;
      }
      return tp;
    } else {
      return tp;
    }
  }

  Cart createCart(int cuId, String driverID) {
    return Cart(
        customerId: cuId, driverID: driverID, orderdatetime: orderdatetime);
  }

  Cart.initial() : orderdatetime = DateTime.now();

  void addItem(
    int id,
    int quantity,
    double promoPrice,
    String promoId,
    double salePrice,
    bool isPromo,
    double reOrderQuantity,
  ) {
    items?.add(CartItem(
      itemId: id,
      promoId: promoId,
      promoPrice: promoPrice,
      saleprice: salePrice,
      totalPrice: quantity * reOrderQuantity * promoPrice,
      reOrderQuantity: reOrderQuantity,
      isPromoApplied: isPromo,
    ));

    totalPrice = getCartTotal();
  }

  Cart addItemQuantity(int id, int quantity) {
    var citems = items;

    citems?.forEach((element) {
      if (element.itemId == id) {
        element.quantity = quantity;
        element.totalPrice =
            quantity * element.reOrderQuantity * element.promoPrice;
      }
    });
    double ct = getCartTotal();
    return Cart(
      items: citems,
      customerId: customerId,
      driverID: driverID,
      orderdatetime: orderdatetime,
      totalPrice: ct,
    );
  }

  Cart removeItem(int id) {
    var citems = items;

    citems?.removeWhere((element) => element.itemId == id);
    return Cart(
      customerId: customerId,
      driverID: driverID,
      orderdatetime: orderdatetime,
      items: citems,
      totalPrice: getCartTotal(),
    );
  }

  Cart copiedWithCustomer(int customerId) => Cart(
        customerId: customerId,
        driverID: driverID,
        orderdatetime: DateTime.now(),
        items: items,
        totalPrice: totalPrice,
      );

  Cart addNewItem(CartItem item) {
    var citems = items ?? [];
    double totav = item.reOrderQuantity * item.quantity * item.promoPrice;
    if (citems.isNotEmpty) {
      totav = totav + getCartTotal();
    } else {}

    citems.add(item);

    return Cart(
      customerId: customerId,
      driverID: driverID,
      items: citems,
      orderdatetime: orderdatetime,
      totalPrice: totav,
    );
  }
}
