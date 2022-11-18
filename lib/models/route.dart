class Route {
  Route({
    required this.name,
    required this.isActive,
    required this.id,
    required this.details,
    required this.routeNumber,
  });
  late final String name;
  late final bool isActive;
  late final String id;
  late final String details;
  late final String routeNumber;

  Route.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    isActive = json['isActive'];
    id = json['id'];
    details = json['details'];
    routeNumber = json['routeNumber'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['name'] = name;
    _data['isActive'] = isActive;
    _data['id'] = id;
    _data['details'] = details;
    _data['routeNumber'] = routeNumber;
    return _data;
  }
}
