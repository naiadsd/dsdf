import 'package:dsd/state/week/notifier/week.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final weekRouteProvider = StateNotifierProvider<WeekRouteProvider, int>((ref) {
  return WeekRouteProvider();
});
