import 'package:dsd/state/items/models/item.dart';
import 'package:flutter/material.dart';

@immutable
class ItemState {
  final List<Item>? items;
  final int totalRecords;
  final DateTime lastfetchedOn;

  const ItemState({
    required this.items,
    required this.totalRecords,
    required this.lastfetchedOn,
  });

  ItemState.unknown()
      : items = null,
        totalRecords = 0,
        lastfetchedOn = DateTime.now();

  ItemState loadState(List<Item> inItems) => ItemState(
        items: inItems,
        totalRecords: inItems.length,
        lastfetchedOn: DateTime.now(),
      );
}
