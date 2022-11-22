// ignore_for_file: unnecessary_this

class User {
  String? lastName;
  String? uuid;
  int? phoneNumber;
  int? id;
  String? email;
  String? role;
  String? firstName;
  int? route;
  String? userId;
  String? note;
  int? totalOrders;
  double? valueAdded;

  User({
    required this.lastName,
    required this.uuid,
    required this.phoneNumber,
    required this.id,
    required this.email,
    required this.role,
    required this.firstName,
    required this.route,
    required this.userId,
    required this.note,
    required this.totalOrders,
    required this.valueAdded,
  });

  User.unknown()
      : id = 0,
        email = null;

  User.fromJson(Map<String, dynamic> json) {
    //print(json);
    lastName = json['lastName'];
    uuid = json['uuid'];
    phoneNumber = json['phoneNumber'];
    id = json['id'];
    email = json['email'];
    role = json['role'];
    firstName = json['firstName'];
    route = json['route'];
    userId = json['userId'];
    note = json['note'];
    totalOrders = json['totalOrders'];
    valueAdded = json['valueAdded'].toDouble();
  }

  Map<String, dynamic> toJson() {
    ;
    final _data = <String, dynamic>{};
    _data['lastName'] = lastName;
    _data['uuid'] = uuid;
    _data['phoneNumber'] = phoneNumber;
    _data['id'] = id;
    _data['email'] = email;
    _data['role'] = role;
    _data['firstName'] = firstName;
    _data['route'] = route;
    _data['userId'] = userId;
    _data['note'] = note;
    _data['totalOrders'] = totalOrders;
    _data['valueAdded'] = valueAdded;
    return _data;
  }

  set setTotalOrders(int totalOrder) {
    totalOrders = totalOrder;
  }

  set setTotalvalue(double value) {
    valueAdded = value;
  }

  int get routeNumber => route ?? 0;

  int get gettoalOrders => totalOrders ?? 0;

  double get getValueAdded => valueAdded ?? 0.0;
}
