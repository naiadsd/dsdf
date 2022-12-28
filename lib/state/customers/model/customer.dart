class Customer {
  Customer({
    required this.id,
    required this.billToAddressLineOne,
    required this.accountNo,
    required this.shipToAddressLineOne,
    required this.prepaidTerms,
    required this.shipToAddressLineTwo,
    required this.serviceSequence,
    required this.isInactive,
    required this.billFirstName,
    required this.billLastName,
    required this.shipToCity,
    required this.shipToSate,
    required this.billToAddressLineTwo,
    required this.routeCode,
    required this.billToZip,
    required this.discountDays,
    required this.serviceDays,
    required this.billToCity,
    required this.serviceFrequency,
    required this.creditLimit,
    required this.customerId,
    required this.phone,
    required this.CODTerms,
    required this.salesAccount,
    required this.billToState,
    required this.pricingLevel,
    required this.discountPercentage,
    required this.customerName,
    required this.shipToZip,
    required this.useStandardTerms,
    required this.dueDays,
    required this.soldhere,
    required this.isPromoAvailable,
  });
  late final int id;
  late final String billToAddressLineOne;
  late final String accountNo;
  late final String shipToAddressLineOne;
  late final String prepaidTerms;
  late final String shipToAddressLineTwo;
  late final String serviceSequence;
  late final String isInactive;
  late final String billFirstName;
  late final String billLastName;
  late final String shipToCity;
  late final String shipToSate;
  late final String billToAddressLineTwo;
  late final String routeCode;
  late final String billToZip;
  late final String discountDays;
  late final String serviceDays;
  late final String billToCity;
  late final String serviceFrequency;
  late final String creditLimit;
  late final String customerId;
  late final String phone;
  late final String CODTerms;
  late final String salesAccount;
  late final String billToState;
  late final String pricingLevel;
  late final String discountPercentage;
  late final String customerName;
  late final String shipToZip;
  late final String useStandardTerms;
  late final String dueDays;
  late final String soldhere;
  bool? isPromoAvailable;

  Customer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    billToAddressLineOne = json['billToAddressLineOne'] ?? '';
    accountNo = json['accountNo'] ?? '';
    shipToAddressLineOne = json['shipToAddressLineOne'] ?? '';
    prepaidTerms = json['prepaidTerms'] ?? '';
    shipToAddressLineTwo = json['shipToAddressLineTwo'] ?? '';
    serviceSequence = json['serviceSequence'] ?? '';
    isInactive = json['isInactive'] ?? '';
    billFirstName = json['billFirstName'] ?? '';
    billLastName = json['billLastName'] ?? '';
    shipToCity = json['shipToCity'] ?? '';
    shipToSate = json['shipToSate'] ?? '';
    billToAddressLineTwo = json['billToAddressLineTwo'] ?? '';
    routeCode = json['routeCode'] ?? '';
    billToZip = json['billToZip'] ?? '';
    discountDays = json['discountDays'] ?? '';
    serviceDays = json['serviceDays'] ?? '';
    billToCity = json['billToCity'] ?? '';
    serviceFrequency = json['serviceFrequency'] ?? '';
    creditLimit = json['creditLimit'] ?? '';
    customerId = json['customerId'] ?? '';
    phone = json['phone'] ?? '';
    CODTerms = json['CODTerms'] ?? '';
    salesAccount = json['salesAccount'] ?? '';
    billToState = json['billToState'] ?? '';
    pricingLevel = json['pricingLevel'] ?? '';
    discountPercentage = json['discountPercentage'] ?? '';
    customerName = json['customerName'] ?? '';
    shipToZip = json['shipToZip'] ?? '';
    useStandardTerms = json['useStandardTerms'] ?? '';
    dueDays = json['dueDays'] ?? '';
    soldhere = json['soldhere'] ?? '';
    isPromoAvailable =
        json['isPromoAvailable'].toString() == '1' ? true : false;
    //  ? false
    // : true;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['billToAddressLineOne'] = billToAddressLineOne;
    _data['accountNo'] = accountNo;
    _data['shipToAddressLineOne'] = shipToAddressLineOne;
    _data['prepaidTerms'] = prepaidTerms;
    _data['shipToAddressLineTwo'] = shipToAddressLineTwo;
    _data['serviceSequence'] = serviceSequence;
    _data['isInactive'] = isInactive;
    _data['billFirstName'] = billFirstName;
    _data['billLastName'] = billLastName;
    _data['shipToCity'] = shipToCity;
    _data['shipToSate'] = shipToSate;
    _data['billToAddressLineTwo'] = billToAddressLineTwo;
    _data['routeCode'] = routeCode;
    _data['billToZip'] = billToZip;
    _data['discountDays'] = discountDays;
    _data['serviceDays'] = serviceDays;
    _data['billToCity'] = billToCity;
    _data['serviceFrequency'] = serviceFrequency;
    _data['creditLimit'] = creditLimit;
    _data['customerId'] = customerId;
    _data['phone'] = phone;
    _data['CODTerms'] = CODTerms;
    _data['salesAccount'] = salesAccount;
    _data['billToState'] = billToState;
    _data['pricingLevel'] = pricingLevel;
    _data['discountPercentage'] = discountPercentage;
    _data['customerName'] = customerName;
    _data['shipToZip'] = shipToZip;
    _data['useStandardTerms'] = useStandardTerms;
    _data['dueDays'] = dueDays;
    _data['soldhere'] = soldhere;
    _data['isPromoAvailable'] = isPromoAvailable;
    return _data;
  }
}
