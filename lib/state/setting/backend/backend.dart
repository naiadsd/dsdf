import 'dart:convert';

import 'package:dsd/state/setting/model/settings.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<bool> setLastSyncDateTime(DateTime dateTime) async {
  try {
    late SharedPreferences prefs;

    prefs = await SharedPreferences.getInstance();

    final sett = Settings(lastsyncDate: dateTime).toJson();

    prefs.setString('settings', json.encode(sett));

    return true;
  } catch (e) {
    return false;
  }
}

Future<Settings> getLastSyncDateTime() async {
  late SharedPreferences prefs;

  prefs = await SharedPreferences.getInstance();

  var sett = prefs.getString('settings');

  if (sett != null) {
    return Settings.fromJson(json.decode(sett));
  } else {
    return Settings(lastsyncDate: null);
  }
}

Future<bool> setLastSyncAsToday() async {
  return await setLastSyncDateTime(DateTime.now());
}
