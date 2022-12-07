import 'package:dsd/state/cart/cart_item.dart';

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

  Cart.initial(int cid, String driver)
      : customerId = cid,
        driverID = driver,
        orderdatetime = DateTime.now();

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

  void addItemQuantity(int id, int quantity, double price) {
    items?.forEach((element) {
      if (element.itemId == id) {
        element.quantity = quantity;
        element.totalPrice = quantity * element.reOrderQuantity * price;
      }
    });
  }

  bool removeItem(itemId) {
    items?.removeWhere((element) => element.itemId == itemId);
    return true;
  }
}
