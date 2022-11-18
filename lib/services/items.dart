import 'dart:convert';
import 'dart:async';
import 'package:dsd/models/item.dart';
import 'package:http/http.dart' as http;

Future<List<Item>> fetchItems() async {
  final response = await http.get(Uri.parse(
      "https://us-central1-gelaterianaia-a3f12.cloudfunctions.net/app/item/getItems"));
  print("strted");
  if (response.statusCode == 200) {
    Map<String, dynamic> map = json.decode(response.body);
    List<dynamic> items = map["items"];
    return decodeItems(json.encode(items));
  } else {
    throw Exception('Unable to fetch data from api');
  }
}

List<Item> decodeItems(String responseBody) {
  print(responseBody);
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<Item>((json) => Item.fromMap(json)).toList();
}
