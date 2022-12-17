import 'package:dsd/state/routeday/models/routeday.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  void setRoute(int routeday) async {
    state = routeday;
    pref = await SharedPreferences.getInstance();
    pref.setInt('routeday', routeday);
    // print('settin route day as $routeday ');
  }
}
