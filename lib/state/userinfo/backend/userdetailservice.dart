import 'dart:convert';

import 'package:dsd/state/userinfo/model/user.dart';

import 'package:http/http.dart' as http;

class UserDetailService {
  const UserDetailService();

  Future<User> fetchUserDetails(String uuid) async {
    print(uuid);
    final response = await http.get(Uri.parse(
        "https://us-central1-gelaterianaia-a3f12.cloudfunctions.net/app/user/userdetailsbyuuid/$uuid"));
    if (response.statusCode == 200) {
      Map<String, dynamic> map = json.decode(response.body);
      dynamic userInfo = map["userInfo"];

      final userDetails = User.fromJson(userInfo);

      return userDetails;
    } else {
      throw Exception('Unable to fetch user Information');
    }
  }
}
