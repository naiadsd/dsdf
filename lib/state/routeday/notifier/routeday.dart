import 'package:dsd/state/routeday/models/routeday.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/routeday.dart';

class RouteDayStateNotifier extends StateNotifier<RouteDay> {
  late SharedPreferences pref;

  Future _init() async {
    pref = await SharedPreferences.getInstance();
    var routeCode = pref.getInt('routeday');
    if (routeCode != null) {
      state.day = routeCode;
    }
  }

  RouteDayStateNotifier() : super(RouteDay.start()) {
    _init();
  }

  void setRoute(int routeday) {
    state = RouteDay(day: routeday);
  }
}
