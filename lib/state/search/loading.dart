import 'package:hooks_riverpod/hooks_riverpod.dart';

class Loading extends StateNotifier<bool> {
  Loading() : super(false);

  void setRefresh() {
    state = !state;
  }

  void turnOnLoading() {
    state = true;
  }

  void turnOffLoading() {
    state = false;
  }
}

final isloadingProvider = StateNotifierProvider<Loading, bool>(
  (ref) {
    return Loading();
  },
);
