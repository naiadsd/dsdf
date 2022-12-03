import 'package:hooks_riverpod/hooks_riverpod.dart';

class ItemSearch extends StateNotifier<String> {
  ItemSearch() : super('');

  void setSearchText(String text) {
    state = text;
  }
}

final itemSearchProvider = StateNotifierProvider<ItemSearch, String>(
  (ref) {
    return ItemSearch();
  },
);
