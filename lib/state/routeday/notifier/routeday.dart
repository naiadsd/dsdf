import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RouteDayP extends StateNotifier<int> {
  late SharedPreferences pref;

  Future _init() async {
    pref = await SharedPreferences.getInstance();
    var routeCode = pref.getInt('routeday');

    if (routeCode != null) {
      state = routeCode;
    } else {}
  }

  RouteDayP() : super(0) {
    _init();
  }

  void setRouteDay(int routeday) async {
    state = routeday;
    pref = await SharedPreferences.getInstance();
    pref.setInt('routeday', routeday);
  }

  Future<int> getRouteDay() async {
    pref = await SharedPreferences.getInstance();
    int res;
    var routeDay = pref.getInt('routeday');

    if (routeDay != null) {
      state = routeDay;
      res = state;
    } else {
      res = 0;
      state = 0;
    }
    return res;
  }
}
