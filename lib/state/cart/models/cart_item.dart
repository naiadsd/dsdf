// ignore_for_file: unnecessary_this

class CartItem {
  late String itemId;
  late int quantity;
  late bool isPromoApplied;
  late String promoId;
  late double promoPrice;
  late double saleprice;
  late double totalPrice;
  late double reOrderQuantity;
  late String itemDescription;

  CartItem({
    required this.itemId,
    this.isPromoApplied = false,
    this.quantity = 1,
    required this.promoId,
    required this.promoPrice,
    required this.saleprice,
    required this.totalPrice,
    required this.itemDescription,
    this.reOrderQuantity = 1,
  });

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        other is CartItem && other.itemId == itemId;
  }

  Map<String, dynamic> toJson() {
    // print(this.toString());
    final data = <String, dynamic>{};
    data['itemId'] = itemId;
    data['quantity'] = quantity;
    data['promoId'] = promoId;
    data['promoPrice'] = promoPrice;
    data['totalPrice'] = totalPrice.toStringAsFixed(2);
    data['reOrderQuantity'] = reOrderQuantity;
    data['saleprice'] = saleprice.toStringAsFixed(2);
    data['itemDescription'] = itemDescription;
    return data;
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
    return '${this.itemId.toString()} ${this.promoId} ${this.promoPrice} ${this.saleprice} ${this.totalPrice}';
  }
}
