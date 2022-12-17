import 'dart:convert';

class Settings {
  DateTime? lastsyncDate;

  Settings({required this.lastsyncDate});

  Settings.today() : lastsyncDate = DateTime.now();

  Settings.fromJson(Map<String, dynamic> json) {
    lastsyncDate = json['lastsyncDate'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['lastsyncDate'] = lastsyncDate;

    return data;
  }
}
