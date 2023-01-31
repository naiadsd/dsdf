import 'dart:convert';
import 'dart:async';
import 'package:dsd/db/db_provider.dart';
import 'package:dsd/state/items/models/item.dart';
import 'package:dsd/state/serviceuurls.dart';
import 'package:http/http.dart' as http;

class ItemService {
  const ItemService();
  Future<List<Item>> fetchItems() async {
    final response = await http.get(Uri.parse(itemsURL));

    if (response.statusCode == 200) {
      Map<String, dynamic> map = json.decode(response.body);
      List<dynamic> items = map["items"];
      return decodeItems(json.encode(items));
    } else {
      throw Exception('Unable to fetch data from api');
    }
  }

  Future<List<Item>> fetchAllItemsFromDB() async {
    return DBProvier.db.getAllItems();
  }

  List<Item> decodeItems(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Item>((json) => Item.fromMap(json)).toList();
  }
}

Future<List<Item>> fetchItemsSave() async {
  final response = await http.get(Uri.parse(itemsURL));
  try {
    if (response.statusCode == 200) {
      Map<String, dynamic> map = json.decode(response.body);
      List<dynamic> items = map["items"];

      List<Item> c = decodeItems(json.encode(items));
      print('items got');
      return c;
    } else {
      throw Exception('Unable to fetch items from api');
    }
  } catch (e) {
    print('$e error occured in items fetch ItemsSave method.');
    throw Exception('Unable to fetch items from api');
  }
}

List<Item> decodeItems(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<Item>((item) => Item.fromJson(item)).toList();
}
