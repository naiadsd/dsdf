class Promo {
  Promo({
    required this.id,
    required this.startDate,
    required this.promoId,
    required this.endDate,
    required this.itemPrefix,
    required this.price,
    required this.customerPrefix,
  });
  late final String id;
  late final DateTime startDate;
  late final String promoId;
  late final DateTime endDate;
  late final String itemPrefix;
  late final String price;
  late final String customerPrefix;

  Promo.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    startDate = DateTime.parse(json['startDate']);
    promoId = json['promoId'].toString();
    endDate = DateTime.parse(json['endDate']);
    itemPrefix = json['item_prefix'].toString();
    price = json['price'].toString();
    customerPrefix = json['customer_prefix'].toString();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['startDate'] = startDate.toString();
    data['promoId'] = promoId;
    data['endDate'] = endDate.toString();
    data['item_prefix'] = itemPrefix;
    data['price'] = price;
    data['customer_prefix'] = customerPrefix;
    return data;
  }
}
