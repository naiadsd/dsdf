import 'package:dsd/state/items/backend/item_service.dart';
import 'package:dsd/state/items/models/item.dart';
import 'package:dsd/state/items/models/item_state.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

@immutable
// ignore: must_be_immutable
class ItemStateNotifier extends StateNotifier<ItemState> {
  ItemStateNotifier() : super(ItemState.unknown()) {
    print('item state has been changed from item_notifer init');
    fetchItem();
  }

  Future<bool> fetchItem() async {
    print('item state has been changed from item_notifer');
    try {
      List<Item> itemsInDB = await fetchAllItemsFromDB();
      state = state.loadState(itemsInDB);
      return true;
    } catch (e) {
      // ignore: avoid_print
      print(e);
      return false;
    }
  }
}
