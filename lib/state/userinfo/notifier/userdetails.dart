import 'dart:convert';
import 'package:dsd/state/auth/backend/authenticator.dart';
import 'package:dsd/state/userinfo/backend/userdetailservice.dart';
import 'package:dsd/state/userinfo/model/user.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserDetailsStateNotifier extends StateNotifier<User> {
  final _userSerevice = const UserDetailService();
  final _authenticator = const Authenticator();
  //final prefs = await SharedPreferences.getInstance();
  late SharedPreferences prefs;

  bool validator(String? value) {
    if (value!.isEmpty) {
      return true;
    }
    return false;
  }

  Future _init() async {
    prefs = await SharedPreferences.getInstance();
    var userInfo = prefs.getString('userInfo');

    if (userInfo != null) {
      state = User.fromJson(json.decode(userInfo));
    }
  }

  UserDetailsStateNotifier() : super(User.unknown()) {
    if (_authenticator.isAlreadyLoggedIn) {
      _init();
    } else {
      state = User(
        lastName: null,
        uuid: _authenticator.userId,
        phoneNumber: null,
        id: null,
        email: null,
        role: null,
        firstName: null,
        route: null,
        userId: _authenticator.userId,
        note: null,
        totalOrders: null,
        valueAdded: null,
      );
    }
  }

  Future<void> fetchUserDetails(String uuid) async {
    final result = await _userSerevice.fetchUserDetails(uuid);
    final userinfo = result.toJson();
    prefs.setString('userInfo', json.encode(userinfo));

    state = User(
      lastName: result.lastName,
      uuid: uuid,
      phoneNumber: result.phoneNumber,
      id: result.id,
      email: result.email,
      role: result.role,
      firstName: result.firstName,
      route: result.route,
      userId: result.userId,
      note: result.note,
      totalOrders: result.totalOrders,
      valueAdded: result.valueAdded,
    );
  }

  void setRoute(int routeN) async {
    prefs = await SharedPreferences.getInstance();
    var userInfo = prefs.getString('userInfo');

    if (userInfo != null) {
      state = User.fromJson(json.decode(userInfo));
      state.route = routeN;
      final userinfo = state.toJson();
      prefs.setString('userInfo', json.encode(userinfo));
    }
  }
}
