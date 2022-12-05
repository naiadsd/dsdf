import 'package:dsd/state/userinfo/provider/userdetails.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final currentRouteProvider = Provider<int>(
  (ref) {
    final userDetails = ref.watch(userDetailsProvider);
    return userDetails.route ?? 0;
  },
);
