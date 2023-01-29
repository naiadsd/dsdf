import 'package:dsd/db/item/item_db_contants.dart';
import 'package:dsd/state/cart/models/cart_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:intl/intl.dart';

@immutable
// ignore: must_be_immutable
class Cart {
  List<CartItem>? items;
  String? driverID;
  DateTime? orderdatetime;
  double? totalPrice;
  String? orderId;
  String? customerId;
  String? note;
  double? orderQty;
  String? driverName;
  String? customerName;

  Cart({
    this.items = const [],
    required this.driverID,
    required this.orderdatetime,
    this.totalPrice = 0.0,
    String? orderId,
    required this.customerId,
    String? note,
    double? orderQty,
    String? driverName,
    String? customerName,
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

  Cart createCart(
    String cuId,
    String driverID,
    String customerName,
    String driverName,
  ) {
    return Cart(
      customerId: cuId,
      driverID: driverID,
      orderdatetime: orderdatetime,
      customerName: customerName,
      driverName: driverName,
    );
  }

  Cart.initial() : orderdatetime = DateTime.now();

  void addItem(
    String id,
    int quantity,
    double promoPrice,
    String promoId,
    double salePrice,
    bool isPromo,
    double reOrderQuantity,
    String itemDescription,
  ) {
    items?.add(CartItem(
      itemId: id,
      promoId: promoId,
      promoPrice: promoPrice,
      saleprice: salePrice,
      totalPrice: quantity * reOrderQuantity * promoPrice,
      reOrderQuantity: reOrderQuantity,
      isPromoApplied: isPromo,
      itemDescription: itemDescription,
    ));

    totalPrice = getCartTotal();
  }

  Cart addItemQuantity(String itemId, int quantity) {
    var citems = items;

    citems?.forEach((element) {
      if (element.itemId == itemId) {
        print(element.toString());
        element.quantity = quantity;
        element.totalPrice = quantity *
            element.reOrderQuantity *
            (element.isPromoApplied ? element.promoPrice : element.saleprice);
      }
    });
    double ct = getCartTotal();
    return Cart(
      items: citems,
      customerId: customerId,
      driverID: driverID,
      orderdatetime: orderdatetime,
      totalPrice: ct,
      driverName: driverName,
    );
  }

  Cart removeItem(String itemID) {
    var citems = items;

    citems?.removeWhere((element) => element.itemId == itemID);
    return Cart(
      customerId: customerId,
      driverID: driverID,
      orderdatetime: orderdatetime,
      items: citems,
      totalPrice: getCartTotal(),
      driverName: driverName,
    );
  }

  Cart copiedWithCustomer(String customerId) => Cart(
        customerId: customerId,
        driverID: driverID,
        orderdatetime: DateTime.now(),
        items: items,
        totalPrice: totalPrice,
        driverName: driverName,
      );

  Cart copyWithInvoiceNumber(String invoiceNumber) {
    orderId = invoiceNumber;
    return this;
  }

  Cart copiedWithInvoceNumber(String invoiceNumber) => Cart(
        customerId: customerId,
        driverID: driverID,
        orderdatetime: orderdatetime,
        items: items,
        totalPrice: totalPrice,
        orderId: invoiceNumber,
        driverName: driverName,
      );
  Cart addNewItem(CartItem item) {
    //print(item.toString());
    List<CartItem> citems = items ?? [];

    double totav = item.reOrderQuantity *
        item.quantity *
        (item.isPromoApplied ? item.promoPrice : item.saleprice);

    item.totalPrice = totav;

    if (citems.isNotEmpty) {
      totav = totav + getCartTotal();
    } else {}
    citems = [...citems, item];

    return Cart(
      customerId: customerId,
      driverID: driverID,
      items: citems,
      orderdatetime: orderdatetime,
      totalPrice: totav,
      driverName: driverName,
    );
  }

  Map<String, dynamic> toJson() {
    //print('cart');
    // print(this.toString());
    final _data = <String, dynamic>{};
    var newDt = DateFormat.yMMMEd().format(DateTime.now());
    var time = DateFormat.Hm().format(DateTime.now());

    _data['orderDate'] = newDt;
    _data['customerId'] = customerId;
    _data['driverID'] = driverID;
    _data['toalPrice'] = totalPrice?.toStringAsFixed(2);
    _data['CustomerName'] = customerName;
    _data['orderId'] = orderId;
    _data['orderQty'] = orderQty;
    _data['driverName'] = driverName;
    _data['note'] = note ?? 'notes';
    _data['date'] = DateFormat("yy-MM-dd").format(DateTime.now());
    _data['time'] = time;
    _data['ItemCheckList'] = items?.map((e) => e.toJson()).toList();
    return {'order': _data};
  }

  @override
  String toString() {
    super.toString();
    return "${totalPrice.toString()} $note $customerName $driverName $driverID";
  }
}
