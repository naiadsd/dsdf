import 'package:dsd/state/routeday/notifier/routeday.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final routeDayProvider = StateNotifierProvider<RouteDayP, int>(
  (ref) {
    return RouteDayP();
  },
);
