import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WeekRouteProvider extends StateNotifier<int> {
  late SharedPreferences pref;
  Future _init() async {
    pref = await SharedPreferences.getInstance();
    var weekRoute = pref.getInt('weekroute');

    if (weekRoute != null) {
      state = weekRoute;
    }
  }

  WeekRouteProvider() : super(0) {
    _init();
  }

  void setWeekRoute(int weekroute) async {
    state = weekroute;
    pref = await SharedPreferences.getInstance();
    pref.setInt('weekroute', weekroute);
  }

  Future<int> getWeekRoute() async {
    pref = await SharedPreferences.getInstance();
    int res;
    var weekroute = pref.getInt('weekroute');

    if (weekroute != null) {
      res = weekroute;
    } else {
      state = 0;
      res = 0;
    }
    return res;
  }
}
