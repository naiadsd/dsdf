import 'package:dsd/state/items/models/item.dart';
import 'package:dsd/state/items/models/item_state.dart';
import 'package:dsd/state/items/notifier/item_notifier.dart';
import 'package:dsd/state/search/item_search.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final itemStaeProvider = StateNotifierProvider<ItemStateNotifier, ItemState>(
    ((ref) => ItemStateNotifier()));

final itemsLengthProvider = Provider<int>(((ref) {
  final itemProvider = ref.watch(itemStaeProvider);
  return itemProvider.totalRecords;
}));

final filterdItems = Provider<List<Item>?>(((ref) {
  final itemProvider = ref.watch(itemStaeProvider);
  var items = itemProvider.items;
  final searchText = ref.watch(itemSearchProvider);
  if (searchText.isNotEmpty) {
    return items!
        .where((element) => (element.itemId.contains(searchText) ||
            element.name.contains(searchText)))
        .toList();
  } else {
    return items;
  }
}));
