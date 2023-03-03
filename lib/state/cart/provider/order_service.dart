import 'dart:convert';

import 'package:dsd/state/serviceuurls.dart';
import 'package:http/http.dart' as http;

Future<bool> sendOrdertoServer(Map<String, dynamic> order) async {
  try {
    var url = Uri.parse(createOrder);
    //  print(order);
    //var bd = jsonEncode({"order": order});
    // const payload = {order:jsonEncode(order)};
    // var map = new Map<String, dynamic>();
    // map['order'] = {'oder data': 'id'};
    //map['password'] = 'password';
    print(jsonEncode(order));
    final res = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(order));

    return true;
  } catch (e) {
    print(e.toString());
    return false;
  }
}
