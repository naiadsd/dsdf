import 'dart:convert';
import 'dart:async';
import 'package:dsd/models/customer.dart';

import 'package:http/http.dart' as http;

Future<List<Customer>> fetchCustomers(int route, int day) async {
  final response = await http.get(Uri.parse(
      "https://us-central1-gelaterianaia-a3f12.cloudfunctions.net/app/customer/getcustomersbyrouteday/$route/$day"));

  if (response.statusCode == 200) {
    Map<String, dynamic> map = json.decode(response.body);
    List<dynamic> customers = map["data"];
    return decodeCustomers(json.encode(customers));
  } else {
    throw Exception('Unable to fetch customers');
  }
}

List<Customer> decodeCustomers(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<Customer>((json) => Customer.fromJson(json)).toList();
}
