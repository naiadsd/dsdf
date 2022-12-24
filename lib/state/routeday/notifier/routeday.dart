import 'package:dsd/state/routeday/models/routeday.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/data_service.dart';

class RouteDayP extends StateNotifier<int> {
  late SharedPreferences pref;

  Future _init() async {
    pref = await SharedPreferences.getInstance();
    var routeCode = pref.getInt('routeday');
    //  print('getting route day as $routeCode ');
    if (routeCode != null) {
      state = routeCode;
    }
  }

  RouteDayP() : super(0) {
    _init();
  }

  void setRouteDay(int routeday) async {
    state = routeday;
    pref = await SharedPreferences.getInstance();

    // await fetchStoreDailyData(1,routeday);

    pref.setInt('routeday', routeday);
  }
}
