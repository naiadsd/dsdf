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
  late final String itemId;
  late final String descriptionForSales;
  late final String name;
  late final double salePrice;
  late final double salePriceTwo;
  late final double salePriceThree;
  late final double salePriceFour;
  late final double salePriceFive;
  late final double salePriceSix;
  late final double salePriceSeven;
  late final double salePriceEight;
  late final double salePriceNine;
  late final double salePriceTen;
  late final bool isInActive;
  late final String glCOGSSalaryAccount;
  late final String upcsku;
  late final String weight;
  late final String glInventoryAccount;
  late final String description;
  late final int orderSeq;
  late final int reOrderQuantity;

  Item.fromJsonDB(Map<String, dynamic> json) {
    // print(json);
    id = json['id'];
    name = json['name'];
    descriptionForSales = json['descriptionForSales'];
    description = json['description'];
    itemId = json['itemId'];
    salePrice = double.parse(json['salePrice'].toString());
    salePriceTwo = double.parse(json['salePriceTwo'].toString());
    salePriceThree = double.parse(json['salePriceThree'].toString());
    salePriceFour = double.parse(json['salePriceFour'].toString());
    salePriceFive = double.parse(json['salePriceFive'].toString());
    salePriceSix = double.parse(json['salePriceSix'].toString());
    salePriceSeven = double.parse(json['salePriceSeven'].toString());
    salePriceEight = double.parse(json['salePriceEight'].toString());
    salePriceNine = double.parse(json['salePriceNine'].toString());
    salePriceTen = double.parse(json['salePriceTen'].toString());
    isInActive = json['isInActive'] == 0 ? false : true;
    glCOGSSalaryAccount = json['glCOGSSalaryAccount'].toString();
    upcsku = json['upcsku'].toString();
    weight = json['weight'].toString();
    glInventoryAccount = json['glInventoryAccount'].toString();
    orderSeq = int.parse(json['orderSeq'].toString());
    reOrderQuantity = int.parse(json['reOrderQuantity'].toString());
  }

  Item.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int;
    name = json['name'] as String;
    descriptionForSales = json['descriptionForSales'] as String;
    description = json['description'] as String;
    itemId = json['itemId'];
    salePrice = json['salePrice'].toDouble();
    salePriceTwo = json['salePriceTwo'].toDouble();
    salePriceThree = json['salePriceThree'].toDouble();
    salePriceFour = json['salePriceFour'].toDouble();
    salePriceFive = json['salePriceFive'].toDouble();
    salePriceSix = json['salePriceSix'].toDouble();
    salePriceSeven = json['salePriceSeven'].toDouble();
    salePriceEight = json['salePriceEight'].toDouble();
    salePriceNine = json['salePriceNine'].toDouble();
    salePriceTen = json['salePriceTen'].toDouble();
    isInActive = json['isInActive'];
    glCOGSSalaryAccount = json['glCOGSSalaryAccount'];
    upcsku = json['upcsku'].toString();
    weight = json['weight'].toString();
    glInventoryAccount = json['glInventoryAccount'].toString();
    orderSeq = json['orderSeq'] as int;
    reOrderQuantity = json['reOrderQuantity'] as int;
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
