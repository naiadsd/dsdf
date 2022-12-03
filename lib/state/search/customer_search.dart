import 'package:hooks_riverpod/hooks_riverpod.dart';

class CustomerSearch extends StateNotifier<String> {
  CustomerSearch() : super('');

  void setSearchText(String text) {
    state = text;
  }
}

final customerSerachProvider = StateNotifierProvider<CustomerSearch, String>(
  (ref) {
    return CustomerSearch();
  },
);
