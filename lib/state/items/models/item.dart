class Item {
  Item({
    required this.id,
    required this.salePriceSeven,
    required this.salePriceTwo,
    required this.itemId,
    required this.salePrice,
    required this.isInActive,
    required this.glCOGSSalaryAccount,
    required this.upcsku,
    required this.weight,
    required this.glInventoryAccount,
    required this.salePriceFour,
    required this.description,
    required this.name,
    required this.salePriceThree,
    required this.salePriceEight,
    required this.descriptionForSales,
    required this.orderSeq,
    required this.salePriceFive,
    required this.salePriceNine,
    required this.salePriceTen,
    required this.salePriceSix,
    required this.reOrderQuantity,
  });
  late final int id;
  late final double salePriceSeven;
  late final double salePriceTwo;
  late final String itemId;
  late final double salePrice;
  late final String isInActive;
  late final String glCOGSSalaryAccount;
  late final String upcsku;
  late final String weight;
  late final String glInventoryAccount;
  late final double salePriceFour;
  late final String description;
  late final String name;
  late final double salePriceThree;
  late final double salePriceEight;
  late final String descriptionForSales;
  late final int orderSeq;
  late final double salePriceFive;
  late final double salePriceNine;
  late final double salePriceTen;
  late final double salePriceSix;
  late final String reOrderQuantity;

  Item.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    salePriceSeven = json['salePriceSeven'] as double;
    salePriceTwo = json['salePriceTwo'] as double;
    itemId = json['itemId'];
    salePrice = json['salePrice'] as double;
    isInActive = json['isInActive'];
    glCOGSSalaryAccount = json['glCOGSSalaryAccount'];
    upcsku = json['upcsku'];
    weight = json['weight'];

    glInventoryAccount = json['glInventoryAccount'] as String;
    salePriceFour = json['salePriceFour'] as double;

    description = json['description'] as String;
    name = json['name'] as String;
    salePriceThree = json['salePriceThree'] as double;

    salePriceEight = json['salePriceEight'] as double;

    descriptionForSales = json['descriptionForSales'] as String;
    orderSeq = json['orderSeq'] as int;
    salePriceFive = json['salePriceFive'] as double;

    salePriceNine = json['salePriceNine'] as double;

    salePriceTen = json['salePriceTen'] as double;

    salePriceSix = json['salePriceSix'] as double;

    reOrderQuantity = json['reOrderQuantity'].toString();
  }
  Item.fromMap(Map<String, dynamic> json) {
    id = json['id'];
    salePriceSeven = json['salePriceSeven'];
    salePriceTwo = json['salePriceTwo'];
    itemId = json['itemId'];
    salePrice = json['salePrice'];
    isInActive = json['isInActive'];
    glCOGSSalaryAccount = json['glCOGSSalaryAccount'];
    upcsku = json['upcsku'];
    weight = json['weight'];
    glInventoryAccount = json['glInventoryAccount'];
    salePriceFour = json['salePriceFour'];
    description = json['description'];
    name = json['name'];
    salePriceThree = json['salePriceThree'];
    salePriceEight = json['salePriceEight'];
    descriptionForSales = json['descriptionForSales'];
    orderSeq = json['orderSeq'];
    salePriceFive = json['salePriceFive'];
    salePriceNine = json['salePriceNine'];
    salePriceTen = json['salePriceTen'];
    salePriceSix = json['salePriceSix'];
    reOrderQuantity = json['reOrderQuantity'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['salePriceSeven'] = salePriceSeven;
    _data['salePriceTwo'] = salePriceTwo;
    _data['itemId'] = itemId;
    _data['salePrice'] = salePrice;
    _data['isInActive'] = isInActive;
    _data['glCOGSSalaryAccount'] = glCOGSSalaryAccount;
    _data['upcsku'] = upcsku;
    _data['weight'] = weight;
    _data['glInventoryAccount'] = glInventoryAccount;
    _data['salePriceFour'] = salePriceFour;
    _data['description'] = description;
    _data['name'] = name;
    _data['salePriceThree'] = salePriceThree;
    _data['salePriceEight'] = salePriceEight;
    _data['descriptionForSales'] = descriptionForSales;
    _data['orderSeq'] = orderSeq;
    _data['salePriceFive'] = salePriceFive;
    _data['salePriceNine'] = salePriceNine;
    _data['salePriceTen'] = salePriceTen;
    _data['salePriceSix'] = salePriceSix;
    _data['reOrderQuantity'] = reOrderQuantity;
    return _data;
  }
}
