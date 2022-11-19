import 'package:dsd/state/items/backend/item_service.dart';
import 'package:dsd/state/items/models/item.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

//api service provider
final itemProvider = Provider<ItemService>(
  (ref) => const ItemService(),
);

final itemDataProvider = FutureProvider<List<Item>>(
  (ref) {
    return ref.read(itemProvider).fetchItems();
  },
);
