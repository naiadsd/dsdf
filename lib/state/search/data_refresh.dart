import 'package:hooks_riverpod/hooks_riverpod.dart';

class DataRefresh extends StateNotifier<bool> {
  DataRefresh() : super(false);

  void setRefresh() {
    state = !state;
  }
}

final itemSearchProvider = StateNotifierProvider<DataRefresh, bool>(
  (ref) {
    return DataRefresh();
  },
);
