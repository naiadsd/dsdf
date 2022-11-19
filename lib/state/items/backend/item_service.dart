import 'dart:convert';
import 'dart:async';
import 'package:dsd/state/items/models/item.dart';
import 'package:http/http.dart' as http;

class ItemService {
  const ItemService();
  Future<List<Item>> fetchItems() async {
    final response = await http.get(Uri.parse(
        "https://us-central1-gelaterianaia-a3f12.cloudfunctions.net/app/item/getItems"));

    if (response.statusCode == 200) {
      Map<String, dynamic> map = json.decode(response.body);
      List<dynamic> items = map["items"];
      return decodeItems(json.encode(items));
    } else {
      throw Exception('Unable to fetch data from api');
    }
  }

  List<Item> decodeItems(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Item>((json) => Item.fromMap(json)).toList();
  }
}
