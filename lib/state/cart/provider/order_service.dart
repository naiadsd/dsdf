import 'package:dsd/state/serviceuurls.dart';
import 'package:http/http.dart' as http;

Future<bool> sendOrdertoServer(Map<String, dynamic> order) async {
  try {
    var url = Uri.parse(createOrder);
    final res = await http.post(url, body: order);
    return true;
  } catch (e) {
    return false;
  }
}
