import 'package:dsd/state/items/backend/item_service.dart';
import 'package:dsd/state/items/models/item.dart';
import 'package:dsd/state/search/item_search.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

//api service provider
final itemProvider = Provider<ItemService>(
  (ref) => const ItemService(),
);

final itemDataProvider = FutureProvider<List<Item>>(
  (ref) {
    return ref.watch(itemProvider).fetchItems();
  },
);

final filterdItems = FutureProvider<List<Item>>(
  (ref) async {
    final searchText = ref.watch(itemSearchProvider);

    if (searchText.isNotEmpty) {
      var items = await ref.watch(itemProvider).fetchItems();

      return items
          .where((element) =>
              element.itemId.contains(searchText) ||
              element.description.contains(searchText) ||
              element.name.contains(searchText))
          .toList();
    } else {
      return ref.watch(itemProvider).fetchItems();
    }
  },
);
