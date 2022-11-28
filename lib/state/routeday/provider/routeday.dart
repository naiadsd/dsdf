import 'package:dsd/state/routeday/models/routeday.dart';
import 'package:dsd/state/routeday/notifier/routeday.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final routeProvider =
    StateNotifierProvider<RouteDayStateNotifier, RouteDay>(((ref) {
  return RouteDayStateNotifier();
}));

final routeDayProvider = Provider<int>(((ref) {
  return ref.watch(routeProvider).day;
}));
