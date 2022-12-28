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
    final data = <String, dynamic>{};
    data['lastName'] = lastName;
    data['uuid'] = uuid;
    data['phoneNumber'] = phoneNumber;
    data['id'] = id;
    data['email'] = email;
    data['role'] = role;
    data['firstName'] = firstName;
    data['route'] = route;
    data['userId'] = userId;
    data['note'] = note;
    data['totalOrders'] = totalOrders;
    data['valueAdded'] = valueAdded;
    return data;
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
