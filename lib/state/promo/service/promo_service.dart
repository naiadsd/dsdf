import 'dart:convert';

import 'package:dsd/state/promo/model/promo.dart';
import 'package:http/http.dart' as http;

class PromoService {
  const PromoService();
  Future<List<Promo>> fetchPromos() async {
    final respone = await http.get(Uri.parse(
        'https://us-central1-gelaterianaia-a3f12.cloudfunctions.net/app/promo/getpromos'));

    if (respone.statusCode == 200) {
      Map<String, dynamic> map = json.decode(respone.body);
      List<dynamic> promos = map['promos'];
      return decodePromos(json.encode(promos));
    } else {
      throw Exception('Unable to fetch customers');
    }
  }

  List<Promo> decodePromos(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Promo>((json) => Promo.fromJson(json)).toList();
  }
}
