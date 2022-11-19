class Customer {
  Customer({
    required this.id,
    required this.shipToAddressLineOne,
    required this.CODTerms,
    required this.routeCode,
    required this.shipToAddressLineTwo,
    required this.prepaidTerms,
    required this.serviceDays,
    required this.discountDays,
    required this.customerId,
    required this.serviceFrequency,
    required this.discountPercentage,
    required this.salesAccount,
    required this.billToAddressLineOne,
    required this.billToState,
    required this.shipToSate,
    required this.useStandardTerms,
    required this.dueDays,
    required this.accountNo,
    required this.billToCity,
    required this.phone,
    required this.pricingLevel,
    required this.customerName,
    required this.creditLimit,
    required this.billFirstName,
    required this.shipToZip,
    required this.billToZip,
    required this.isInactive,
    required this.billLastName,
    required this.serviceSequence,
    required this.shipToCity,
    required this.billToAddressLineTwo,
    required this.soldhere,
  });
  late final int id;
  late final String shipToAddressLineOne;
  late final String CODTerms;
  late final String routeCode;
  late final String shipToAddressLineTwo;
  late final String prepaidTerms;
  late final String serviceDays;
  late final String discountDays;
  late final String customerId;
  late final String serviceFrequency;
  late final String discountPercentage;
  late final String salesAccount;
  late final String billToAddressLineOne;
  late final String billToState;
  late final String shipToSate;
  late final String useStandardTerms;
  late final String dueDays;
  late final String accountNo;
  late final String billToCity;
  late final String phone;
  late final String pricingLevel;
  late final String customerName;
  late final String creditLimit;
  late final String billFirstName;
  late final String shipToZip;
  late final String billToZip;
  late final String isInactive;
  late final String billLastName;
  late final String serviceSequence;
  late final String shipToCity;
  late final String billToAddressLineTwo;
  late final String soldhere;

  Customer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    shipToAddressLineOne = json['shipToAddressLineOne'];
    CODTerms = json['CODTerms'];
    routeCode = json['routeCode'];
    shipToAddressLineTwo = json['shipToAddressLineTwo'];
    prepaidTerms = json['prepaidTerms'];
    serviceDays = json['serviceDays'];
    discountDays = json['discountDays'];
    customerId = json['customerId'];
    serviceFrequency = json['serviceFrequency'];
    discountPercentage = json['discountPercentage'];
    salesAccount = json['salesAccount'];
    billToAddressLineOne = json['billToAddressLineOne'];
    billToState = json['billToState'];
    shipToSate = json['shipToSate'];
    useStandardTerms = json['useStandardTerms'];
    dueDays = json['dueDays'];
    accountNo = json['accountNo'];
    billToCity = json['billToCity'];
    phone = json['phone'];
    pricingLevel = json['pricingLevel'];
    customerName = json['customerName'];
    creditLimit = json['creditLimit'];
    billFirstName = json['billFirstName'];
    shipToZip = json['shipToZip'];
    billToZip = json['billToZip'];
    isInactive = json['isInactive'];
    billLastName = json['billLastName'];
    serviceSequence = json['serviceSequence'];
    shipToCity = json['shipToCity'];
    billToAddressLineTwo = json['billToAddressLineTwo'];
    soldhere = json['soldhere'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['shipToAddressLineOne'] = shipToAddressLineOne;
    _data['CODTerms'] = CODTerms;
    _data['routeCode'] = routeCode;
    _data['shipToAddressLineTwo'] = shipToAddressLineTwo;
    _data['prepaidTerms'] = prepaidTerms;
    _data['serviceDays'] = serviceDays;
    _data['discountDays'] = discountDays;
    _data['customerId'] = customerId;
    _data['serviceFrequency'] = serviceFrequency;
    _data['discountPercentage'] = discountPercentage;
    _data['salesAccount'] = salesAccount;
    _data['billToAddressLineOne'] = billToAddressLineOne;
    _data['billToState'] = billToState;
    _data['shipToSate'] = shipToSate;
    _data['useStandardTerms'] = useStandardTerms;
    _data['dueDays'] = dueDays;
    _data['accountNo'] = accountNo;
    _data['billToCity'] = billToCity;
    _data['phone'] = phone;
    _data['pricingLevel'] = pricingLevel;
    _data['customerName'] = customerName;
    _data['creditLimit'] = creditLimit;
    _data['billFirstName'] = billFirstName;
    _data['shipToZip'] = shipToZip;
    _data['billToZip'] = billToZip;
    _data['isInactive'] = isInactive;
    _data['billLastName'] = billLastName;
    _data['serviceSequence'] = serviceSequence;
    _data['shipToCity'] = shipToCity;
    _data['billToAddressLineTwo'] = billToAddressLineTwo;
    _data['soldhere'] = soldhere;
    return _data;
  }
}
