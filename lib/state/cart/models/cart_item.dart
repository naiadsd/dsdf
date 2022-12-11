// ignore_for_file: unnecessary_this

class CartItem {
  late int itemId;
  late int quantity;
  late bool isPromoApplied;
  late String promoId;
  late double promoPrice;
  late double saleprice;
  late double totalPrice;
  late double reOrderQuantity;

  CartItem({
    required this.itemId,
    this.isPromoApplied = false,
    this.quantity = 1,
    required this.promoId,
    required this.promoPrice,
    required this.saleprice,
    required this.totalPrice,
    this.reOrderQuantity = 1,
  });

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        other is CartItem && other.itemId == itemId;
  }

  @override
  int get hashCode => Object.hashAll([itemId]);

  void increaseQuantity(int quantity) {
    this.quantity = quantity;
    this.totalPrice = this.promoPrice * quantity;
  }

  @override
  String toString() {
    super.toString();
    return this.itemId.toString();
  }
}
