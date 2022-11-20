class UserDetails {
  UserDetails({
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
  late final String lastName;
  late final String uuid;
  late final int phoneNumber;
  late final int id;
  late final String email;
  late final String role;
  late final String firstName;
  late final int route;
  late final String userId;
  late final String note;
  late final int totalOrders;
  late final double valueAdded;

  UserDetails.fromJson(Map<String, dynamic> json) {
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
    valueAdded = json['valueAdded'];
  }

  Map<String, dynamic> toJson() {
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
}
