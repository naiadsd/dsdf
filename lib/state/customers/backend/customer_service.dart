import 'dart:convert';
import 'dart:async';

import 'package:dsd/db/db_provider.dart';
import 'package:dsd/state/customers/model/customer.dart';
import 'package:dsd/state/serviceuurls.dart';
import 'package:http/http.dart' as http;

class CustomerService {
  List<Customer>? customers;
  CustomerService({required this.customers});

  Future<List<Customer>> fetchCustomersfromDB() async {
    return await DBProvier.db.getAllCustomers();
  }
}

Future<List<Customer>> fetchCustomersfromDB() async {
  return await DBProvier.db.getAllCustomers();
}

Future<List<Customer>> fetchAllCustomers() async {
  final response = await http.get(Uri.parse(customersURL));

  if (response.statusCode == 200) {
    Map<String, dynamic> map = json.decode(response.body);
    List<dynamic> customers = map["data"];

    return decodeCustomersSave(json.encode(customers));
  } else {
    throw Exception('Unable to fetch customers');
  }
}

/* monday start from 1 */
Future<List<Customer>> fetchCustomersForRouteAndDay(int route, int day) async {
  String url = customersForDayAndRoute(route, day);

  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    Map<String, dynamic> map = json.decode(response.body);
    List<dynamic> customers = map["data"];

    return decodeCustomersSave(json.encode(customers));
  } else {
    throw Exception('Unable to fetch customers');
  }
}

Future<List<Customer>> fetchCustomersForRouteAndDayAndWeek(
    int route, int day, int week) async {
  String url = customersForDayAndRouteWeek(route, day, week);

  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    Map<String, dynamic> map = json.decode(response.body);
    List<dynamic> customers = map["data"];

    return decodeCustomersSave(json.encode(customers));
  } else {
    throw Exception('Unable to fetch customers');
  }
}

Future<List<Customer>> fetchCustomersForSave(int route, int day) async {
  final response = await http.get(Uri.parse(
      "https://us-central1-gelaterianaia-a3f12.cloudfunctions.net/app/customer/getcustomersbyrouteday/$route/$day"));

  if (response.statusCode == 200) {
    Map<String, dynamic> map = json.decode(response.body);
    List<dynamic> customers = map["data"];

    return decodeCustomersSave(json.encode(customers));
  } else {
    throw Exception('Unable to fetch customers');
  }
}

List<Customer> decodeCustomersSave(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<Customer>((json) => Customer.fromJson(json)).toList();
}
