// Final Global Variable which will expose the state.
// Should be outside of the class.

import 'package:dsd/state/connectivity/connectivity_notifier.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final connectivityStatusProviders =
    StateNotifierProvider<ConnectivityStatusNotifier, ConnectivityStatus>(
        (ref) {
  return ConnectivityStatusNotifier();
});
